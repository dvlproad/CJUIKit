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
#import "CJAlertUtil.h"
#import "CJMessageAlertView.h"
#import "CJTextInputAlertView.h"

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
        sectionDataModel.theme = @"自定义的View(有图片)";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK";
            toastModule.selector = @selector(show_flagImage_title_message_iKnow);
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"FlagImage & Title & Message & OK & Cancel";
            toastModule.selector = @selector(show_flagImage_title_message_cancel_OK);
            [sectionDataModel.values addObject:toastModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //以下几个为自定义的View
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的View(无图片)";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK";
            toastModule.selector = @selector(show_title_message_iKnow);
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & Message & OK & Cancel";
            toastModule.selector = @selector(show_title_message_cancel_OK);
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"Title & OK & Cancel";
            toastModule.selector = @selector(show_title_cancel_OK);
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
                
                [CJAlertUtil showDebugViewWithAppExtraInfo:appExtraInfo];
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
        [CJAlert showSystemSheetWithTitle:title
                                  message:message
                             alertActions:alertActions
                         inViewController:self];
    } else {
        [CJAlert showSystemAlertWithTitle:title
                                  message:message
                             alertActions:alertActions
                         inViewController:self];
    }
    
}

- (void)show_flagImage_title_message_iKnow {
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = NSLocalizedString(@"班次不符，请核对车票信息", nil);
    [CJAlertUtil showAlertViewWithFlagImage:flagImage title:title message:message okButtonTitle:NSLocalizedString(@"我知道了", nil) okHandle:^{
        NSLog(@"点击了确认按钮");
    }];
}

- (void)show_flagImage_title_message_cancel_OK {
    UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    NSString *title = NSLocalizedString(@"未通过", nil);
    NSString *message = [NSString stringWithFormat:@"上车站点不符，应上车站点：\n【%@】", @"厦门市软件园二期"];
    [CJAlertUtil showAlertViewWithFlagImage:flagImage title:title message:message cancelButtonTitle:NSLocalizedString(@"我知道了", nil) okButtonTitle:NSLocalizedString(@"允许上车", nil) cancelHandle:^{
        NSLog(@"我知道了");
    } okHandle:^{
        NSLog(@"允许上车");
    }];
}

- (void)show_title_message_iKnow {
    NSString *title = NSLocalizedString(@"友情提示", nil);
    NSString *message = NSLocalizedString(@"您当前处于离线状态，请检查您的网络", nil);
    [CJAlertUtil showAlertViewWithFlagImage:nil title:title message:message okButtonTitle:NSLocalizedString(@"我知道了", nil) okHandle:^{
        NSLog(@"点击了确认按钮");
    }];
}

- (void)show_title_message_cancel_OK {
    NSString *title = NSLocalizedString(@"请先结束未完成行程才能发车", nil);
    
    NSString *flightNo = @"班次：BCD 12345";
    NSString *disptachTime = @"出发时间：2018-04-20 11:00";
    NSString *startStation = @"厦门市软件园二期";
    NSString *endStation = @"漳州市万达广场";
    NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", flightNo, disptachTime, startStation, endStation];
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *okButtonTitle = NSLocalizedString(@"结束行程", nil);
    
    [CJAlertUtil showAlertViewWithFlagImage:nil title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
    }];
}

- (void)show_title_cancel_OK {
    //乘客上车站为\n【厦门市软件园二期】\n是否本站上车？
    NSString *preTitle = NSLocalizedString(@"乘客上车站为", nil);
    NSString *midTitle = [NSString stringWithFormat:@"【%@】", @"厦门市软件园二期"];
    NSString *sufTitle = NSLocalizedString(@"是否本站上车？", nil);
    NSString *title = [NSString stringWithFormat:@"%@\n%@\n%@", preTitle, midTitle, sufTitle];
    
    [CJAlertUtil showAlertViewWithFlagImage:nil title:title message:nil cancelButtonTitle:NSLocalizedString(@"取消", nil) okButtonTitle:NSLocalizedString(@"确认", nil) cancelHandle:^{
        NSLog(@"点击了取消按钮");
    } okHandle:^{
        NSLog(@"点击了确认按钮");
    }];
}


#pragma mark - DebugView
- (void)testPrintDebugModel {
    NSString *title = @"对象信息";
    
    NSMutableArray<TestDataModel *> *dataModels = [TestDataUtil getTestDataModels];
    TestDataModel *dataModel = dataModels[0];
    
    NSDictionary *dictionary = [CJConvertUtil dictionaryFromModel:dataModel];
    NSString *message = [CJConvertUtil formattedStringFromObject:dictionary];
    
    [CJAlertUtil showDebugViewWithTitle:title message:message];
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
    
    [CJAlertUtil showDebugViewWithTitle:title message:message];
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
