//
//  ThirdPartyHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ThirdPartyHomeViewController.h"

//模型转换
#import "MJExtensionToModelViewController.h"
#import "MJExtensionToJSONViewController.h"

#import "MantleViewController.h"

#import "TSLayoutPriorityViewController.h"


@interface ThirdPartyHomeViewController ()

@end

@implementation ThirdPartyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ThirdParty首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIScrollView
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"模型转换相关";
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"MJExtension的基本使用(待完善)";
            baseScrollViewModule.classEntry = [MJExtensionToModelViewController class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"MJExtension的基本使用(待完善)";
            baseScrollViewModule.classEntry = [MJExtensionToJSONViewController class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"Mantle的基本使用(待完善)";
            baseScrollViewModule.classEntry = [MantleViewController class];
            baseScrollViewModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"LayoutPriority相关";
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"LayoutPriority";
            baseScrollViewModule.classEntry = [TSLayoutPriorityViewController class];
            [sectionDataModel.values addObject:baseScrollViewModule];
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
