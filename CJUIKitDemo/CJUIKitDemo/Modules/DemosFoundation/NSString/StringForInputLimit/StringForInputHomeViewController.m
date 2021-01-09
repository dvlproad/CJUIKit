//
//  StringForInputHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "StringForInputHomeViewController.h"

// StringLength
#import "AStringLengthViewController.h"

// RangeSubString
#import "BRangeSubStringViewController.h"

// MaxSubString
#import "CMaxSubStringViewController1.h"
#import "CMaxSubStringViewController2.h"

// ChangeString
#import "DChangeStringViewController1.h"

@interface StringForInputHomeViewController ()

@end

@implementation StringForInputHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"文本框输入【长度限制】需要用到的String相关方法", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    
    // String Length
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串长度计算";
        {
            CQDMModuleModel *stringModule = [[CQDMModuleModel alloc] init];
            stringModule.title = @"字符串长度计算String Length";
            stringModule.classEntry = [AStringLengthViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // RangeSubString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"最大子范围字符串串 RangeSubString";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"范围字符串";
            NSStringModule.classEntry = [BRangeSubStringViewController class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // MaxSubString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"最大子字符串 MaxSubString";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"长度计算使用【系统length算法】的时候的最大字符串";
            NSStringModule.classEntry = [CMaxSubStringViewController1 class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"长度计算使用【自定义cj_length算法】的时候的最大字符串";
            NSStringModule.classEntry = [CMaxSubStringViewController2 class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // ChangeString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"限制长度下的替换字符串 ChangeString（用于文本框输入判断）";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"长度计算使用【系统length算法】的时候的最大字符串";
            NSStringModule.classEntry = [DChangeStringViewController1 class];
            [sectionDataModel.values addObject:NSStringModule];
        }
//        {
//            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
//            NSStringModule.title = @"长度计算使用【自定义cj_length算法】的时候的最大字符串";
//            NSStringModule.classEntry = [CMaxSubStringViewController2 class];
//            [sectionDataModel.values addObject:NSStringModule];
//        }
        
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
