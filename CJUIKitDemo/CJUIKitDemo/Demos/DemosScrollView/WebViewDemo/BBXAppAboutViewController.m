//
//  BBXAppAboutViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BBXAppAboutViewController.h"

static NSString *const BBXAPPAboutRquestUrl = @"http://www.bbxpc.com/app_html/about_us/about.html";

@interface BBXAppAboutViewController ()

@end

@implementation BBXAppAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.requestUrl = BBXAPPAboutRquestUrl;
    
    [self reloadNetworkWeb];
    
    self.webViewDidFinishNavigationBlcok = ^(WKWebView *webView) {
        if ([webView.URL.absoluteString isEqualToString:BBXAPPAboutRquestUrl]) {
            //http://www.cnblogs.com/gchlcc/p/6154844.html
            NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSString *jsString = [NSString stringWithFormat:@"setEdition('V%@')", appVersion];
            [webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
                NSLog(@"执行完成");
            }];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
