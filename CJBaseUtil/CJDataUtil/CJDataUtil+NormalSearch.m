//
//  CJDataUtil+NormalSearch.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil+NormalSearch.h"

#import "CJDataUtil+Value.h"

@implementation CJDataUtil (NormalSearch)

//typedef void (^CJSearchResultsBlock)(NSArray *searchResults);

#pragma mark - 在sectionDataModels中搜索(每个sectionDataModel中的values属性值为dataModels数组)
/*
 *  在数据源sectionDataModels中元素中搜索包含searchText的元素，并最终保持sectionDataModels的格式返回（只搜索自身）
 *
 *  @param searchText               要搜索的字串
 *  @param sectionDataModels        要搜索的数据源
 *  @param dataModelSearchSelector  获取元素中要比较的字段的方法
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel)
 */
+ (NSMutableArray<CJSectionDataModel *> *)searchText:(NSString *)searchText
                                 inSectionDataModels:(NSArray<CJSectionDataModel *> *)sectionDataModels
                             dataModelSearchSelector:(SEL)dataModelSearchSelector
                                      withSearchType:(CJSearchType)searchType
                                       supportPinyin:(BOOL)supportPinyin
                               pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    NSMutableArray *resultSectionDataModels = [[NSMutableArray alloc] init];
    
    for (CJSectionDataModel *sectionDataModel in sectionDataModels) {
        NSArray *dataModels = sectionDataModel.values;
        
        NSMutableArray *resultDataModels = [CJDataUtil searchText:searchText
                                                     inDataModels:dataModels
                                          dataModelSearchSelector:dataModelSearchSelector
                                                   withSearchType:searchType
                                                    supportPinyin:supportPinyin
                                            pinyinFromStringBlock:pinyinFromStringBlock];
        if (resultDataModels.count > 0) {
            CJSectionDataModel *resultSectionDataModel = [[CJSectionDataModel alloc] init];
            resultSectionDataModel.type = sectionDataModel.type;
            resultSectionDataModel.theme = sectionDataModel.theme;
            resultSectionDataModel.values = resultDataModels;
            
            [resultSectionDataModels addObject:resultSectionDataModel];
        }
    }
    
    return resultSectionDataModels;
}

/*
 *  在数据源sectionDataModels中元素中搜索包含searchText的元素，并最终保持sectionDataModels的格式返回（除搜索自身外，还会搜索自身下的member）
 *
 *  @param searchText                       要搜索的字串
 *  @param sectionDataModels                要搜索的数据源
 *  @param dataModelSearchSelector          获取元素中要比较的字段的方法
 *  @param dataModelMemberSelector          成员所对应的属性
 *  @param dataModelMemberSearchSelector    获取元素中member中的元素要比较的字段的方法
 *  @param searchType                       按什么搜索方式搜索
 *  @param supportPinyin                    是否支持拼音搜索
 *  @param pinyinFromStringBlock            字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel)
 */
+ (NSMutableArray<CJSectionDataModel *> *)searchText:(NSString *)searchText
                                 inSectionDataModels:(NSArray<CJSectionDataModel *> *)sectionDataModels
                             dataModelSearchSelector:(SEL)dataModelSearchSelector
                     andSearchInEveryDataModelMember:(SEL)dataModelMemberSelector
                       dataModelMemberSearchSelector:(SEL)dataModelMemberSearchSelector
                                      withSearchType:(CJSearchType)searchType
                                       supportPinyin:(BOOL)supportPinyin
                               pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    NSMutableArray *resultSectionDataModels = [[NSMutableArray alloc] init];
    
    for (CJSectionDataModel *sectionDataModel in sectionDataModels) {
        NSArray *dataModels = sectionDataModel.values;
        
        NSMutableArray *resultDataModels = [CJDataUtil searchText:searchText
                                                     inDataModels:dataModels
                                          dataModelSearchSelector:dataModelSearchSelector
                                  andSearchInEveryDataModelMember:dataModelMemberSelector
                                    dataModelMemberSearchSelector:dataModelMemberSearchSelector
                                                   withSearchType:searchType
                                                    supportPinyin:supportPinyin
                                            pinyinFromStringBlock:pinyinFromStringBlock];
        if (resultDataModels.count > 0) {
            CJSectionDataModel *resultSectionDataModel = [[CJSectionDataModel alloc] init];
            resultSectionDataModel.type = sectionDataModel.type;
            resultSectionDataModel.theme = sectionDataModel.theme;
            resultSectionDataModel.values = resultDataModels;
            
            [resultSectionDataModels addObject:resultSectionDataModel];
        }
    }
    
    return resultSectionDataModels;
}


#pragma mark - 在数组dataModels中搜索
/*
 *  在数据源searchDataSource中搜索是否包含searchText
 *
 *  @param searchText               要搜索的字串
 *  @param dataModels               要搜索的数据源
 *  @param dataModelSearchSelector  获取元素中要比较的字段的方法
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 dataModels 中的元素)
 */
