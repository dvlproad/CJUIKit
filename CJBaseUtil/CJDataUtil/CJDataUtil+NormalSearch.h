//
//  CJDataUtil+NormalSearch.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil.h"

#import "CJSectionDataModel.h"
#import "NSObject+SearchProperty.h"

typedef NS_ENUM(NSUInteger, CJSearchType) {
    CJSearchTypeFull,                           /**< 检查整个字符串 */
    CJSearchTypeFirstLetterIsFirstCharacter,    /**< 检查整个字符串,但必须保证字符串的首字符为搜索的搜字符 */
};

@interface CJDataUtil (NormalSearch)

#pragma mark - 在sectionDataModels中搜索(每个sectionDataModel中的values属性值为dataModels数组)
/**
 *  在数据源sectionDataModels中元素中搜索包含searchText的元素，并最终保持sectionDataModels的格式返回（只搜索自身）
 *
 *  @param searchText               要搜索的字串
 *  @param sectionDataModels        要搜索的数据源
 *  @param dataModelSearchSelector  获取元素中要比较的字段的方法
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel
 */
+ (NSMutableArray *)searchText:(NSString *)searchText
           inSectionDataModels:(NSArray<CJSectionDataModel *> *)sectionDataModels
       dataModelSearchSelector:(SEL)dataModelSearchSelector
                withSearchType:(CJSearchType)searchType
                 supportPinyin:(BOOL)supportPinyin
         pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

/**
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
 *  @return 搜索结果(结果中的每个元素是 CJSectionDataModel
 */
+ (NSMutableArray *)searchText:(NSString *)searchText
           inSectionDataModels:(NSArray<CJSectionDataModel *> *)sectionDataModels
       dataModelSearchSelector:(SEL)dataModelSearchSelector
andSearchInEveryDataModelMember:(SEL)dataModelMemberSelector
 dataModelMemberSearchSelector:(SEL)dataModelMemberSearchSelector
                withSearchType:(CJSearchType)searchType
                 supportPinyin:(BOOL)supportPinyin
         pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;




#pragma mark - 在数组dataModels中搜索
/**
 *  在数据源searchDataSource中搜索是否包含searchText
 *
 *  @param searchText               要搜索的字串
 *  @param dataModels               要搜索的数据源
 *  @param dataModelSearchSelector  获取元素中要比较的字段的方法
 *  @param searchType               按什么搜索方式搜索
 *  @param supportPinyin            是否支持拼音搜索
 *  @param pinyinFromStringBlock    字符串转换成拼音的方法/代码块
 *
 *  @return 搜索结果
 */
+ (NSMutableArray *)searchText:(NSString *)searchText
                  inDataModels:(NSArray *)dataModels
       dataModelSearchSelector:(SEL)dataModelSearchSelector
                withSearchType:(CJSearchType)searchType
                 supportPinyin:(BOOL)supportPinyin
         pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

/**
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
                     pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;




#pragma mark - 在dataModel或fromString中搜索
/**
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
      pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

/**
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
   pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

/**
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
      pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock;

@end
