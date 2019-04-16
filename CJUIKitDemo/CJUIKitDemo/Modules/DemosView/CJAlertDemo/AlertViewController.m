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

@interface AlertViewController () {
    
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end


@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Alert首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIAlertController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIAlertController";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message (系统UIAlertController)";
            toastModule.actionBlock = ^{
                [self showUIAlertController:UIAlertControllerStyleAlert];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message (系统UIAlertController)";
            toastModule.actionBlock = ^{
                [self showUIAlertController:UIAlertControllerStyleActionSheet];
            };
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
            toastModule.actionBlock = ^{
                NSString *stationName = @"厦门市软件园二期";
                [self showInvalidStationAlertForStationName:stationName];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            toastModule.actionBlock = ^{
                UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
                NSString *title = NSLocalizedString(@"未通过", nil);
                NSString *message = NSLocalizedString(@"班次不符，请核对车票信息", nil);
                __weak typeof(self)weakSelf = self;
                [CJAlert showIKnowAlertWithFlagImage:flagImage title:title message:message okHandle:^{
                    NSLog(@"点击了确认按钮");
                    [weakSelf continueScanning];
                }];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & OK & Cancel";
            toastModule.actionBlock = ^{
                NSString *stationName = @"厦门市软件园二期";
                [self checkAllowGetOnAtStationName:stationName];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK";
            toastModule.actionBlock = ^{
                NSString *title = NSLocalizedString(@"友情提示", nil);
                NSString *message = NSLocalizedString(@"您当前处于离线状态，请检查您的网络", nil);
                [CJAlert showIKnowWithTitle:title message:message okHandle:^{
                    NSLog(@"点击了确认按钮");
                }];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK & Cancel";
            toastModule.selector = @selector(showBorderAlert);
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
            debugViewModule.actionBlock = ^{
                NSString *appDomain = @"https://zhengshi.com:80"; //域名
                
                NSMutableString *appExtraInfo = [NSMutableString string];
                [appExtraInfo appendFormat:@"appDomain: %@", appDomain];
                
                [CJAlert showDebugViewWithAppExtraInfo:appExtraInfo];
            };
            [sectionDataModel.values addObject:debugViewModule];
        }
        {
            CJModuleModel *debugViewModule = [[CJModuleModel alloc] init];
            debugViewModule.title = @"Debug Request(NSDictionary)";
            debugViewModule.selector = @selector(testPrintDebugDictionary);
            [sectionDataModel.values addObject:debugViewModule];
        }
        {
            CJModuleModel *debugViewModule = [[CJModuleModel alloc] init];
            debugViewModule.title = @"Debug Model";
            debugViewModule.selector = @selector(testPrintDebugModel);
            [sectionDataModel.values addObject:debugViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
    
    /* 添加系统菊花 */
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = self.tableView.center;
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

- (void)showBorderAlert {
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    NSString *title = NSLocalizedString(@"请先结束未完成行程才能发车", nil);
    
    NSString *flightNo = @"班次：BCD 12345";
    NSString *disptachTime = @"出发时间：2018-04-20 11:00";
    NSString *startStation = @"厦门市软件园二期";
    NSString *endStation = @"漳州市万达广场";
    NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", flightNo, disptachTime, startStation, endStation];
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *okButtonTitle = NSLocalizedString(@"结束行程", nil);
    
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:25 secondVerticalInterval:20 thirdVerticalInterval:10 bottomMinVerticalInterval:10];
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
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
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
    CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
        [weakSelf checkAllowGetOnAtStationName:stationName];
    }];
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:NO blankBGColor:blankBGColor];
}

- (void)checkAllowGetOnAtStationName:(NSString *)stationName {
    //乘客上车站为\n【厦门市软件园二期】\n是否本站上车？
    NSString *preTitle = NSLocalizedString(@"乘客上车站为", nil);
    NSString *midTitle = [NSString stringWithFormat:@"【%@】", stationName];
    NSString *sufTitle = NSLocalizedString(@"是否本站上车？", nil);
    NSString *title = [NSString stringWithFormat:@"%@\n%@\n%@", preTitle, midTitle, sufTitle];
    
    [CJAlert showCancelOKAlertWithTitle:title okHandle:^{
        NSLog(@"点击了确认按钮");
        [self continueScanning];
    }];
}

- (void)continueScanning {
    
}


- (IBAction)showToast:(id)sender {
    
}


#pragma mark - DebugView
- (void)testPrintDebugModel {
    NSString *title = @"对象信息";
    
    NSMutableArray<TestDataModel *> *dataModels = [TestDataUtil getTestDataModels];
    TestDataModel *dataModel = dataModels[0];
    
    NSDictionary *dictionary = [CJConvertUtil dictionaryFromModel:dataModel];
    NSString *message = [CJConvertUtil formattedStringFromObject:dictionary];
    
    [CJAlert showDebugViewWithTitle:title message:message];
}

- (void)testPrintDebugDictionary {
    NSString *title = @"NSDictionary信息";
    
    NSDictionary *dictionary =
    @{@"text1": @"Agree!Nice weather!",
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
}


#pragma mark - Lazy
/// 加载网络图片时候的进度显示器
- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.color = CJColorFromHexString(@"#01ADFE");
        _activityIndicator.backgroundColor = CJColorFromHexString(@"#F9F9F9");
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
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
