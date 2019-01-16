//
//  NetworkBaseWebViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "NetworkBaseWebViewController.h"
#import "AppInfoManager.h"

@interface NetworkBaseWebViewController ()

@end

@implementation NetworkBaseWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *requestUrl = self.networkUrl;
    
    BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
    [self reloadNetworkWebWithUrl:requestUrl networkEnable:networkEnable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    self.todoProgressColor = [UIColor yellowColor];
    self.doneProgressColor = [UIColor blueColor];
    self.progressHeight = 10;
    
    /* 设置空白页相关方法 */
    // 显示空白页的方法
    void (^showEmptyViewBlock)(NSString *message) = ^ (NSString *message) {
        if (self.emptyView == nil) {
            CJDataEmptyView *emptyView = [[CJDataEmptyView alloc] initWithFrame:CGRectZero];
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
                NSString *requestUrl = self.networkUrl;
                BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
                [weakSelf reloadNetworkWebWithUrl:requestUrl
                                    networkEnable:networkEnable];
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
