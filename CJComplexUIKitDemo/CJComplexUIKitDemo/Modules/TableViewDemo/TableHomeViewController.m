//
//  TableHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TableHomeViewController.h"

//UITableView
#import "TableViewController.h"
#import "TvDemo_Complex.h"

@interface TableHomeViewController ()  {
    
}

@end

@implementation TableHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Table首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UITableView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UITableView方法了解";
        {
            CQDMModuleModel *TableViewModule = [[CQDMModuleModel alloc] init];
            TableViewModule.title = @"UITableView方法了解(基础)";
            TableViewModule.classEntry = [TableViewController class];
            TableViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:TableViewModule];
        }
        {
            CQDMModuleModel *complexDemoModule = [[CQDMModuleModel alloc] init];
            complexDemoModule.title = @"UITableView方法了解(更多更全)";
            complexDemoModule.classEntry = [TvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
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