+ (NSMutableArray *)searchText:(NSString *)searchText
                  inDataModels:(NSArray *)dataModels
       dataModelSearchSelector:(SEL)dataModelSearchSelector
                withSearchType:(CJSearchType)searchType
                 supportPinyin:(BOOL)supportPinyin
         pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    
    NSMutableArray *searchResults = [[NSMutableArray alloc] init];
    if (searchText.length == 0) {
        [searchResults addObjectsFromArray:dataModels];
        
    } else {
        for (id dataModel in dataModels) {
            BOOL isContainSearchText =
            [CJDataUtil isContainSearchText:searchText
                                inDataModel:dataModel
                    dataModelSearchSelector:dataModelSearchSelector
                             withSearchType:searchType
                              supportPinyin:supportPinyin
                      pinyinFromStringBlock:pinyinFromStringBlock];
            if (isContainSearchText) {
                [searchResults addObject:dataModel];
            }
        }
    }
    
    return searchResults;
}

/*
 *  在数据源dataModels及其member中元素中搜索包含searchText的元素（除搜索自身外，还会搜索自身下的member）
 *
 *  @param searchText                       要搜索的字串
 *  @param dataModels                       要搜索的数据源
 *  @param dataModelSearchSelector          获取元素中要比较的字段的方法
 *  @param dataModelMemberSelector          成员所对应的属性
 *  @param dataModelMemberSearchSelector    获取元素中member中的元素要比较的字段的方法
 *  @param searchType                       按什么搜索方式搜索
 *  @param supportPinyin                    是否支持拼音搜索
 *  @param pinyinFromStringBlock            字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel
 */
+ (NSMutableArray<NSObject *> *)searchText:(NSString *)searchText
                              inDataModels:(NSArray<NSObject *> *)dataModels
                   dataModelSearchSelector:(SEL)dataModelSearchSelector
           andSearchInEveryDataModelMember:(SEL)dataModelMemberSelector
             dataModelMemberSearchSelector:(SEL)dataModelMemberSearchSelector
                            withSearchType:(CJSearchType)searchType
                             supportPinyin:(BOOL)supportPinyin
                     pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    NSMutableArray *resultDataModels = [[NSMutableArray alloc] init];
    for (NSObject *dataModel in dataModels) {
        
        NSObject *resultDataModel = [CJDataUtil searchText:searchText
                                               inDataModel:dataModel
                                   dataModelSearchSelector:dataModelSearchSelector
                           andSearchInEveryDataModelMember:dataModelMemberSelector
                             dataModelMemberSearchSelector:dataModelMemberSearchSelector
                                            withSearchType:searchType
                                             supportPinyin:supportPinyin
                                     pinyinFromStringBlock:pinyinFromStringBlock];
        if (resultDataModel) {
            [resultDataModels addObject:resultDataModel];
        }
    }
    
    return resultDataModels;
}

#pragma mark - 在dataModel或fromString中搜索
/*
 *  判断dataModel中的dataModelSearchSelector属性，是否包含searchText
 *
 *  @param searchText               要搜索的字串
 *  @param dataModel                要搜索的数据源
 *  @param dataModelSearchSelector  获取元素中要比较的字段的方法
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 是否包含字串
 */
+ (BOOL)isContainSearchText:(NSString *)searchText
                inDataModel:(id)dataModel
    dataModelSearchSelector:(SEL)dataModelSearchSelector
             withSearchType:(CJSearchType)searchType
              supportPinyin:(BOOL)supportPinyin
      pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    NSString *dataModelSearchSelectorString = [CJDataUtil stringValueForDataSelector:dataModelSearchSelector inDataModel:dataModel];
    
    //搜索判断
    BOOL isContainSearchText = [self isContainSearchText:searchText
                                              fromString:dataModelSearchSelectorString
                                          withSearchType:searchType
                                           supportPinyin:supportPinyin
                                   pinyinFromStringBlock:pinyinFromStringBlock];
    
    return isContainSearchText;
}

/*
 *  在数据dataModel及其member属性中搜索包含searchText的元素
 *
 *  @param searchText                       要搜索的字串
 *  @param dataModel                        要搜索的数据
 *  @param dataModelSearchSelector          获取元素中要比较的字段的方法
 *  @param dataModelMemberSelector          成员所对应的属性
 *  @param dataModelMemberSearchSelector    获取元素中member中的元素要比较的字段的方法
 *  @param searchType                       按什么搜索方式搜索
 *  @param supportPinyin                    是否支持拼音搜索
 *  @param pinyinFromStringBlock            字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel
 */
+ (NSObject *)searchText:(NSString *)searchText
             inDataModel:(NSObject *)dataModel
 dataModelSearchSelector:(SEL)dataModelSearchSelector
