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

#import "ValidateStringViewController.h"

// 文本框输入【长度限制】需要用到的String相关方法
#import "StringForInputHomeViewController.h"

#import "TextSizeViewController.h"

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
            stringModule.title = @"字符串类型验证String Validate";
            stringModule.classEntry = [ValidateStringViewController class];
            [sectionDataModel.values addObject:stringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 文本框输入【长度限制】需要用到的String相关方法
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"文本框输入【长度限制】需要用到的String相关方法";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"使用TextSize的视图高度";
            NSStringModule.classEntry = [TextSizeViewController class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 文本框输入【长度限制】需要用到的String相关方法
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"文本框输入【长度限制】需要用到的String相关方法";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"文本框输入【长度限制】需要用到的String相关方法";
            NSStringModule.classEntry = [StringForInputHomeViewController class];
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
