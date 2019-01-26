//
//  H5ImgSettingBaseViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgSettingBaseViewController.h"
#import "DemoButtonFactory.h"
#import <CJMedia/MySingleImagePickerController.h>
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#import <CJBaseUIKit/UIImage+CJBase64.h>

@interface H5ImgSettingBaseViewController () <WKScriptMessageHandler> {
    
}

@end

@implementation H5ImgSettingBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5的图片设置", nil);
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"H5ImgSetting.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
    
    WKUserContentController *userContentController = [self.webView configuration].userContentController;
    [userContentController addScriptMessageHandler:self name:@"getAppPhoto"];
}

// JS调用的OC回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"receiveScriptMessage.name = %@", message.name);// 方法名
    NSLog(@"receiveScriptMessage.body = %@", message.body);// 传递的数据
    
    if ([message.name isEqualToString:@"getAppPhoto"]) {
        [self showCamera];
    }
}

- (void)showCamera {
    MySingleImagePickerController *imagePickerController = [[MySingleImagePickerController alloc] init];
    [imagePickerController pickImageFinishBlock:^(UIImage *image) {
        [self dealOriginImage:image];
    } pickVideoFinishBlock:^(UIImage *firstImage) {
        
    } pickCancelBlock:^{
        
    }];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)dealOriginImage:(UIImage *)originImage {
    NSData *compressImageData = [originImage cj_compressWithMaxDataLength:40.0f * 1024.0f]; //40k
    NSLog(@"压缩后数据大小:%.4f MB",(double)compressImageData.length/1024.0f/1024.0f);
    [self updateH5Img:compressImageData];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
