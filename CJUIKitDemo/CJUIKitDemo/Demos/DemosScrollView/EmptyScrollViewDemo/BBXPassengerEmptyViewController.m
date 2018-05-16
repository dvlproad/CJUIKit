//
//  BBXPassengerEmptyViewController.m
//  CJUIKitDemo
//
//  Created by lichq on 2018/4/26.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BBXPassengerEmptyViewController.h"
#import "DemoEmptyView.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import "AppInfoManager.h"

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BBXPassengerEmptyViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) DemoEmptyView *emptyView;

@property (nonatomic, assign, readonly) BOOL isNetworkWeb;   /**< 是否是网络网页，否则是本地网页 */

@end

@implementation BBXPassengerEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addScrollView];
//    self.scrollView.emptyDataSetSource = self;
//    self.scrollView.emptyDataSetDelegate = self;
//    [self.scrollView reloadEmptyDataSet];
    
    //*
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.emptyView.hidden = NO;
    //*/
}

- (void)addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.scrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.bottom.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView.mas_width);
        make.height.mas_equalTo(scrollView.mas_height).mas_offset(1);
    }];
    self.containerView = containerView;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyView;
}


- (void)reloadNetworkWeb {
    _isNetworkWeb = YES;
    
    //BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
    BOOL networkEnable = NO;
    if (!networkEnable) {
        [SVProgressHUD show];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                NSString *failureMessage = NSLocalizedString(@"请检查您的手机是否联网", nil);
                self.emptyView.message = failureMessage;
                self.emptyView.hidden = NO;
            });
        });
        return;
    }
    
    //通过URL，创建Request并加载
//    NSURL *URL = [NSURL URLWithString:self.requestUrl];;
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [self.webView loadRequest:request];
}

#pragma mark - LazyLoad
- (DemoEmptyView *)emptyView {
    if (_emptyView == nil) {
        DemoEmptyView *emptyView = [[DemoEmptyView alloc] init];
        emptyView.image = [UIImage imageNamed:@"currency_icon_network"];
        emptyView.title = NSLocalizedString(@"数据加载失败，请重新加载...", nil);
        emptyView.buttonTitle = NSLocalizedString(@"刷新", nil);
        emptyView.reloadBlock = ^{
            [self reloadNetworkWeb];
        };
        
        _emptyView = emptyView;
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
