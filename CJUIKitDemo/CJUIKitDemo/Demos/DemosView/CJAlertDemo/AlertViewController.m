//
//  AlertViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "AlertViewController.h"
#import "CJModuleModel.h"

#import "CJAlert.h"
#import "CJAlertView.h"

typedef NS_ENUM(NSUInteger, BBXBusQRCodeStatus) {
    BBXBusQRCodeStatusUnkonwn,
    BBXBusQRCodeStatusNoFound,          /**< 无效：系统找不到该车票 */
    BBXBusQRCodeStatusInvalidFlight,    /**< 无效：班次不符 */
    BBXBusQRCodeStatusInvalidStation,   /**< 无效：站点不符 */
    BBXBusQRCodeStatusUsed,             /**< 无效：已检票 */
    BBXBusQRCodeStatusValid,            /**< 检票有效，提示是否确认上车 */
};

@interface AlertViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end


@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Alert首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIAlertController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIAlertController";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message (系统UIAlertController)";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //以下几个为自定义的View
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的View";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK & Cancel";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & OK & Cancel";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK & Cancel";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    //以下几个为自定义的View
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的View";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK & Cancel";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK & Cancel";
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

- (void)cancelButtonAction:(UIButton *)button {
    NSLog(@"点击了取消按钮");
    [button cj_hidePopupView];
}

- (void)okButtonAction:(UIButton *)button {
    NSLog(@"点击了确认按钮");
    [button cj_hidePopupView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    //alertActionModel
    CJAlertActionModel *cancelAlertActionModel = [[CJAlertActionModel alloc] init];
    cancelAlertActionModel.title = NSLocalizedString(@"取消", nil);
    cancelAlertActionModel.style = UIAlertActionStyleCancel;
    cancelAlertActionModel.handler = ^(UIAlertAction *action) {
        NSLog(@"取消");
    };
    
    CJAlertActionModel *okAlertActionModel = [[CJAlertActionModel alloc] init];
    okAlertActionModel.title = NSLocalizedString(@"确认", nil);
    okAlertActionModel.style = UIAlertActionStyleDefault;
    okAlertActionModel.handler = ^(UIAlertAction *action) {
        NSLog(@"确认");
    };
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundColor:[UIColor clearColor]];
    [okButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *title = NSLocalizedString(@"提示", nil);
            NSString *message = NSLocalizedString(@"您确认退出吗？", nil);
            NSArray *alertActionModels = @[cancelAlertActionModel, okAlertActionModel];
            [CJAlert showAlertTypeAlertControllerWithTitle:title
                                message:message
                      alertActionModels:alertActionModels
                       inViewController:self];
            
        }
        
    } else if (indexPath.section == 1) {
        BBXBusQRCodeStatus qrCodeStatus = indexPath.row + 1;
        
        if (qrCodeStatus == BBXBusQRCodeStatusValid) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 160);
            UIImage *flagImage = nil;
            NSString *title = NSLocalizedString(@"乘客上车站为\n【厦门市软件园二期】\n是否本站上车？", nil);
            NSString *message = nil;
            NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
            NSString *okButtonTitle = NSLocalizedString(@"确认", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (qrCodeStatus == BBXBusQRCodeStatusNoFound) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"无效二维码，系统找不到该车票", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (qrCodeStatus == BBXBusQRCodeStatusInvalidFlight) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"班次不符，请核对车票信息", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (qrCodeStatus == BBXBusQRCodeStatusInvalidStation) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"上车站点不符，应上车站点：\n【厦门软件园二期观日路站】", nil);
            NSString *cancelButtonTitle = NSLocalizedString(@"我知道了", nil);
            NSString *okButtonTitle = NSLocalizedString(@"允许上车", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (qrCodeStatus == BBXBusQRCodeStatusUsed) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"已检票", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
        }
        
        if (indexPath.row == 5) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 230);
            UIImage *flagImage = nil;
            NSString *title = NSLocalizedString(@"请先结束未完成行程才能发车", nil);
            
            NSString *flightNo = @"班次：BCD 12345";
            NSString *disptachTime = @"出发时间：2018-04-20 11:00";
            NSString *startStation = @"厦门市软件园二期";
            NSString *endStation = @"漳州市万达广场";
            NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", flightNo, disptachTime, startStation, endStation];
            NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
            NSString *okButtonTitle = NSLocalizedString(@"结束行程", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle  cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
        }
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 230);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"上车站点不符，应上车站点：\n【厦门软件园二期观日路站】", nil);
            NSString *cancelButtonTitle = NSLocalizedString(@"我知道了", nil);
            NSString *okButtonTitle = NSLocalizedString(@"允许上车", nil);
            
            CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize];
            [alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
            [alertView addTitle:title font:[UIFont systemFontOfSize:18.0] textAlignment:NSTextAlignmentCenter margin:20];
            [alertView addMessage:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20];
            [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (indexPath.row == 1) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
            NSString *title = NSLocalizedString(@"未通过", nil);
            NSString *message = NSLocalizedString(@"班次不符，请核对车票信息", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
            
        } else if (indexPath.row == 2) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 150);
            NSString *title = NSLocalizedString(@"友情提示", nil);
            NSString *message = NSLocalizedString(@"您当前处于离线状态，请检查您的网络", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize];
            [alertView addTitle:title font:[UIFont systemFontOfSize:18.0] textAlignment:NSTextAlignmentCenter margin:20];
            [alertView addMessage:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20];
            [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
        }
        
        if (indexPath.row == 3) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            NSString *title = NSLocalizedString(@"请先结束未完成行程才能发车", nil);
            
            NSString *flightNo = @"班次：BCD 12345";
            NSString *disptachTime = @"出发时间：2018-04-20 11:00";
            NSString *startStation = @"厦门市软件园二期";
            NSString *endStation = @"漳州市万达广场";
            NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", flightNo, disptachTime, startStation, endStation];
            NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
            NSString *okButtonTitle = NSLocalizedString(@"结束行程", nil);
            
            CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize];
            [alertView addTitle:title font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20];
            [alertView addMessage:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentLeft margin:20];
            [alertView addMessageLabelBoderWithWidth:0.5];
            [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle  cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView show];
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
