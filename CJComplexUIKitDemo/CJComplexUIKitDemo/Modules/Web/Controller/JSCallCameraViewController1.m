//
//  JSCallCameraViewController1.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "JSCallCameraViewController1.h"
#import "DemoButtonFactory.h"
#import <CJMedia/MySingleImagePickerController.h>
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#import <CJBaseUIKit/UIImage+CJBase64.h>
#import "DemoCacheUtil.h"

@interface JSCallCameraViewController1 () <WKScriptMessageHandler> {
    
}

@end

@implementation JSCallCameraViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用系统相册(本地版)", nil);
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"JSCallCamera.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
    
    WKUserContentController *userContentController = [self.webView configuration].userContentController;
    [userContentController addScriptMessageHandler:self name:@"showCamera"];
}

// JS调用的OC回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"receiveScriptMessage.name = %@", message.name);// 方法名
    NSLog(@"receiveScriptMessage.body = %@", message.body);// 传递的数据
    
    if ([message.name isEqualToString:@"showCamera"]) {
        [CJToast shortShowMessage:message.body];
        [self showCamera];
    }
}

- (void)showCamera {
    MySingleImagePickerController *imagePickerController = [[MySingleImagePickerController alloc] init];
    [imagePickerController pickImageFinishBlock:^(UIImage *image) {
        [self dealAndUploadImage:image];
    } pickVideoFinishBlock:^(UIImage *firstImage) {
        
    } pickCancelBlock:^{
        
    }];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)dealAndUploadImage:(UIImage *)image {
    NSData *compressImageData = [image cj_compressWithMaxDataLength:40.0f * 1024.0f]; //40k
    NSLog(@"压缩后数据大小:%.4f MB",(double)compressImageData.length/1024.0f/1024.0f);
    
    NSString *imageName = @"1.png";
    // 方法①:OC执行JS--设置图片(通过上传图片地址)
    [DemoCacheUtil saveImageData:compressImageData withImageName:imageName callback:^(NSString * _Nonnull absoluteImagePath) {
        [self use1UploadImagePath:absoluteImagePath imageName:imageName];
        //[self use2UploadImagePath:absoluteImagePath imageName:imageName];
    }];
    
    // 方法②:OC执行JS--设置图片(通过上传图片数据)
//    [self useUploadImageData:compressImageData imageName:imageName];
    
}

- (void)use1UploadImagePath:(NSString *)imagePath imageName:(NSString *)imageName {
    // 使用setImageWithPath1测试通过
    NSString *jsString = [NSString stringWithFormat:@"setImageWithPath1('%@', '%@')", imagePath, imageName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"OC执行JS完成--设置图片(通过上传图片地址)");
    }];
}

- (void)use2UploadImagePath:(NSString *)imagePath imageName:(NSString *)imageName {
    //使用setImageWithPath2 ///FIXME:测试没通过
    NSDictionary *imageDictionary = @{@"imagePath": imagePath,
                                      @"imageName": imageName};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imageDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsString = [NSString stringWithFormat:@"setImageWithPath2('%@')", jsonString];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"OC执行JS完成--设置图片(通过上传图片地址)");
    }];
}

- (void)useUploadImageData:(NSData *)compressImageData imageName:(NSString *)imageName {
    //NSString *imageSrc = @"data:image/png;base64,%E3%80%80iVBORw0KGgoAAAANSUhEUgAAAAEAAAAkCAYAAABIdFAMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHhJREFUeNo8zjsOxCAMBFB/%E3%80%80KEAUFFR0Cbng3nQPw68ArZdAlOZppPFIBhH5EAB8b+Tlt9MYQ6i1BuqFaq1CKSVcxZ2Acs6406KUgpt5/%E3%80%80LCKuVgz5BDCSb13ZO99ZOdcZGvt4mJjzMVKqcha68iIePB86GAiOv8CDADlIUQBs7MD3wAAAABJRU5ErkJggg%3D%3D"; //将这些字符复制黏贴到Safari的地址栏中并转到，就能看到它了，一张1X36的白灰png图片。
    
    //UIImage *compressImage = [UIImage imageWithData:compressImageData];
    //NSString *imageBase64String = [compressImage cj_imageTobase64];
    NSString *imageBase64String = [compressImageData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    NSString *imageSrc = [NSString stringWithFormat:@"data:image/png;base64,%@", imageBase64String]; //可将imageSrc整串放入浏览器地址来验证imageSrc是否正确
    
    NSString *jsString = [NSString stringWithFormat:@"setImageWithPath1('%@', '%@')", imageSrc, imageName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"OC执行JS完成--设置图片(通过上传图片数据)");
    }];
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
