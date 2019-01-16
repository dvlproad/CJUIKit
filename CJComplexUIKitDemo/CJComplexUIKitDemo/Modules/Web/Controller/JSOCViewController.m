//
//  JSOCViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "JSOCViewController.h"
#import "DemoButtonFactory.h"

@interface JSOCViewController () <WKScriptMessageHandler> {
    
}

@end

@implementation JSOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用OC", nil);
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"JSOC.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
    
    WKUserContentController *userContentController = [self.webView configuration].userContentController;
    [userContentController addScriptMessageHandler:self name:@"showWebText"];
}

// JS调用的OC回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"receiveScriptMessage.name = %@", message.name);// 方法名
    NSLog(@"receiveScriptMessage.body = %@", message.body);// 传递的数据
    
    if ([message.name isEqualToString:@"showWebText"]) {
        [CJToast shortShowMessage:message.body];
    }
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
