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

#import "TestDataUtil.h"
#import "CJConvertUtil.h"
#import "CJIndentedStringUtil.h"
#import "NSDictionary+CJConvert.h"

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
    
    //DebugView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"DebugView";
        {
            CJModuleModel *debugViewModule = [[CJModuleModel alloc] init];
            debugViewModule.title = @"Debug appInfo";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:debugViewModule];
        }
        {
            CJModuleModel *debugViewModule = [[CJModuleModel alloc] init];
            debugViewModule.title = @"Debug Request(NSDictionary)";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:debugViewModule];
        }
        {
            CJModuleModel *debugViewModule = [[CJModuleModel alloc] init];
            debugViewModule.title = @"Debug Model";
            //toastModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:debugViewModule];
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

- (void)showUIAlertController:(UIAlertControllerStyle)preferredStyle {
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(@"您确认退出吗？", nil);
    
    UIAlertAction *cancelAlertAction =
    [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil)
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * _Nonnull action) {
                               NSLog(@"取消");
                           }];
    
    UIAlertAction *okAlertAction =
    [UIAlertAction actionWithTitle:NSLocalizedString(@"确认", nil)
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
                               NSLog(@"确认");
                           }];
    
    NSArray *alertActions = @[cancelAlertAction, okAlertAction];
    
    if (preferredStyle == UIAlertControllerStyleActionSheet) {
        [CJAlert showSheetTypeAlertControllerWithTitle:title
                                               message:message
                                          alertActions:alertActions
                                      inViewController:self];
    } else {
        [CJAlert showAlertTypeAlertControllerWithTitle:title
                                               message:message
                                          alertActions:alertActions
                                      inViewController:self];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
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
            [self showUIAlertController:UIAlertControllerStyleAlert];
        } else if (indexPath.row == 1) {
            [self showUIAlertController:UIAlertControllerStyleActionSheet];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *stationName = @"厦门市软件园二期";
            [self showInvalidStationAlertForStationName:stationName];
            
        } else if (indexPath.row == 1) {
            [self showInvalidFlightAlert];
            
        } else if (indexPath.row == 2) {
            NSString *stationName = @"厦门市软件园二期";
            [self checkAllowGetOnAtStationName:stationName];
            
        } else if (indexPath.row == 3) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 180);
            NSString *title = NSLocalizedString(@"友情提示", nil);
            NSString *message = NSLocalizedString(@"您当前处于离线状态，请检查您的网络", nil);
            NSString *cancelButtonTitle = nil;
            NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
            
            CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:15 secondVerticalInterval:10 thirdVerticalInterval:10 bottomVerticalInterval:10];
            [alertView addTitleWithText:title font:[UIFont systemFontOfSize:18.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.lineSpacing = 4;
            [alertView addMessageWithText:message font:[UIFont systemFontOfSize:14.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:paragraphStyle];
            [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView showWithShouldFitHeight:YES];
        }
        
        if (indexPath.row == 4) {
            CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
            NSString *title = NSLocalizedString(@"请先结束未完成行程才能发车", nil);
            
            NSString *flightNo = @"班次：BCD 12345";
            NSString *disptachTime = @"出发时间：2018-04-20 11:00";
            NSString *startStation = @"厦门市软件园二期";
            NSString *endStation = @"漳州市万达广场";
            NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", flightNo, disptachTime, startStation, endStation];
            NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
            NSString *okButtonTitle = NSLocalizedString(@"结束行程", nil);
            
            CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:25 secondVerticalInterval:20 thirdVerticalInterval:10 bottomVerticalInterval:10];
            [alertView addTitleWithText:title font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.lineSpacing = 3;
            paragraphStyle.firstLineHeadIndent = 10;
            [alertView addMessageWithText:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentLeft margin:20 paragraphStyle:paragraphStyle];
            [alertView addMessageLayerWithBorderWidth:0.5 borderColor:nil cornerRadius:3];
            [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
                NSLog(@"点击了取消按钮");
            } okHandle:^{
                NSLog(@"点击了确认按钮");
            }];
            [alertView showWithShouldFitHeight:YES];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NSString *title = @"app信息";
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"]; //app名
            NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//版本号
            NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];//buidId
            NSString *appDomain = @"https://zhengshi.com:80"; //域名
            
            NSMutableString *message = [NSMutableString string];
            [message appendFormat:@"appName:%@\n", appName];
            [message appendFormat:@"appVersion:%@\n", appVersion];
            [message appendFormat:@"appBuild:  %@\n", appBuild];
            [message appendFormat:@"appDomain: %@", appDomain];

            
            [CJAlert showDebugViewWithTitle:title message:message];
            
        } else if (indexPath.row == 1) {
            NSString *title = @"NSDictionary信息";
            
            NSDictionary *dictionary = @{@"text1": @"Agree!Nice weather!",
                                         @"text2": @"Agree!Nice weather!",
                                         @"mine": @{@"name": @"Jack",
                                                    @"icon": @"lufy.png",
                                                    @"icom": @{@"name": @"Rose",
                                                               @"icon": @"nami.png",
                                                               },
                                                    },
                                         @"users": @[@{@"name": @"Zhangsan",
                                                       @"icon": @"nami.png"
                                                       },
                                                     @{@"name": @"Lisi",
                                                       @"icon": @"nami.png"
                                                       },
                                                     ],
                                         @"names": @[@"dvlproad",
                                                     @"Beyond",
                                                     ],
                                         @"retweetedStatus": @{@"text": @"This is a very long message! beyond the view's width!",
                                                               @"user": @{@"name": @"Rose",
                                                                          @"icon": @"nami.png",
                                                                          }
                                                               }
                                         };
            
            //NSString *message = [CJConvertUtil formattedStringFromObject:dictionary];
            NSString *message = [CJIndentedStringUtil fullFormattedStringFromDictionary:dictionary];
            
            [CJAlert showDebugViewWithTitle:title message:message];
            
        } else if (indexPath.row == 2) {
            NSString *title = @"对象信息";
            
            NSMutableArray<TestDataModel *> *dataModels = [TestDataUtil getTestDataModels];
            TestDataModel *dataModel = dataModels[0];
            
            NSDictionary *dictionary = [CJConvertUtil dictionaryFromModel:dataModel];
            NSString *message = [CJConvertUtil formattedStringFromObject:dictionary];
            
            [CJAlert showDebugViewWithTitle:title message:message];
            
        } else if (indexPath.row == 3) {
            
        }
    }
}


