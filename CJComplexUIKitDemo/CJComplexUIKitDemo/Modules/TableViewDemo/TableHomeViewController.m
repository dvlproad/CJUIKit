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
#import "ReuseDataSourceTableViewController.h"
#import "TvDemo_Complex.h"
#import "OpenTableViewController1.h"
#import "OpenTableViewController2.h"

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
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UITableView相关";
        {
            CQDMModuleModel *TableViewModule = [[CQDMModuleModel alloc] init];
            TableViewModule.title = @"TableView(最原始的使用)";
            TableViewModule.classEntry = [TableViewController class];
            TableViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:TableViewModule];
        }
        {
            CQDMModuleModel *reuseDataSourceTableModule = [[CQDMModuleModel alloc] init];
            reuseDataSourceTableModule.title = @"ReuseDataSourceTable";
            reuseDataSourceTableModule.classEntry = [ReuseDataSourceTableViewController class];
            [sectionDataModel.values addObject:reuseDataSourceTableModule];
        }
        {
            CQDMModuleModel *complexDemoModule = [[CQDMModuleModel alloc] init];
            complexDemoModule.title = @"ComplexDemo";
            complexDemoModule.classEntry = [TvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
        }
        {
            CQDMModuleModel *openTableModule = [[CQDMModuleModel alloc] init];
            openTableModule.title = @"OpenTable(不使用控件)";
            openTableModule.classEntry = [OpenTableViewController1 class];
            openTableModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:openTableModule];
        }
        {
            CQDMModuleModel *openTableModule = [[CQDMModuleModel alloc] init];
            openTableModule.title = @"OpenTable(使用控件)";
            openTableModule.classEntry = [OpenTableViewController2 class];
            openTableModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:openTableModule];
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
