//
//  ToastViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ToastViewController.h"
#import "CJModuleModel.h"

#import "CJToast.h"

@interface ToastViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation ToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Toast首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Toast
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Toast相关";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"直接显示";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"灰底黑字，2秒后自动消失";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"黑底白字，2秒后自动消失";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"自定义视图";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"测试使用\n换行是否有效";
            //toastModule.classEntry = [UIViewController class];
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
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"菊花显示1（MBProgressHUD）--上下";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"菊花显示2（MBProgressHUD）--左右";
            //toastModule.classEntry = [UIViewController class];
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

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [CJToast shortShowMessage:@"测试" image:[UIImage imageNamed:@"icon.png"] toView:self.view];
        } else if (indexPath.row == 1) {
            [CJToast shortShowMessage:@"灰底黑字，2秒后自动消失"];
             
        } else if (indexPath.row == 2) {
            [CJToast shortShowWhiteMessage:@"黑底白字，2秒后自动消失"];
            
        } else if (indexPath.row == 3) {
            [CJToast shortShowMessage:@"在指定的view上显示文字，并在delay秒后自动消失\n换行是否有效"
                               inView:self.view
                   withLabelTextColor:[UIColor redColor]
                       bezelViewColor:[UIColor greenColor]
                       hideAfterDelay:2];
            
        } else if (indexPath.row == 4) {
            [CJToast shortShowMessage:@"第一行\n换行是否有效"
                               inView:self.view
                   withLabelTextColor:[UIColor redColor]
                       bezelViewColor:[UIColor greenColor]
                       hideAfterDelay:2];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.activityIndicator startAnimating];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
            });
            
        } else if (indexPath.row == 1) {
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
            
        } else if (indexPath.row == 2) {
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
    }
}

- (IBAction)showToast:(id)sender {
    
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
