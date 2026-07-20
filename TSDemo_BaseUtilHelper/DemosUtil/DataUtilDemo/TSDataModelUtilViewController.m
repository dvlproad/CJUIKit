//
//  TSDataModelUtilViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/1.
//  Copyright © 2017 dvlproad. All rights reserved.
//

#import "TSDataModelUtilViewController.h"
#import <CJBaseUtil/CJPinyinHelper.h>
#import <CJBaseUtil/CJDataUtil+SortOrder.h>
#import <CJBaseUtil/CJDataUtil+SortCategory.h>
#import <CJBaseUtil/CJDataUtil+NormalSearch.h>
#import <CJBaseUtil/CJRealtimeSearchUtil.h>
#import <CJBaseUtil/CJSectionDataModel.h>
#import <CJBaseUtil/CJSortedCategoryResult.h>
#import "Models/TestCityModel.h"

@interface TSDataModelUtilViewController ()

@end

@implementation TSDataModelUtilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"CJDataUtil(数据处理工具)", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 拼音转换
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"拼音转换";
        sectionDataModel.values = [self dealTextModels_pinyinConvert];
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 排序
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"排序(按拼音排序)";
        sectionDataModel.values = [self dealTextModels_sortOrder];
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 分类
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"分类(按拼音首字母分组)";
        sectionDataModel.values = [self dealTextModels_sortCategory];
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 搜索
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"搜索(普通搜索)";
        sectionDataModel.values = [self dealTextModels_normalSearch];
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - 拼音转换
- (NSMutableArray<CQTSAutoTestMethodModel *> *)dealTextModels_pinyinConvert {
    NSMutableArray<CQTSAutoTestMethodModel *> *dealTextModels = [[NSMutableArray alloc] init];
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"请输入中文";
        dealTextModel.text = @"重庆";
        dealTextModel.hopeResultText = @"zhongqing";
        dealTextModel.actionTitle = @"普通拼音";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSString *pinyin = [CJPinyinHelper pinyinFromChineseString:oldString];
            return pinyin;
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"请输入中文";
        dealTextModel.text = @"重庆";
        dealTextModel.hopeResultText = @"chongqing";
        dealTextModel.actionTitle = @"地名拼音";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSString *pinyin = [CJPinyinHelper placePinyinFromChineseString:oldString];
            return pinyin;
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"请输入中文";
        dealTextModel.text = @"厦门";
        dealTextModel.hopeResultText = @"xiamen";
        dealTextModel.actionTitle = @"地名拼音(多音字)";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSString *pinyin = [CJPinyinHelper placePinyinFromChineseString:oldString];
            return pinyin;
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}

#pragma mark - 排序
- (NSMutableArray<CQTSAutoTestMethodModel *> *)dealTextModels_sortOrder {
    NSMutableArray<CQTSAutoTestMethodModel *> *dealTextModels = [[NSMutableArray alloc] init];
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"输入无意义";
        dealTextModel.text = @"北京,上海,广州,深圳,重庆,厦门";
        dealTextModel.hopeResultText = @"北京,重庆,广州,上海,深圳,厦门";
        dealTextModel.actionTitle = @"字符串数组排序";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSArray *originArray = [oldString componentsSeparatedByString:@","];
            NSArray *sortedArray = [CJDataUtil sortOrderInDataArray:originArray
                                                   withDataSelector:nil
                                              pinyinFromStringBlock:^NSString *(NSString *string) {
                return [CJPinyinHelper placePinyinFromChineseString:string];
            }];
            return [sortedArray componentsJoinedByString:@","];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"输入无意义";
        dealTextModel.text = @"北京,上海,广州,深圳,重庆,厦门";
        dealTextModel.hopeResultText = @"北京:北京,重庆:重庆,广州:广州,上海:上海,深圳:深圳,厦门:厦门";
        dealTextModel.actionTitle = @"对象模型排序";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSArray *cityNames = [oldString componentsSeparatedByString:@","];
            NSMutableArray *cityModels = [[NSMutableArray alloc] init];
            for (NSString *cityName in cityNames) {
                TestCityModel *model = [[TestCityModel alloc] init];
                model.name = cityName;
                [cityModels addObject:model];
            }
            
            NSArray *sortedModels = [CJDataUtil sortOrderInDataArray:cityModels
                                                    withDataSelector:@selector(name)
                                               pinyinFromStringBlock:^NSString *(NSString *string) {
                return [CJPinyinHelper placePinyinFromChineseString:string];
            }];
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (TestCityModel *model in sortedModels) {
                [resultArray addObject:[NSString stringWithFormat:@"%@:%@", model.name, model.name]];
            }
            return [resultArray componentsJoinedByString:@","];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}

