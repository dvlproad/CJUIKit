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

#import "MyCycleADViewController.h"

//图片选择的集合视图
#import "UploadNoneImagePickerViewController.h"
#import "UploadDirectlyImagePickerViewController.h"

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
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UICollectionView相关";
        {
            CQDMModuleModel *complexDemoModule = [[CQDMModuleModel alloc] init];
            complexDemoModule.title = @"ComplexDemo";
            complexDemoModule.classEntry = [CvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
        }
        {
            CQDMModuleModel *cycleScrollViewModule = [[CQDMModuleModel alloc] init];
            cycleScrollViewModule.title = @"MyCycleADView(无限循环的视图)";
            cycleScrollViewModule.classEntry = [MyCycleADViewController class];
            cycleScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:cycleScrollViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //图片选择的集合视图DataScrollView
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"DataScrollView(带数据源的滚动视图)";
        {
            CQDMModuleModel *imagePickerCollectionViewModule = [[CQDMModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(没上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadNoneImagePickerViewController class];
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        {
            CQDMModuleModel *imagePickerCollectionViewModule = [[CQDMModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(有上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadDirectlyImagePickerViewController class];
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
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
