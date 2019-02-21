//
//  OtherHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "OtherHomeViewController.h"

#import "ProcessLineViewController.h"
#import "CountDownTimeViewController.h"


@interface OtherHomeViewController ()

@end

@implementation OtherHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"基础小视图首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //QuartzCore
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"QuartzCore相关(如画线)";
        {
            //ProcessLineViewController
            CJModuleModel *processLineViewModule = [[CJModuleModel alloc] init];
            processLineViewModule.title = @"流程线(ProcessLineView)";
            processLineViewModule.classEntry = [ProcessLineViewController class];
            [sectionDataModel.values addObject:processLineViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //其他
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //CountDownTimeViewController
            CJModuleModel *countDownTimeModule = [[CJModuleModel alloc] init];
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
