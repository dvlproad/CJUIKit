//
//  AutoLayoutHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "AutoLayoutHomeViewController.h"

#import "AutoLayoutViewController.h"

#import "TranslucentLayoutViewController.h"
#import "EdgeLayoutViewController.h"
#import "TranslucentLayoutTableViewController.h"
#import "EdgeLayoutTableViewController.h"

@interface AutoLayoutHomeViewController ()

@end

@implementation AutoLayoutHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"AutoLayout首页", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // intrinsic content size
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"intrinsic content size";
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"intrinsic content size";
            dragViewModule.classEntry = [AutoLayoutViewController class];
            [sectionDataModel.values addObject:dragViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Layout
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Layout";
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"Translucent";
            dragViewModule.classEntry = [TranslucentLayoutViewController class];
            [sectionDataModel.values addObject:dragViewModule];
        }
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"Translucent";
            dragViewModule.classEntry = [TranslucentLayoutTableViewController class];
            [sectionDataModel.values addObject:dragViewModule];
        }
        //edgesForExtendedLayout
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"edgesForExtendedLayout";
            dragViewModule.classEntry = [EdgeLayoutViewController class];
            [sectionDataModel.values addObject:dragViewModule];
        }
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"edgesForExtendedLayout";
            dragViewModule.classEntry = [EdgeLayoutTableViewController class];
            [sectionDataModel.values addObject:dragViewModule];
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
