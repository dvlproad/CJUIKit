//
//  H5ImgInterceptChooseViewController.m
//  CJHookDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgInterceptChooseViewController.h"
#import "UIViewController+CJHookPresent.h"

@interface H5ImgInterceptChooseViewController () {
    
}

@end

@implementation H5ImgInterceptChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5选择的系统照片拦截--②拦截选择", nil);
    
    self.networkUrl = @"http://gif.55.la/";
    self.cjShouldHookFileUploadPanelPresent = YES;
}

- (void)cjHook_onFileInputClicked {
    [CJToast shortShowMessage:@"Congratulation：H5正在直接调用相册,被我拦截了"];
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
