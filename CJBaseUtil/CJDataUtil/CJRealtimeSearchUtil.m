//
//  CJRealtimeSearchUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRealtimeSearchUtil.h"

static CJRealtimeSearchUtil *defaultUtil = nil;

@interface CJRealtimeSearchUtil() {
    
}
@property (nonatomic, strong) id source;
@property (nonatomic) SEL selector;
@property (nonatomic, copy) CJRealtimeSearchResultsBlock resultBlock;

@property (nonatomic, strong) NSThread *searchThread;   /**< 当前搜索线程 */
@property (nonatomic, strong) dispatch_queue_t searchQueue; /**< 搜索线程队列 */

@end

@implementation CJRealtimeSearchUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        _asWholeSearch = YES;
        _searchQueue = dispatch_queue_create("cn.realtimeSearch.queue", NULL);
    }
    
    return self;
}

/**
 *  实时搜索单例实例化
 *
 *  @return 实时搜索单例
 */
+ (instancetype)currentUtil
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultUtil = [[CJRealtimeSearchUtil alloc] init];
    });
    
    return defaultUtil;
}

#pragma mark - public

/** 完整的描述请参见文件头部 */
- (void)realtimeSearchWithSource:(id)source searchText:(NSString *)searchText collationStringSelector:(SEL)selector resultBlock:(CJRealtimeSearchResultsBlock)resultBlock
{
    if (!source || !searchText || !resultBlock) {
        _resultBlock(source);
        return;
    }
    
    _source = source;
    _selector = selector;
    _resultBlock = resultBlock;
    [self realtimeSearch:searchText];
}

/** 完整的描述请参见文件头部 */
- (void)realtimeSearchStop
{
    [self.searchThread cancel];
}


#pragma mark - private

- (void)realtimeSearch:(NSString *)string
{
    [self.searchThread cancel];
    
    //开启新线程
    self.searchThread = [[NSThread alloc] initWithTarget:self selector:@selector(searchBegin:) object:string];
    [self.searchThread start];
}

- (void)searchBegin:(NSString *)string
{
    NSAssert(self.pinyinFromStringBlock, @"字符串转换成拼音的方法/代码块一定要设置");
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.searchQueue, ^{
        NSMutableArray *searchResults = [CJDataUtil searchText:string
                                                  inDataModels:weakSelf.source
                                       dataModelSearchSelector:weakSelf.selector
                                                withSearchType:CJSearchTypeFull
                                                 supportPinyin:YES
                                         pinyinFromStringBlock:self.pinyinFromStringBlock];
        
        weakSelf.resultBlock(searchResults);
    });
}

@end
