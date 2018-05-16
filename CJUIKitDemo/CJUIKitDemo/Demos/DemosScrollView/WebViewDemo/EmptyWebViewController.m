//
//  EmptyWebViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "EmptyWebViewController.h"
#import "AppInfoManager.h"

static NSString *const BeyondAPPRquestUrl = @"https://fir.im/9u12";
static NSString *const BBXAPPAboutRquestUrl = @"http://www.bbxpc.com/app_html/about_us/about.html";

@interface EmptyWebViewController ()

@end

@implementation EmptyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
//    [self reloadLocalWebWithUrl:localHtmlUrl];
    
    
    //NSString *requestUrl = @"https://fir.im/9u12";  //BeyondApp
    NSString *requestUrl = @"http://www.bbxpc.com/app_html/about_us/about.html";  //BBXAPPAbout
    
    BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
    networkEnable = NO;
    [self reloadNetworkWebWithUrl:requestUrl networkEnable:networkEnable];
    [self setupBlockWithRequestUrl:requestUrl networkEnable:networkEnable];
    
    self.webViewDidFinishNavigationBlcok = ^(WKWebView *webView) {
        if ([webView.URL.absoluteString isEqualToString:requestUrl]) {
            //http://www.cnblogs.com/gchlcc/p/6154844.html
            NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSString *jsString = [NSString stringWithFormat:@"setEdition('V%@')", appVersion];
            [webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
                NSLog(@"执行完成");
            }];
        }
    };
}

- (void)setupBlockWithRequestUrl:(NSString *)requestUrl networkEnable:(BOOL)networkEnable
{
    //显示空白页的方法
    void (^showEmptyViewBlock)(NSString *message) = ^ (NSString *message) {
        if (self.emptyView == nil) {
            DemoEmptyView *emptyView = [[DemoEmptyView alloc] initWithFrame:CGRectZero];
            emptyView.image = [UIImage imageNamed:@"currency_icon_network"];
            emptyView.title = NSLocalizedString(@"数据加载失败，请重新加载...", nil);
            emptyView.buttonTitle = NSLocalizedString(@"刷新", nil);
            [self.view addSubview:emptyView];
            [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top.bottom.mas_equalTo(self.view);
            }];
            
            __weak typeof(self)weakSelf = self;
            emptyView.reloadBlock = ^{
                [weakSelf reloadNetworkWebWithUrl:requestUrl
                                    networkEnable:networkEnable];
                //[weakSelf reloadLocalWebWithUrl:requestUrl];
            };
            
            self.emptyView = emptyView;
        }
        
        self.emptyView.message = message;
        self.emptyView.hidden = NO;
    };
    
    //隐藏空白页的方法
    void (^hideEmptyViewBlock)(void) = ^ (void) {
        self.emptyView.hidden = YES;
    };
    [self setupShowEmptyViewBlock:showEmptyViewBlock hideEmptyViewBlock:hideEmptyViewBlock];
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
