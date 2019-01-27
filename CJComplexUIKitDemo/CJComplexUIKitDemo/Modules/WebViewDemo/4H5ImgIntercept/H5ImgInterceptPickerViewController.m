//
//  H5ImgInterceptPickerViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgInterceptPickerViewController.h"
#import "UIImagePickerController+CJHookFileUploadPanel.h"

@interface H5ImgInterceptPickerViewController () {
    
}

@end

@implementation H5ImgInterceptPickerViewController

- (void)dealloc{
    [UIImagePickerController unHookDelegate];
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    [UIImagePickerController unHookDelegate];
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//    [UIImagePickerController hookDelegate];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5选择的系统照片拦截--②拦截图片", nil);
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"H5ImgPickerIntercept.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
    
    [UIImagePickerController hookDelegate];
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
