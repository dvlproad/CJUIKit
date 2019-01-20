//
//  ScrollViewHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ScrollViewHomeViewController.h"

//UIScrollView
#import "SvDemo_Refresh.h"
#import "ScrollViewController.h"

//PullScale
#import "PullScaleTopImageViewController.h"

//EmptyView
#import "BBXPassengerEmptyViewController.h"

//UITableView
#import "TableViewController.h"
#import "DemoTableViewController.h"
#import "ReuseDataSourceTableViewController.h"
#import "TvDemo_Complex.h"
#import "OpenTableViewController1.h"
#import "OpenTableViewController2.h"
#import "ChooseColor01.h"

//UICollectionView
#import "CvDemo_Complex.h"

#import "MyEqualCellSizeCollectionViewController.h"
#import "MyEqualCellSizeViewController.h"
#import "MyCycleADViewController.h"

#import "OpenCollectionViewController.h"
#import "CustomLayoutCollectionViewController.h"

@interface ScrollViewHomeViewController ()

@end

@implementation ScrollViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ScrollViewHome首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIScrollView相关";
        {
            CJModuleModel *baseScrollViewModule = [[CJModuleModel alloc] init];
            baseScrollViewModule.title = @"ScrollView的最基本约束";
            baseScrollViewModule.classEntry = [UIViewController class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        {
            CJModuleModel *refreshScrollViewModule = [[CJModuleModel alloc] init];
            refreshScrollViewModule.title = @"ScrollView的刷新(MJRefresh)";
            refreshScrollViewModule.classEntry = [SvDemo_Refresh class];
            refreshScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:refreshScrollViewModule];
        }
        {
            CJModuleModel *cjScrollViewModuleModel = [[CJModuleModel alloc] init];
            cjScrollViewModuleModel.title = @"ScrollView(纯代码创建)";
            cjScrollViewModuleModel.classEntry = [ScrollViewController class];
            cjScrollViewModuleModel.isCreateByXib = YES;
            [sectionDataModel.values addObject:cjScrollViewModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //EmptyView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"EmptyView相关";
        {
            CJModuleModel *baseScrollViewModule = [[CJModuleModel alloc] init];
            baseScrollViewModule.title = @"CJDataEmptyView";
            baseScrollViewModule.classEntry = [BBXPassengerEmptyViewController class];
            baseScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //PullScaleTopImageViewController
            CJModuleModel *pullScaleTopImageModuleModel = [[CJModuleModel alloc] init];
            pullScaleTopImageModuleModel.title = @"顶部图片下拉放大，上拉缩小";
            pullScaleTopImageModuleModel.classEntry = [PullScaleTopImageViewController class];
            [sectionDataModel.values addObject:pullScaleTopImageModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UITableView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UITableView相关";
        {
            CJModuleModel *TableViewModule = [[CJModuleModel alloc] init];
            TableViewModule.title = @"TableView(最原始的使用)";
            TableViewModule.classEntry = [TableViewController class];
            TableViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:TableViewModule];
        }
        {
            CJModuleModel *baseDemoModule = [[CJModuleModel alloc] init];
            baseDemoModule.title = @"BaseDemo";
            baseDemoModule.classEntry = [DemoTableViewController class];
            baseDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:baseDemoModule];
        }
        {
            CJModuleModel *reuseDataSourceTableModule = [[CJModuleModel alloc] init];
            reuseDataSourceTableModule.title = @"ReuseDataSourceTable";
            reuseDataSourceTableModule.classEntry = [ReuseDataSourceTableViewController class];
            reuseDataSourceTableModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:reuseDataSourceTableModule];
        }
        {
            CJModuleModel *complexDemoModule = [[CJModuleModel alloc] init];
            complexDemoModule.title = @"ComplexDemo";
            complexDemoModule.classEntry = [TvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
        }
        {
            CJModuleModel *openTableModule = [[CJModuleModel alloc] init];
            openTableModule.title = @"OpenTable(不使用控件)";
            openTableModule.classEntry = [OpenTableViewController1 class];
            openTableModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:openTableModule];
        }
        {
            CJModuleModel *openTableModule = [[CJModuleModel alloc] init];
            openTableModule.title = @"OpenTable(使用控件)";
            openTableModule.classEntry = [OpenTableViewController2 class];
            openTableModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:openTableModule];
        }
        {
            CJModuleModel *chooseColorModule = [[CJModuleModel alloc] init];
            chooseColorModule.title = @"ChooseColor01";
            chooseColorModule.selector = @selector(goTableViewController);
            [sectionDataModel.values addObject:chooseColorModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //UICollectionView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UICollectionView相关";
        {
            CJModuleModel *complexDemoModule = [[CJModuleModel alloc] init];
            complexDemoModule.title = @"ComplexDemo";
            complexDemoModule.classEntry = [CvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
        }
        {
            CJModuleModel *MyEqualCellSizeCollectionViewModule = [[CJModuleModel alloc] init];
            MyEqualCellSizeCollectionViewModule.title = @"MyEqualCellSizeCollectionView(等cell大小)";
            MyEqualCellSizeCollectionViewModule.classEntry = [MyEqualCellSizeCollectionViewController class];
            MyEqualCellSizeCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:MyEqualCellSizeCollectionViewModule];
        }
        {
            CJModuleModel *MyEqualCellSizeViewModule = [[CJModuleModel alloc] init];
            MyEqualCellSizeViewModule.title = @"MyEqualCellSizeView(嵌套的等cell大小)";
            MyEqualCellSizeViewModule.classEntry = [MyEqualCellSizeViewController class];
            MyEqualCellSizeViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:MyEqualCellSizeViewModule];
        }
        {
            CJModuleModel *cycleScrollViewModule = [[CJModuleModel alloc] init];
            cycleScrollViewModule.title = @"MyCycleADView(无限循环的视图)";
            cycleScrollViewModule.classEntry = [MyCycleADViewController class];
            cycleScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:cycleScrollViewModule];
        }
        {
            CJModuleModel *openCollectionViewModule = [[CJModuleModel alloc] init];
            openCollectionViewModule.title = @"OpenCollectionView(可展开)";
            openCollectionViewModule.classEntry = [OpenCollectionViewController class];
            openCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:openCollectionViewModule];
        }
        {
            CJModuleModel *customLayoutModule = [[CJModuleModel alloc] init];
            customLayoutModule.title = @"CustomLayout(自定义布局)";
            customLayoutModule.classEntry = [CustomLayoutCollectionViewController class];
            customLayoutModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:customLayoutModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)goTableViewController {
    ChooseColor01 *viewController = [[ChooseColor01 alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
