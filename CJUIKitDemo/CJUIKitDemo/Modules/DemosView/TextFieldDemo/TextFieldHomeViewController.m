//
//  TextFieldHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TextFieldHomeViewController.h"

// TextField
#import "TSBlockTextFieldViewController.h"
#import "TSTextFieldOffsetViewController.h"
#import "TSTextFieldInputViewController.h"
#import "TSTextFieldClickViewController.h"

// TextView
#import "TextViewController.h"

@interface TextFieldHomeViewController ()

@end

@implementation TextFieldHomeViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"TextField + TextView 首页", nil);    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    
    // TextField
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"TextField相关";
        {
            CQDMModuleModel *buttonModule = [[CQDMModuleModel alloc] init];
            buttonModule.title = @"TextField 的 Block";
            buttonModule.classEntry = [TSBlockTextFieldViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            CQDMModuleModel *textFieldModule = [[CQDMModuleModel alloc] init];
            textFieldModule.title = @"TextField 的 Offset";
            textFieldModule.classEntry = [TSTextFieldOffsetViewController class];
            [sectionDataModel.values addObject:textFieldModule];
        }
        {
            CQDMModuleModel *textFieldModule = [[CQDMModuleModel alloc] init];
            textFieldModule.title = @"TextField 的 input";
            textFieldModule.classEntry = [TSTextFieldInputViewController class];
            [sectionDataModel.values addObject:textFieldModule];
        }
        {
            CQDMModuleModel *textFieldModule = [[CQDMModuleModel alloc] init];
            textFieldModule.title = @"TextField 的 click";
            textFieldModule.classEntry = [TSTextFieldClickViewController class];
            [sectionDataModel.values addObject:textFieldModule];
        }
        
       
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // TextView
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"TextView相关";
        {
            CQDMModuleModel *textViewModule = [[CQDMModuleModel alloc] init];
            textViewModule.title = @"TextView";
            textViewModule.classEntry = [TextViewController class];
            [sectionDataModel.values addObject:textViewModule];
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
