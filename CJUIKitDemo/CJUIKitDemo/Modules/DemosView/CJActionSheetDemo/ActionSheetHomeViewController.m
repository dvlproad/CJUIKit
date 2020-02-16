//
//  ActionSheetHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ActionSheetHomeViewController.h"
#import "CJModuleModel.h"

#import "TSActionSheetUtil.h"

@interface ActionSheetHomeViewController () {
    
}

@end


@implementation ActionSheetHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ActionSheet首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 测试Sheet的subTitle有无
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试Sheet的subTitle有无";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"显示ActionSheet";
            module.actionBlock = ^{
                NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
                {
                    CJActionSheetModel *takPhotoSheetModel = [[CJActionSheetModel alloc] init];
                    takPhotoSheetModel.title = NSLocalizedString(@"拍摄", nil);
                    [sheetModels addObject:takPhotoSheetModel];
                }
                {
                    CJActionSheetModel *pickImageSheetModel = [[CJActionSheetModel alloc] init];
                    pickImageSheetModel.title = NSLocalizedString(@"从手机相册选择", nil);
                    [sheetModels addObject:pickImageSheetModel];
                }
                
                [TSActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    NSLog(@"当前选择的是%zd", selectIndex);
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出地图选择ActionSheet";
            module.actionBlock = ^{
                NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
                // 百度地图 BaiduMap
                BOOL canOpenBaiduMap = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
                CJActionSheetModel *baiduMapSheetModel = [[CJActionSheetModel alloc] init];
                baiduMapSheetModel.title = NSLocalizedString(@"百度地图", nil);
                baiduMapSheetModel.subTitle = canOpenBaiduMap ? @"" : NSLocalizedString(@"未安装", nil);
                [sheetModels addObject:baiduMapSheetModel];
                
                // 高德地图 Amap
                BOOL canOpenAmap = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"amapuri://"]];
                CJActionSheetModel *amapSheetModel = [[CJActionSheetModel alloc] init];
                amapSheetModel.title = NSLocalizedString(@"高德地图", nil);
                amapSheetModel.subTitle = canOpenAmap ? @"" : NSLocalizedString(@"未安装", nil);
                [sheetModels addObject:amapSheetModel];
                
                // 苹果地图 appleMap
                CJActionSheetModel *appleMapSheetModel = [[CJActionSheetModel alloc] init];
                appleMapSheetModel.title = NSLocalizedString(@"苹果地图", nil);
                appleMapSheetModel.subTitle = @"";
                [sheetModels addObject:appleMapSheetModel];
                
                [TSActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    NSLog(@"当前选择的是%zd", selectIndex);
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 测试Sheet的列表长短
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试Sheet的列表长短";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出自定义的选择ActionSheet(没超屏幕高)";
            module.actionBlock = ^{
                NSArray *sheetModels = [self __testSheetModelsWithCount:10];
                [TSActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    
                }];

            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出自定义的选择ActionSheet(已超屏幕高)";
            module.actionBlock = ^{
                NSArray *sheetModels = [self __testSheetModelsWithCount:20];
                [TSActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - Private Method
/**
 *  获取指定个数的测试sheetModels
 *
 *  @param count 指定多少个
 *
 *  @return 指定个数的测试sheetModels
 */
- (NSArray<CJActionSheetModel *> *)__testSheetModelsWithCount:(NSInteger)count {
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < count; i++) {
        CJActionSheetModel *sheetModel = [[CJActionSheetModel alloc] init];
        sheetModel.title = [NSString stringWithFormat:@"自定义%ld", i];
        sheetModel.subTitle = @"subTitle";
        [sheetModels addObject:sheetModel];
    }
    return sheetModels;
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
