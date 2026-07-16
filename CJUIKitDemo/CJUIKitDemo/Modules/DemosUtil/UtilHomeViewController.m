//
//  UtilHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UtilHomeViewController.h"
#import <CQDemoKit/CJUIKitToastUtil.h>

//AppLast
#import "CJAppLastUtil.h"


//string
#import "StringEventViewController.h"

//image
#import "QRCodeViewController.h"

// DataUtil
#import "TSDataModelUtilViewController.h"

//其他Util
#import "CallSystemViewController.h"
#import "DeviceInfoViewController.h"
#import "TSPinyinUtilViewController.h"

#import "KeyboardUtilViewController.h"
#import "SharedInstanceViewController.h"

//混淆名生成器
#import "CJConfuseManager.h"

//Knowledge
#import "SemaphoreGateKeeperViewController.h"
#import "LockGateKeeperViewController.h"

@interface UtilHomeViewController ()

@end

@implementation UtilHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"Util首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //AppLast
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"AppLast相关";
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"AppLast(点击使得引导页)";
            toastUtilModule.actionBlock = ^{
                [CJAppLastUtil readOverGuide];
            };
            [sectionDataModel.values addObject:toastUtilModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Knowledge
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Knowledge相关";
        {
            CQDMModuleModel *QRCodeModule = [[CQDMModuleModel alloc] init];
            QRCodeModule.title = @"SemaphoreGateKeeper";
            QRCodeModule.classEntry = [SemaphoreGateKeeperViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        {
            CQDMModuleModel *QRCodeModule = [[CQDMModuleModel alloc] init];
            QRCodeModule.title = @"LockGateKeeper";
            QRCodeModule.classEntry = [LockGateKeeperViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //string
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"string相关";
        
        {
            CQDMModuleModel *stringModule = [[CQDMModuleModel alloc] init];
            stringModule.title = @"String(字符串)";
            stringModule.classEntry = [StringEventViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //image
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"image相关";
        
        {
            CQDMModuleModel *QRCodeModule = [[CQDMModuleModel alloc] init];
            QRCodeModule.title = @"QRCode(二维码)";
            QRCodeModule.classEntry = [QRCodeViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // CJDataUtil 功能展示
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"CJDataUtil(数据处理工具)";
        {
            CQDMModuleModel *dataUtilModule = [[CQDMModuleModel alloc] init];
            dataUtilModule.title = @"PinyinUtil";
            dataUtilModule.classEntry = [TSPinyinUtilViewController class];
            [sectionDataModel.values addObject:dataUtilModule];
        }
        {
            CQDMModuleModel *dataUtilModule = [[CQDMModuleModel alloc] init];
            dataUtilModule.title = @"CJDataUtil交互式测试示例";
            dataUtilModule.content = @"请查看 UIKit-Search-iOS 项目";
            dataUtilModule.classEntry = [TSDataModelUtilViewController class];
            /*
            dataUtilModule.actionBlock = ^{
                NSString *url = @"https://gitee.com/dvlproad/UIKit-Search-iOS";
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = url;
                [CJUIKitToastUtil showMessage:[NSString stringWithFormat:@"已拷贝%@，请自行粘贴跳转网页查看", url]];
            };
            */
            [sectionDataModel.values addObject:dataUtilModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }

    
    //其他
    {
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Util相关";
        {
            CQDMModuleModel *deviceInfoModule = [[CQDMModuleModel alloc] init];
            deviceInfoModule.title = @"CallSystem(拨打电话等)";
            deviceInfoModule.classEntry = [CallSystemViewController class];
            deviceInfoModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:deviceInfoModule];
        }
        {
            CQDMModuleModel *deviceInfoModule = [[CQDMModuleModel alloc] init];
            deviceInfoModule.title = @"DeviceInfo";
            deviceInfoModule.classEntry = [DeviceInfoViewController class];
            deviceInfoModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:deviceInfoModule];
        }
        
        {
            CQDMModuleModel *keyboardUtilModule = [[CQDMModuleModel alloc] init];
            keyboardUtilModule.title = @"KeyboardUtil(键盘高度)";
            keyboardUtilModule.classEntry = [KeyboardUtilViewController class];
            keyboardUtilModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:keyboardUtilModule];
        }
        
        {
            CQDMModuleModel *sharedInstanceModule = [[CQDMModuleModel alloc] init];
            sharedInstanceModule.title = @"SharedInstance(单例)";
            sharedInstanceModule.classEntry = [SharedInstanceViewController class];
            sharedInstanceModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:sharedInstanceModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //CodeObfuscation
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"代码混淆相关";
        
        {
            CQDMModuleModel *QRCodeModule = [[CQDMModuleModel alloc] init];
            QRCodeModule.title = @"CJConfuseManager(混淆名生成器)";
            QRCodeModule.actionBlock = ^{
                NSString *aaa = [CJConfuseManager randomMethodName];
                NSString *bbb = [CJConfuseManager randomClassName];
                NSString *message = [NSString stringWithFormat:@"获得随机方法名 = %@, 随机类名 = %@", aaa, bbb];
                [CJUIKitToastUtil showMessage:message];
            };
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
