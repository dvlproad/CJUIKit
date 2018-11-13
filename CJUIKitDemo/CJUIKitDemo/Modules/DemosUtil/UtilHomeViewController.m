//
//  UtilHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UtilHomeViewController.h"

//AppLast
#import "CJAppLastUtil.h"

//弹窗
#import "ToastViewController.h"
#import "AlertViewController.h"

//Log
#import "LogUtilViewController.h"
#import "LogViewViewController.h"
#import "LogSuspendWindowViewController.h"

//string
#import "StringEventViewController.h"

//image
#import "QRCodeViewController.h"


//其他Util
#import "CallSystemViewController.h"
#import "DeviceInfoViewController.h"
#import "DataUtilViewController.h"
#import "AccuracyStringViewController.h"
#import "KeyboardUtilViewController.h"
#import "SharedInstanceViewController.h"

//混淆名生成器
#import "CJRandomNameUtil.h"

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
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"AppLast相关";
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"AppLast(点击使得引导页)";
            toastUtilModule.selector = @selector(readOverGuide);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Knowledge
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Knowledge相关";
        {
            CJModuleModel *QRCodeModule = [[CJModuleModel alloc] init];
            QRCodeModule.title = @"SemaphoreGateKeeper";
            QRCodeModule.classEntry = [SemaphoreGateKeeperViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        {
            CJModuleModel *QRCodeModule = [[CJModuleModel alloc] init];
            QRCodeModule.title = @"LockGateKeeper";
            QRCodeModule.classEntry = [LockGateKeeperViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //弹窗
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"弹窗相关";
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"Toast";
            toastUtilModule.classEntry = [ToastViewController class];
            toastUtilModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CJModuleModel *alertUtilModule = [[CJModuleModel alloc] init];
            alertUtilModule.title = @"Alert";
            alertUtilModule.classEntry = [AlertViewController class];
            alertUtilModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:alertUtilModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Log
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"日志(Log)相关";
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"LogUtil(输入、输出)";
            toastUtilModule.classEntry = [LogUtilViewController class];
            toastUtilModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"LogView(Log视图)";
            toastUtilModule.classEntry = [LogViewViewController class];
            toastUtilModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"LogSuspendWindow(Log悬浮球)";
            toastUtilModule.classEntry = [LogSuspendWindowViewController class];
            toastUtilModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:toastUtilModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //string
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"string相关";
        
        {
            CJModuleModel *stringModule = [[CJModuleModel alloc] init];
            stringModule.title = @"String(字符串)";
            stringModule.classEntry = [StringEventViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //image
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"image相关";
        
        {
            CJModuleModel *QRCodeModule = [[CJModuleModel alloc] init];
            QRCodeModule.title = @"QRCode(二维码)";
            QRCodeModule.classEntry = [QRCodeViewController class];
            QRCodeModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //其他
    {
        
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Util相关";
        {
            CJModuleModel *deviceInfoModule = [[CJModuleModel alloc] init];
            deviceInfoModule.title = @"CallSystem(拨打电话等)";
            deviceInfoModule.classEntry = [CallSystemViewController class];
            deviceInfoModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:deviceInfoModule];
        }
        {
            CJModuleModel *deviceInfoModule = [[CJModuleModel alloc] init];
            deviceInfoModule.title = @"DeviceInfo";
            deviceInfoModule.classEntry = [DeviceInfoViewController class];
            deviceInfoModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:deviceInfoModule];
        }
        {
            CJModuleModel *dataUtilModule = [[CJModuleModel alloc] init];
            dataUtilModule.title = @"DataUtil";
            dataUtilModule.classEntry = [DataUtilViewController class];
            dataUtilModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:dataUtilModule];
        }
        {
            CJModuleModel *NSAttributedStringModule = [[CJModuleModel alloc] init];
            NSAttributedStringModule.title = @"数值处理(取整、去尾0等)";
            NSAttributedStringModule.classEntry = [AccuracyStringViewController class];
            NSAttributedStringModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        
        {
            CJModuleModel *keyboardUtilModule = [[CJModuleModel alloc] init];
            keyboardUtilModule.title = @"KeyboardUtil(键盘高度)";
            keyboardUtilModule.classEntry = [KeyboardUtilViewController class];
            keyboardUtilModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:keyboardUtilModule];
        }
        
        {
            CJModuleModel *sharedInstanceModule = [[CJModuleModel alloc] init];
            sharedInstanceModule.title = @"SharedInstance(单例)";
            sharedInstanceModule.classEntry = [SharedInstanceViewController class];
            sharedInstanceModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:sharedInstanceModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //CodeObfuscation
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"代码混淆相关";
        
        {
            CJModuleModel *QRCodeModule = [[CJModuleModel alloc] init];
            QRCodeModule.title = @"CJRandomNameUtil(混淆名生成器)";
            QRCodeModule.selector = @selector(readOverGuide);
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


- (void)readOverGuide {
    [CJAppLastUtil readOverGuide];
}

- (void)randomName {
    NSString *aaa = [CJRandomNameUtil randomMethodName];
    NSString *bbb = [CJRandomNameUtil randomClassName];
    NSLog(@"aaa = %@, bbb = %@", aaa, bbb);
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
