//
//  ToastViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ToastViewController.h"
#import <CJBaseUIKit/CJToast.h>

@interface ToastViewController ()  {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation ToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Toast首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Toast
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Toast相关";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"直接显示";
            toastModule.actionBlock = ^{
                [CJToast shortShowMessage:@"测试" image:[UIImage imageNamed:@"icon.png"] toView:self.view];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"灰底黑字，2秒后自动消失";
            toastModule.actionBlock = ^{
                [CJToast shortShowMessage:@"灰底黑字，2秒后自动消失"];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"黑底白字，2秒后自动消失";
            toastModule.actionBlock = ^{
                [CJToast shortShowWhiteMessage:@"黑底白字，2秒后自动消失"];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"自定义视图";
            toastModule.actionBlock = ^{
                [CJToast shortShowMessage:@"在指定的view上显示文字，并在delay秒后自动消失\n换行是否有效"
                                   inView:self.view
                       withLabelTextColor:[UIColor redColor]
                           bezelViewColor:[UIColor greenColor]
                           hideAfterDelay:2];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"测试使用\n换行是否有效";
            toastModule.actionBlock = ^{
                [CJToast shortShowMessage:@"第一行\n换行是否有效"
                                   inView:self.view
                       withLabelTextColor:[UIColor redColor]
                           bezelViewColor:[UIColor greenColor]
                           hideAfterDelay:2];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //Toast
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Toast相关-菊花";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"菊花显示（系统）";
            toastModule.selector = @selector(showSystemActivityIndicator);
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"菊花显示1（MBProgressHUD）--上下";
            toastModule.selector = @selector(showCustomActivityIndicator);
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"菊花显示2（MBProgressHUD）--左右";
            toastModule.selector = @selector(showCustomActivityIndicator2);
            [sectionDataModel.values addObject:toastModule];
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

- (void)showSystemActivityIndicator {
    [self.activityIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
    });
}

- (void)showCustomActivityIndicator {
    NSString *registeringText = NSLocalizedString(@"正在注册中，请稍等...", nil);
    MBProgressHUD *registerStateHUD = [CJToast createChrysanthemumHUDWithMessage:registeringText toView:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL isSuccess  = rand()%3;
        if (isSuccess) {
            [registerStateHUD hideAnimated:YES afterDelay:0];
        } else {
            NSString *registerFailureMessage = NSLocalizedString(@"注册成功", nil);
            registerStateHUD.label.text = registerFailureMessage;
            registerStateHUD.mode = MBProgressHUDModeText;
            [registerStateHUD hideAnimated:YES afterDelay:1];
        }
    });
}

- (void)showCustomActivityIndicator2 {
//            TODO:
//            NSString *registeringText = NSLocalizedString(@"照片识别中，请稍等...", nil);
//            MBProgressHUD *registerStateHUD = [CJToast createChrysanthemumHUDWithRightMessage:registeringText toView:nil];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                BOOL isSuccess  = rand()%3;
//                if (isSuccess) {
//                    [registerStateHUD hideAnimated:YES afterDelay:0];
//                } else {
//                    NSString *registerFailureMessage = NSLocalizedString(@"识别成功", nil);
//                    registerStateHUD.label.text = registerFailureMessage;
//                    registerStateHUD.mode = MBProgressHUDModeText;
//                    [registerStateHUD hideAnimated:YES afterDelay:1];
//                }
//            });
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
