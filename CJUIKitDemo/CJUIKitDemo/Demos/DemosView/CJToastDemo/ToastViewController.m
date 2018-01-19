//
//  ToastViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ToastViewController.h"
#import "ModuleModel.h"

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
            ModuleModel *toastModule = [[ModuleModel alloc] init];
            toastModule.title = @"直接显示";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            ModuleModel *toastModule = [[ModuleModel alloc] init];
            toastModule.title = @"菊花显示（系统）";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            ModuleModel *toastModule = [[ModuleModel alloc] init];
            toastModule.title = @"菊花显示（MBProgressHUD）";
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
    ModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
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
            [self.activityIndicator startAnimating];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //耗时的操作
                sleep(2);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //更新界面
                    [self.activityIndicator stopAnimating];
                });
            });
            
        } else if (indexPath.row == 2) {
            NSString *registeringText = NSLocalizedString(@"正在注册", nil);
            MBProgressHUD *registerStateHUD = [CJToast createChrysanthemumHUDWithMessage:registeringText toView:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //耗时的操作
                sleep(2);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //更新界面
                    BOOL isSuccess  = rand()%3;
                    if (isSuccess) {
                        [registerStateHUD hideAnimated:YES afterDelay:0];
                    } else {
                        NSString *registerFailureMessage = NSLocalizedString(@"注册失败", nil);
                        registerStateHUD.label.text = registerFailureMessage;
                        registerStateHUD.mode = MBProgressHUDModeText;
                        [registerStateHUD hideAnimated:YES afterDelay:1];
                    }
                });
            });
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
