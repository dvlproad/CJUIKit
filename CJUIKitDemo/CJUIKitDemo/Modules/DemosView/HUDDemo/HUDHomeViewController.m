//
//  HUDHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "HUDHomeViewController.h"
#import <LuckinBaseEffectKit/CJMJRefreshNormalHeader.h>
#import "SingleHUDViewController.h"
#import "SelfHUDDismissViewController.h"
#import "UIViewController+CQProgressHUD.h"

@interface HUDHomeViewController ()  {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation HUDHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"HUD首页", nil);
    
    CJMJRefreshNormalHeader *header = [CJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_header = header;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // SingleHUD
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"SingleHUD相关";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"CJProgressHUD对象的单个使用";
            module.classEntry = [SingleHUDViewController class];
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // SelfHUD
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"SelfHUD相关";
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"SelfHUD的显示(2秒后自动消失)";
            hudModule.actionBlock = ^{
                [self cq_showProgressHUD];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cq_dismissProgressHUD];
                });
            };
            [sectionDataModel.values addObject:hudModule];
        }
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"SelfHUD的消失(进入测试在某页面请求到网络前离开，之前的HUD是否消失)";
            hudModule.classEntry = [SelfHUDDismissViewController class];
            [sectionDataModel.values addObject:hudModule];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"SelfHUD被多个请求调用";
            module.selector = @selector(testSelfHUDForMoreRequest);
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
    
    /* 添加系统菊花 */
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    //activityIndicator.color = [UIColor redColor];
    //activityIndicator.backgroundColor = [UIColor cyanColor];
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    //activityIndicator.frame= CGRectMake(0, 0, 100, 100);
    activityIndicator.center = self.tableView.center;
    self.activityIndicator = activityIndicator;
}


- (void)testSelfHUDForMoreRequest {
    NSLog(@"-----------------------");
    NSLog(@"测试多个请求调用了HUD--开始");
    //第一个请求HUD显示2秒
    [self cq_showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cq_dismissProgressHUD];
        NSLog(@"测试多个请求调用了HUD--dismiss--1");
    });
    
    //第二个请求HUD显示5秒（加上第二个请求与第一个请求之间的时间差，则第一加第二请求至少要执行2+5-1=6秒）
    sleep(1);
    [self cq_showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cq_dismissProgressHUD];
        NSLog(@"测试多个请求调用了HUD--dismiss--2");
    });
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
