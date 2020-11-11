//
//  MoreHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MoreHomeViewController.h"

//第三方库
#import "ThirdPartyHomeViewController.h"

//其他
#import "OtherHomeViewController.h"

@interface MoreHomeViewController ()

@end

@implementation MoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Util首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //ThirdParty
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"ThirdParty";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"ThirdPartyHome(第三方库入口)";
            xibModule.classEntry = [ThirdPartyHomeViewController class];
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Other
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Other";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"OtherHome(其他基础小视图入口)";
            xibModule.classEntry = [OtherHomeViewController class];
            
            [sectionDataModel.values addObject:xibModule];
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
