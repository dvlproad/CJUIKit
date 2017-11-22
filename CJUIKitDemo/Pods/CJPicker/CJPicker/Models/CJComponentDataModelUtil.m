//
//  CJComponentDataModelUtil.m
//  CJPDropDownViewDemo
//
//  Created by ciyouzen on 9/7/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJComponentDataModelUtil.h"

@implementation CJComponentDataModelUtil

/** 完整的描述请参见文件头部 */
+ (NSMutableArray<CJComponentDataModel *> *)selectedIndexs:(NSArray *)selectedIndexs
                                           inDictionarys:(NSArray<NSDictionary *> *)dictionarys
                                      sortByCategoryKeys:(NSArray<NSString *> *)categoryKeys
                                       categoryValueKeys:(NSArray<NSString *> *)categoryValueKeys
{
    NSInteger componentCount = categoryKeys.count;
    
    NSMutableArray *dataModels = [[NSMutableArray alloc] init];
    
    NSString *textKey = [categoryKeys objectAtIndex:0];
    NSString *membersKey = [categoryValueKeys objectAtIndex:0];
    for (NSInteger index = 0; index < dictionarys.count; index++) {
        NSDictionary *dictionary = [dictionarys objectAtIndex:index];
        NSString *text = [dictionary valueForKey:textKey];
        NSArray *members = [dictionary valueForKey:membersKey];
        
        CJDataModelSample *dataModel = [[CJDataModelSample alloc] init];
        dataModel.text = text;
        dataModel.containValueCount = [members count];
        dataModel.members = members;
        
        [dataModels addObject:dataModel];
    }
    
    CJComponentDataModel *firstComponentDataModel = [[CJComponentDataModel alloc] init];
    firstComponentDataModel.componentIndex = 0;
    firstComponentDataModel.values = dataModels;
    
    NSMutableArray *componentDataModels = [[NSMutableArray alloc] init];
    for (NSInteger componentIndex = 0; componentIndex < componentCount; componentIndex++) {
        CJComponentDataModel *componentDataModel = nil;
        if (componentIndex == 0) {
            componentDataModel = firstComponentDataModel;
            componentDataModel.dataModelTextKey = [categoryKeys objectAtIndex:componentIndex+1];
            componentDataModel.dataModelMembersKey = [categoryValueKeys objectAtIndex:componentIndex+1];
            
        } else if (componentIndex < componentCount - 1) {
            componentDataModel = [[CJComponentDataModel alloc] init];
            componentDataModel.dataModelTextKey = [categoryKeys objectAtIndex:componentIndex+1];
            componentDataModel.dataModelMembersKey = [categoryValueKeys objectAtIndex:componentIndex+1];
            
        } else {
            componentDataModel = [[CJComponentDataModel alloc] init];
            
        }
        
        [componentDataModels addObject:componentDataModel];
    }
    
    
    
    [self updateSelectedIndexs:selectedIndexs inComponentDataModels:componentDataModels];
    
    return componentDataModels;
}


+ (NSMutableArray<CJComponentDataModel *> *)selectedIndexs:(NSArray *)selectedIndexs
                                                  inTitles:(NSArray<NSString *> *)titles
{
    NSMutableArray *componentDataModels = [[NSMutableArray alloc] init];
    
    NSMutableArray *dataModels = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < titles.count; index++) {
        NSString *string = [titles objectAtIndex:index];
        NSString *category = string;
        
        
        CJDataModelSample *dataModel = [[CJDataModelSample alloc] init];
        dataModel.text = category;
        dataModel.containValueCount = 0;
        
        [dataModels addObject:dataModel];
    }
    CJComponentDataModel *componentDataModel = [[CJComponentDataModel alloc] init];
    componentDataModel.componentIndex = 0;
    componentDataModel.values = dataModels;
    
    [componentDataModels addObject:componentDataModel];
    
    
    [CJComponentDataModelUtil updateSelectedIndexs:selectedIndexs inComponentDataModels:componentDataModels];
    
    return componentDataModels;
}




+ (void)updateSelectedIndexs:(NSArray *)selectedIndexs inComponentDataModels:(NSMutableArray<CJComponentDataModel *> *)componentDataModels {
    if (selectedIndexs.count != componentDataModels.count) {
        NSAssert(NO, @"error: 默认值个数设置出错.请检查");
        return;
    }
    
    NSInteger componentCount = selectedIndexs.count;  //默认值有几对，则有几组
    for (NSInteger componentIndex = 0; componentIndex < componentCount; componentIndex++) {
        NSInteger selectedIndex = [selectedIndexs[componentIndex] integerValue];

        CJComponentDataModel *componentDataModelNext = [self didSelectIndex:selectedIndex inComponentIndex:componentIndex inComponentDataModels:componentDataModels];
        if (componentIndex < componentCount-1) {
            [componentDataModels replaceObjectAtIndex:componentIndex+1 withObject:componentDataModelNext];
        }
    }
}


+ (CJComponentDataModel *)didSelectIndex:(NSInteger)selectedIndex inComponentIndex:(NSInteger)componentIndex inComponentDataModels:(NSMutableArray<CJComponentDataModel *>*)componentDataModels
{
    CJComponentDataModel *componentDataModel = [componentDataModels objectAtIndex:componentIndex];
    
    //主要是为了获取 componentDataModelNext 的 value
    if (componentDataModel.values.count == 0) {
        componentDataModel.selectedIndex = selectedIndex;
        componentDataModel.selectedDataModel = nil;
        
        CJComponentDataModel *componentDataModelNext = [[CJComponentDataModel alloc] init];
        componentDataModelNext.componentIndex = componentDataModel.componentIndex+1;
        componentDataModelNext.values = nil;
        
        return componentDataModelNext;
        
    }
    
    
    CJDataModelSample *selectedDataModel = [componentDataModel.values objectAtIndex:selectedIndex];
    componentDataModel.selectedIndex = selectedIndex;
    componentDataModel.selectedDataModel = selectedDataModel;
    
    NSArray *members = selectedDataModel.members;
    NSInteger count = members.count;
    
    
    NSInteger lastComponentIndex = componentDataModels.count - 1;
    if (componentIndex == lastComponentIndex) {
        return nil;
        
    }
    
    NSMutableArray *dataModelsNext = [[NSMutableArray alloc] init];
    if (componentIndex == lastComponentIndex - 1) {
        for (NSInteger index = 0; index < count; index++) {
            NSString *string = [members objectAtIndex:index];
            NSString *category = string;
            
            CJDataModelSample *dataModel = [[CJDataModelSample alloc] init];
            dataModel.text = category;
            dataModel.containValueCount = 0;
            dataModel.members = nil;
            
            [dataModelsNext addObject:dataModel];
        }
        
    } else {
        NSString *textKey = componentDataModel.dataModelTextKey;
        NSString *memberKey = componentDataModel.dataModelMembersKey;
        
        for (NSInteger index = 0; index < count; index++) {
            NSDictionary *dictionary = [members objectAtIndex:index];
            NSString *text = [dictionary valueForKey:textKey];
            NSArray *members = [dictionary valueForKey:memberKey];
            
            CJDataModelSample *dataModel = [[CJDataModelSample alloc] init];
            dataModel.text = text;
            dataModel.containValueCount = [members count];
            dataModel.members = members;
            
            [dataModelsNext addObject:dataModel];
        }
    }
    
    CJComponentDataModel *componentDataModelNext = [[CJComponentDataModel alloc] init];
    componentDataModelNext.componentIndex = componentIndex+1;
    componentDataModelNext.values = dataModelsNext;
    
    
    return componentDataModelNext;
}


@end
