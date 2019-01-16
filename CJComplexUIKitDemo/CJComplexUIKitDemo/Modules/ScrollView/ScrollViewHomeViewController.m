//
//  ScrollViewHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ScrollViewHomeViewController.h"

//DataScrollView
#import "SearchTableViewController.h"
#import "UploadNoneImagePickerViewController.h"
#import "UploadDirectlyImagePickerViewController.h"

@interface ScrollViewHomeViewController ()  {
    
}

@end

@implementation ScrollViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ScrollView首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //DataScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"DataScrollView(带数据源的滚动视图)";
        {
            CJModuleModel *searchTableViewModule = [[CJModuleModel alloc] init];
            searchTableViewModule.title = @"带搜索功能的列表";
            searchTableViewModule.classEntry = [SearchTableViewController class];
            searchTableViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:searchTableViewModule];
        }
        {
            CJModuleModel *imagePickerCollectionViewModule = [[CJModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(没上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadNoneImagePickerViewController class];
            imagePickerCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        {
            CJModuleModel *imagePickerCollectionViewModule = [[CJModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(有上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadDirectlyImagePickerViewController class];
            imagePickerCollectionViewModule.isCreateByXib = YES;
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
