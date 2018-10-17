//
//  NavigationBarHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NavigationBarHomeViewController.h"

#import "NavigationBarViewController.h"
#import "NavigationBarRemoveUnderlineViewController.h"
#import "NavigationBarNormalChangeBGViewController.h"
#import "NavigationBarScrollChangeBGViewController.h"
#import "NavigationBarChangePositonViewController.h"

@interface NavigationBarHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation NavigationBarHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"NavigationBar首页", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UINavigationBar
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UINavigationBar相关";
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(导航栏的设置)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarViewController class];
            UINavigationBarModuleModel1.isCreateByXib = YES;
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(去除导航条最下面的横线)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarRemoveUnderlineViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(改变背景色以隐藏导航栏)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarNormalChangeBGViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(常见的导航栏背景色改变隐藏)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarScrollChangeBGViewController class];
            UINavigationBarModuleModel1.isCreateByXib = YES;
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel2 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel2.title = @"UINavigationBar(类似斗鱼的导航栏移动隐藏)";
            UINavigationBarModuleModel2.classEntry = [NavigationBarChangePositonViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel2];
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
