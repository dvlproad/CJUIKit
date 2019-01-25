//
//  H5ImgSettingPathViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgSettingPathViewController.h"
#import "DemoCacheUtil.h"

@implementation H5ImgSettingPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5的图片设置之①传路径给H5", nil);
}

- (void)updateH5Img:(NSData *)compressImageData {
    //方法①:OC执行JS--设置图片(通过上传图片地址)
    [DemoCacheUtil saveImageData:compressImageData forModuleType:DemoModuleTypeIot callback:^(NSString *absoluteImagePath, NSString *imageName) {
        [self updateH5ImgWithImagePath:absoluteImagePath imageName:imageName];
    }];
}

- (void)updateH5ImgWithImagePath:(NSString *)absoluteImagePath imageName:(NSString *)imageName {
    // 使用setImageWithPath1测试通过(模拟器上OK，真机上好像有问题)
    NSString *imgSrc = absoluteImagePath;
    //imgSrc = [[NSBundle mainBundle] pathForResource:@"add_red_Big" ofType:@"png"];
    
    NSString *jsString = [NSString stringWithFormat:@"js_updateH5ImgSrc('%@', '%@')", imgSrc, imageName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"OC执行JS完成--设置图片(通过上传图片地址)");
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
