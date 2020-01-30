//
//  TSHUDViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSHUDViewController.h"
#import <CJBaseEffectKit/CJMJRefreshNormalHeader.h>
#import "TestProgressHUDViewController.h"
#import "TestHUDHomeViewController.h"
#import "UIViewController+CJProgressHUD.h"

@interface TSHUDViewController ()  {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation TSHUDViewController

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
    
    //ProgressHUD
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"ProgressHUD";
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"测试2秒后自动消失";
            hudModule.selector = @selector(testShowProgressHUD);
            [sectionDataModel.values addObject:hudModule];
        }
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"测试网路延迟时候，消失页面中的HUD是否消失";
            hudModule.selector = @selector(testDoubleProgressHUD);
            [sectionDataModel.values addObject:hudModule];
        }
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"测试网路延迟时候，不显示页面中的HUD是否消失";
            hudModule.classEntry = [TestHUDHomeViewController class];
            [sectionDataModel.values addObject:hudModule];
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

- (void)testShowProgressHUD {
    [self cj_showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cj_dismissProgressHUD];
    });
}

- (void)testDoubleProgressHUD {
    TestProgressHUDViewController *viewController = [[TestProgressHUDViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
