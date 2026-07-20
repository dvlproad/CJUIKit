//
//  OtherHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "OtherHomeViewController.h"

#import "CountDownTimeViewController.h"
#import "NestedXibViewController.h"
#import "BeChangeViewController.h"
#import "ChangeEnvHomeViewController.h"


@interface OtherHomeViewController ()

@end

@implementation OtherHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"基础小视图首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
        
    //Interface
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Interface相关(xib/storyboard)";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"xib";
            xibModule.classEntry = [NestedXibViewController class];
            xibModule.isCreateByXib = YES;
            
            [sectionDataModel.values addObject:xibModule];
        }
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"后视图改变前视图的值的实现事例";
            xibModule.classEntry = [BeChangeViewController class];
            xibModule.isCreateByXib = NO;
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //ChangeEnvironment
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"ChangeEnvironment相关";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"ChangeEnvironment(改变网络环境)";
            xibModule.classEntry = [ChangeEnvHomeViewController class];
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //其他
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //CountDownTimeViewController
            CQDMModuleModel *countDownTimeModule = [[CQDMModuleModel alloc] init];
            countDownTimeModule.title = @"倒计时 CountDownTime";
            countDownTimeModule.classEntry = [CountDownTimeViewController class];
            [sectionDataModel.values addObject:countDownTimeModule];
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
