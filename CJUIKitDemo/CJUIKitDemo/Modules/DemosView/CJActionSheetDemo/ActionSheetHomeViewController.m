//
//  ActionSheetHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ActionSheetHomeViewController.h"
#import "CJModuleModel.h"

#import "CQActionSheetUtil.h"

@interface ActionSheetHomeViewController () {
    
}

@end


@implementation ActionSheetHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ActionSheet首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Sheet相关(以图片选择为例)";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出图片选择ActionSheet";
            module.actionBlock = ^{
                [CQActionSheetUtil showPickImageSheetWithTakePhotoHandle:^{
//                    [DemoToast showMessage:@"点击拍摄"];
                } pickImageHandle:^{
//                    [DemoToast showMessage:@"点击选择照片"];
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"显示ActionSheet";
            module.actionBlock = ^{
                [CQActionSheetUtil showWithItemTitles:@[NSLocalizedString(@"拍摄", nil), NSLocalizedString(@"从手机相册选择", nil)] itemClickBlock:^(NSInteger selectIndex) {
                    NSLog(@"当前选择的是%zd", selectIndex);
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出地图选择ActionSheet";
            module.actionBlock = ^{
                [CQActionSheetUtil showMapsActionSheetWithUpdateMap:YES baiduMapBlock:^(BOOL canOpenBaiduMap) {
//                    [DemoToast showMessage:@"点击百度地图"];
                } amapBlock:^(BOOL canOpenAmap) {
//                    [DemoToast showMessage:@"点击高德地图"];
                } appleMapBlock:^{
//                    [DemoToast showMessage:@"点击苹果地图"];
                }];
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出自定义的选择ActionSheet(没超屏幕高)";
            module.actionBlock = ^{
                NSArray *sheetModels = [self __testSheetModelsWithCount:10];
                [CQActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    
                }];

            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"弹出自定义的选择ActionSheet(已超屏幕高)";
            module.actionBlock = ^{
                NSArray *sheetModels = [self __testSheetModelsWithCount:20];
                [CQActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
                    
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
