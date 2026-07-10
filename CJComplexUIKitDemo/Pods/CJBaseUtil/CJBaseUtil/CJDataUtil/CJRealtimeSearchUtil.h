//
//  CJRealtimeSearchUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDataUtil+NormalSearch.h"

typedef void (^CJRealtimeSearchResultsBlock)(NSArray *searchResults);

@interface CJRealtimeSearchUtil : NSObject {
    
}
/**
 *  是否连续搜索，默认YES(要搜索的字符串作为一个整体)
 */
@property (nonatomic) BOOL asWholeSearch;

//一定要设置的值
@property (nonatomic, copy) NSString *(^pinyinFromStringBlock)(NSString *string); /**< 字符串转换成拼音的方法/代码块 */

/**
 *  实时搜索单例实例化
 *
 *  @return 实时搜索单例
 */
+ (instancetype)currentUtil;

/**
 *  开始搜索，与[realtimeSearchStop]配套使用
 *
 *  @param source      要搜索的数据源
 *  @param searchText  要搜索的字符串
 *  @param selector    获取元素中要比较的字段的方法
 *  @param resultBlock 回调方法，返回搜索结果
 */
- (void)realtimeSearchWithSource:(id)source searchText:(NSString *)searchText collationStringSelector:(SEL)selector resultBlock:(CJRealtimeSearchResultsBlock)resultBlock;

/**
 * 结束搜索，只需要调用一次，在[realtimeSearchBegin...:]之后使用，主要用于释放资源
 */
- (void)realtimeSearchStop;

@end