- (void)showNoFoundAlert {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = NSLocalizedString(@"无效二维码，系统找不到该车票", nil);
    NSString *cancelButtonTitle = nil;
    NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    __weak typeof(self)weakSelf = self;
    [CJAlert showCJAlertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
        NSLog(@"点击了确认按钮");
        [weakSelf continueScanning];
    }];
}

- (void)showHasCheckedAlert {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = NSLocalizedString(@"已检票", nil);
    NSString *cancelButtonTitle = nil;
    NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    __weak typeof(self)weakSelf = self;
    [CJAlert showCJAlertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
        NSLog(@"点击了确认按钮");
        [weakSelf continueScanning];
    }];
}

- (void)showInvalidFlightAlert {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = NSLocalizedString(@"班次不符，请核对车票信息", nil);
    NSString *cancelButtonTitle = nil;
    NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    __weak typeof(self)weakSelf = self;
    [CJAlert showCJAlertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:^{
        NSLog(@"点击了确认按钮");
        [weakSelf continueScanning];
    }];
}

- (void)showInvalidStationAlertForStationName:(NSString *)stationName {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = [NSString stringWithFormat:@"上车站点不符，应上车站点：\n【%@】", stationName];
    NSString *cancelButtonTitle = NSLocalizedString(@"我知道了", nil);
    NSString *okButtonTitle = NSLocalizedString(@"允许上车", nil);
    
    __weak typeof(self)weakSelf = self;
    [CJAlert showCJAlertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
        [weakSelf checkAllowGetOnAtStationName:stationName];
    }];
}

- (void)checkAllowGetOnAtStationName:(NSString *)stationName {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 230);

    //乘客上车站为\n【厦门市软件园二期】\n是否本站上车？
    NSString *preTitle = NSLocalizedString(@"乘客上车站为", nil);
    NSString *midTitle = [NSString stringWithFormat:@"【%@】", stationName];
    NSString *sufTitle = NSLocalizedString(@"是否本站上车？", nil);
    NSString *title = [NSString stringWithFormat:@"%@\n%@\n%@", preTitle, midTitle, sufTitle];
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *okButtonTitle = NSLocalizedString(@"确认", nil);
    
    /*
    [CJAlert showCJAlertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
        [self continueScanning];
    }];
    //*/
    //*
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:25 secondVerticalInterval:10 thirdVerticalInterval:10 bottomVerticalInterval:10];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 3;
    [alertView addTitleWithText:title font:[UIFont systemFontOfSize:18.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:paragraphStyle];
    
    [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
        [self continueScanning];
    }];
    [alertView showWithShouldFitHeight:YES];
    //*/
}

- (void)continueScanning {
    
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
