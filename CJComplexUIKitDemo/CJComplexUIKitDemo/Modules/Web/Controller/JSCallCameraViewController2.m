//
//  JSCallCameraViewController2.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "JSCallCameraViewController2.h"
#import "DemoButtonFactory.h"
#import <CJMedia/MySingleImagePickerController.h>
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#import <CJBaseUIKit/UIImage+CJBase64.h>
#import "DemoCacheUtil.h"

@interface JSCallCameraViewController2 () <WKUIDelegate, WKNavigationDelegate> {
    
}

@end

@implementation JSCallCameraViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用系统相册(网页版)", nil);
    
    self.networkUrl = @"http://gif.55.la/";
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
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
