//
//  H5ImgInterceptViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgInterceptViewController.h"
#import "UIViewController+CJHookPresent.h"

@interface H5ImgInterceptViewController () {
    
}

@end

@implementation H5ImgInterceptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用系统相册(网页版-拦截)", nil);
    
    self.networkUrl = @"http://gif.55.la/";
    self.shouldHookFileUploadPanel = YES;
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
