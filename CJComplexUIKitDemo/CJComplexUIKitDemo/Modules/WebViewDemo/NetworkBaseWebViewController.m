//
//  NetworkBaseWebViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "NetworkBaseWebViewController.h"
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "AppInfoManager.h"
#import "DataEmptyViewFactory.h"
#import "UIScrollView+CJAddFillView.h"

@interface NetworkBaseWebViewController ()

@end

@implementation NetworkBaseWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadNetworkWebWithUrl:@"dd"];
    //[self reloadNetworkWebWithUrl:self.networkUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    self.todoProgressColor = [UIColor yellowColor];
    self.doneProgressColor = [UIColor blueColor];
    self.progressHeight = 10;
    
    
    /* 设置空白页相关方法 */
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    
    [self setupShowEmptyViewBlock:^(NSString *message) {
        self.emptyView.message = message;
        self.emptyView.hidden = NO;
        
    } hideEmptyViewBlock:^{
        self.emptyView.hidden = YES;
    }];
}

- (CJDataEmptyView *)emptyView {
    if (_emptyView == nil) {
        __weak typeof(self)weakSelf = self;
        /// TODO:
        _emptyView = [DataEmptyViewFactory networkEmptyViewWithSuccess:^{
            NSString *requestUrl = self.networkUrl;
            [weakSelf reloadNetworkWebWithUrl:requestUrl];
        }];
        _emptyView.hidden = YES;
    }
    
    return _emptyView;
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