andSearchInEveryDataModelMember:(SEL)dataModelMemberSelector
dataModelMemberSearchSelector:(SEL)dataModelMemberSearchSelector
          withSearchType:(CJSearchType)searchType
           supportPinyin:(BOOL)supportPinyin
   pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    
    dataModel.cj_isSearchResult = YES;
    dataModel.cj_isContainInSelf = NO;
    dataModel.cj_isContainInMembers = NO;
    
    
    NSString *dataModelSearchSelectorString = [CJDataUtil stringValueForDataSelector:dataModelSearchSelector inDataModel:dataModel];
    
    //搜索判断
    BOOL isContainInSelf = [self isContainSearchText:searchText
                                          fromString:dataModelSearchSelectorString
                                      withSearchType:searchType
                                       supportPinyin:supportPinyin pinyinFromStringBlock:pinyinFromStringBlock];
    dataModel.cj_isContainInSelf = isContainInSelf;
    
    //包含:xx、xx
    NSArray *members = [CJDataUtil arrayValueForDataSelector:dataModelMemberSelector inDataModel:dataModel];
    NSMutableArray *resultMembers = [CJDataUtil searchText:searchText
                                              inDataModels:members
                                   dataModelSearchSelector:dataModelMemberSearchSelector
                                            withSearchType:searchType
                                             supportPinyin:supportPinyin
                                     pinyinFromStringBlock:pinyinFromStringBlock];
    dataModel.cj_containMembers = resultMembers;
    dataModel.cj_isContainInMembers = resultMembers.count ? YES : NO;
    
    if (dataModel.cj_isContainInSelf || dataModel.cj_isContainInMembers) {
        return dataModel;
        
    } else {
        return nil;
    }
}


/*
 *  在fromString中搜索是否包含searchText
 *
 *  @param searchText               要搜索的字串
 *  @param fromString               从哪个字符串搜索
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 是否包含字串
 */
+ (BOOL)isContainSearchText:(NSString *)searchText
                 fromString:(NSString *)fromString
             withSearchType:(CJSearchType)searchType
              supportPinyin:(BOOL)supportPinyin
      pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    if (searchText == nil || fromString == nil) {
        return NO;
    }
    
    if (searchText.length == 0) {
        return YES;
    }
    
//    if ((fromString.length == 0 && searchText.length != 0)) {
//        return NO;
//    }
    
    NSMutableArray *searchSourceStrings = [NSMutableArray arrayWithArray:@[fromString]];
    if (supportPinyin) {
        NSString *searchSourceStringPinyin = pinyinFromStringBlock(fromString);
        [searchSourceStrings addObject:searchSourceStringPinyin];
    }
    
    //搜索判断
    BOOL isContainSearchText = NO;
    NSString *searchTextString = [searchText lowercaseString]; //下面比较时候要保证大小写一致
    for (NSString *searchSourceString in searchSourceStrings) {
        NSString *lowerSearchSourceString = [searchSourceString lowercaseString];
        
        if (CJSearchTypeFirstLetterIsFirstCharacter == searchType) {
            NSString *searchTextFirstcharacter = [searchTextString substringToIndex:1];
            NSString *lowerSearchTextFirstcharacter = [searchTextFirstcharacter lowercaseString];
            if (![lowerSearchSourceString hasPrefix:lowerSearchTextFirstcharacter]) {
                isContainSearchText = NO;
                continue;
            }
        }
        
        NSUInteger location = [searchSourceString rangeOfString:searchTextString].location;
        if (location != NSNotFound) {
            isContainSearchText = YES;
            break;
        }
    }
    
    return isContainSearchText;
}



/* //去重、来自哪
+ (void)deal {
    NSMutableArray *allResultDataModelMembers = [[NSMutableArray alloc] init];
    for (CJSectionDataModel *resultSectionDataModel in resultSectionDataModels) {
        NSMutableArray *resultDataModels = resultSectionDataModel.values;
        for (NSObject *resultDataModel in resultDataModels) {
            [allResultDataModelMembers addObjectsFromArray:resultDataModel.containMembers];
        }
    }
    
    // 对搜索到的成员allResultDataModelContainMembers进行去重
    NSMutableArray *userIds = [[NSMutableArray alloc] init];
    NSMutableArray *userInfos = [[NSMutableArray alloc] init];
    for (id member in allResultDataModelMembers) {
        NSString *uniqueIdString = [CJDataUtil stringValueForDataSelector:dataModelMemberUniqueId inDataModel:member];
        
        if (![userIds containsObject:uniqueIdString]) {
            [userIds addObject:uniqueIdString];
            [userInfos addObject:member];
            
        } else {
            NSInteger oldUserInfoIndex = [userIds indexOfObject:uniqueIdString];
            id oldMember = [userInfos objectAtIndex:oldUserInfoIndex];
            
            //来自：xx、xx
            NSString *comeFrom = @"";
            NSString *memberSelectorString = [CJDataUtil stringValueForDataSelector:dataModelMemberSelector inDataModel:member];
            
            NSString *oldMemberSelectorString = [CJDataUtil stringValueForDataSelector:dataModelMemberSelector inDataModel:oldMember];
            
            NSString *appendingString = [NSString stringWithFormat:@"、%@", oldMemberSelectorString];
            memberSelectorString = [memberSelectorString stringByAppendingString:appendingString];
            
            [userInfos replaceObjectAtIndex:oldUserInfoIndex withObject:member];
        }
    }
    
    return resultSectionDataModels;
}
*/


@end
