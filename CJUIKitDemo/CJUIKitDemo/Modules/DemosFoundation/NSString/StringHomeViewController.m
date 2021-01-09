//
//  StringHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "StringHomeViewController.h"

#import "EncryptStringViewController.h"
#import "AttributedStringViewController.h"
#import "AttributedStringViewController2.h"

#import "StringLengthViewController.h"
#import "ValidateStringViewController.h"

// SubString
#import "MaxSubStringViewController1.h"
#import "MaxSubStringViewController2.h"

@interface StringHomeViewController ()

@end

@implementation StringHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"String首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //NSString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSString相关";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"字符串加密EncryptString";
            NSStringModule.classEntry = [EncryptStringViewController class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        {
            CQDMModuleModel *NSAttributedStringModule = [[CQDMModuleModel alloc] init];
            NSAttributedStringModule.title = @"NSAttributedString";
            NSAttributedStringModule.classEntry = [AttributedStringViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        {
            CQDMModuleModel *NSAttributedStringModule = [[CQDMModuleModel alloc] init];
            NSAttributedStringModule.title = @"NSAttributedString";
            NSAttributedStringModule.classEntry = [AttributedStringViewController2 class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        
        {
            CQDMModuleModel *stringModule = [[CQDMModuleModel alloc] init];
            stringModule.title = @"字符串长度计算String Length";
            stringModule.classEntry = [StringLengthViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        {
            CQDMModuleModel *stringModule = [[CQDMModuleModel alloc] init];
            stringModule.title = @"字符串类型验证String Validate";
            stringModule.classEntry = [ValidateStringViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // SubString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"最大子字符串 MaxSubString";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"长度计算使用【系统length算法】的时候的最大字符串";
            NSStringModule.classEntry = [MaxSubStringViewController1 class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"长度计算使用【自定义cj_length算法】的时候的最大字符串";
            NSStringModule.classEntry = [MaxSubStringViewController2 class];
            [sectionDataModel.values addObject:NSStringModule];
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
