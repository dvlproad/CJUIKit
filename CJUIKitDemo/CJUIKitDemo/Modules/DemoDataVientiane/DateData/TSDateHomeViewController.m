//
//  TSDateHomeViewController.m
//  CJUIKitDemo
//
//  Created by qian on 2026/7/15.
//  Copyright © 2026 dvlproad. All rights reserved.
//

#import "TSDateHomeViewController.h"

#import "DateViewController.h"
#import "NSCalendarCJHelperViewController.h"

@interface TSDateHomeViewController ()

@end

@implementation TSDateHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"NSDate 验证测试";
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSDate 验证测试分类";
        
        {
            CQDMModuleModel *module = [[CQDMModuleModel alloc] init];
            module.title = @"Date";
            module.classEntry = [DateViewController class];
            [sectionDataModel.values addObject:module];
        }
        
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"NSCalendarCJHelper";
            helperModule.classEntry = [NSCalendarCJHelperViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

@end