#pragma mark - 分类
- (NSMutableArray<CQTSAutoTestMethodModel *> *)dealTextModels_sortCategory {
    NSMutableArray<CQTSAutoTestMethodModel *> *dealTextModels = [[NSMutableArray alloc] init];
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"输入无意义";
        dealTextModel.text = @"北京,上海,广州,深圳,重庆,厦门";
        dealTextModel.hopeResultText = @"B:北京,C:重庆,G:广州,S:上海,深圳,X:厦门";
        dealTextModel.actionTitle = @"按拼音首字母分组";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSArray *cityNames = [oldString componentsSeparatedByString:@","];
            CJSortedCategoryResult *result = [CJDataUtil sortCategoryPinyinInDataArray:cityNames
                                                                      withDataSelector:nil
                                                                            andOrderIt:YES
                                                                 pinyinFromStringBlock:^NSString *(NSString *string) {
                return [CJPinyinHelper placePinyinFromChineseString:string];
            }];
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < result.indexTitles.count; i++) {
                NSString *key = result.indexTitles[i];
                NSArray *values = result.arrays[i];
                NSString *valueStr = [values componentsJoinedByString:@","];
                [resultArray addObject:[NSString stringWithFormat:@"%@:%@", key, valueStr]];
            }
            return [resultArray componentsJoinedByString:@","];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}

#pragma mark - 搜索
- (NSMutableArray<CQTSAutoTestMethodModel *> *)dealTextModels_normalSearch {
    NSMutableArray<CQTSAutoTestMethodModel *> *dealTextModels = [[NSMutableArray alloc] init];
    NSString *cityNamesString = @"北京,上海,广州,深圳,重庆,厦门";
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"输入搜索关键字(如:北)";
        dealTextModel.text = @"北";
        dealTextModel.hopeResultText = @"北京";
        dealTextModel.actionTitle = @"从[北京,上海,广州,深圳,重庆,厦门]中搜索包含关键字的城市";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSArray *cityNames = [cityNamesString componentsSeparatedByString:@","];
            NSArray *searchResults = [CJDataUtil searchText:oldString
                                              inDataModels:cityNames
                                   dataModelSearchSelector:nil
                                            withSearchType:CJSearchTypeFull
                                             supportPinyin:YES
                                     pinyinFromStringBlock:^NSString *(NSString *string) {
                return [CJPinyinHelper placePinyinFromChineseString:string];
            }];
            return [searchResults componentsJoinedByString:@","];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    {
        CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
        dealTextModel.placeholder = @"输入拼音搜索(如:bj)";
        dealTextModel.text = @"bj";
        dealTextModel.hopeResultText = @"北京";
        dealTextModel.actionTitle = @"从[北京,上海,广州,深圳,重庆,厦门]中拼音搜索";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSArray *cityNames = [cityNamesString componentsSeparatedByString:@","];
            NSArray *searchResults = [CJDataUtil searchText:oldString
                                              inDataModels:cityNames
                                   dataModelSearchSelector:nil
                                            withSearchType:CJSearchTypeFull
                                             supportPinyin:YES
                                     pinyinFromStringBlock:^NSString *(NSString *string) {
                return [CJPinyinHelper placePinyinFromChineseString:string];
            }];
            NSString *result = [searchResults componentsJoinedByString:@","];
            return result;
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
