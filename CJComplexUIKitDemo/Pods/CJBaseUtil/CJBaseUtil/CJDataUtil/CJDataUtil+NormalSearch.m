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
/** 完整的描述请参见文件头部 */
+ (NSMutableArray *)searchText:(NSString *)searchText
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

/** 完整的描述请参见文件头部 */
+ (NSMutableArray *)searchText:(NSString *)searchText
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
/** 完整的描述请参见文件头部 */
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

/** 完整的描述请参见文件头部 */
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
/** 完整的描述请参见文件头部 */
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

/** 完整的描述请参见文件头部 */
+ (NSObject *)searchText:(NSString *)searchText
             inDataModel:(NSObject *)dataModel
 dataModelSearchSelector:(SEL)dataModelSearchSelector
andSearchInEveryDataModelMember:(SEL)dataModelMemberSelector
dataModelMemberSearchSelector:(SEL)dataModelMemberSearchSelector
          withSearchType:(CJSearchType)searchType
           supportPinyin:(BOOL)supportPinyin
   pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    
    dataModel.isSearchResult = YES;
    dataModel.isContainInSelf = NO;
    dataModel.isContainInMembers = NO;
    
    
    NSString *dataModelSearchSelectorString = [CJDataUtil stringValueForDataSelector:dataModelSearchSelector inDataModel:dataModel];
    
    //搜索判断
    BOOL isContainInSelf = [self isContainSearchText:searchText
                                          fromString:dataModelSearchSelectorString
                                      withSearchType:searchType
                                       supportPinyin:supportPinyin pinyinFromStringBlock:pinyinFromStringBlock];
    dataModel.isContainInSelf = isContainInSelf;
    
    //包含:xx、xx
    NSArray *members = [CJDataUtil arrayValueForDataSelector:dataModelMemberSelector inDataModel:dataModel];
    NSMutableArray *resultMembers = [CJDataUtil searchText:searchText
                                              inDataModels:members
                                   dataModelSearchSelector:dataModelMemberSearchSelector
                                            withSearchType:searchType
                                             supportPinyin:supportPinyin
                                     pinyinFromStringBlock:pinyinFromStringBlock];
    dataModel.containMembers = resultMembers;
    dataModel.isContainInMembers = resultMembers.count ? YES : NO;
    
    if (dataModel.isContainInSelf || dataModel.isContainInMembers) {
        return dataModel;
        
    } else {
        return nil;
    }
}


/** 完整的描述请参见文件头部 */
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
