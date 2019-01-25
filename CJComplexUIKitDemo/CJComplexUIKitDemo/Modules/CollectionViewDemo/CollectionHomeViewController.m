//
//  CollectionHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CollectionHomeViewController.h"

//UICollectionView
#import "CvDemo_Complex.h"

#import "MyEqualCellSizeCollectionViewController.h"
#import "MyEqualCellSizeViewController.h"
#import "MyCycleADViewController.h"

#import "OpenCollectionViewController.h"
#import "CustomLayoutCollectionViewController.h"

@interface CollectionHomeViewController ()  {
    
}

@end

@implementation CollectionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Collection首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
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
