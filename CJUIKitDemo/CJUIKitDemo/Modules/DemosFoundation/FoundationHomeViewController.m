//
//  FoundationHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "FoundationHomeViewController.h"

// String
#import "StringHomeViewController.h"

#import "DateViewController.h"
#import "TypeConvertViewController.h"


@interface FoundationHomeViewController ()

@end

@implementation FoundationHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //NSString
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSString相关";
        {
            CQDMModuleModel *NSStringModule = [[CQDMModuleModel alloc] init];
            NSStringModule.title = @"String";
            NSStringModule.classEntry = [StringHomeViewController class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //NSDate
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSDate相关";
        {
            CQDMModuleModel *NSDateModule = [[CQDMModuleModel alloc] init];
            NSDateModule.title = @"NSDate";
            NSDateModule.classEntry = [DateViewController class];
            [sectionDataModel.values addObject:NSDateModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Json-Model类型转换
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Json-Model类型转换相关";
        {
            //TypeConvert
            CQDMModuleModel *TypeConvertModule = [[CQDMModuleModel alloc] init];
            TypeConvertModule.title = @"TypeConvertModule（类型转换）";
            TypeConvertModule.classEntry = [TypeConvertViewController class];
            [sectionDataModel.values addObject:TypeConvertModule];
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
