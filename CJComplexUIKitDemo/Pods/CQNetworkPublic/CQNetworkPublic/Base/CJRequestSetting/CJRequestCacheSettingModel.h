//
//  CJRequestCacheSettingModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/5/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  网络请求中的缓存相关设置

#import <Foundation/Foundation.h>

/// 缓存策略
typedef NS_ENUM(NSUInteger, CJRequestCacheStrategy) {
    CJRequestCacheStrategyNoneCache = 0,        /**< 成功/失败的时候，都不使用缓存，直接使用网络数据 */
    CJRequestCacheStrategyEndWithCacheIfExist,  /**< 成功/失败的时候，如果有缓存，则不用再去取网络实际值 */
    CJRequestCacheStrategyUseCacheToTransition, /**< 成功/失败的时候，如果有缓存，使用缓存过渡来快速显示，最终以网络数据显示 */
};

@interface CJRequestCacheSettingModel : NSObject {
    
}
// 缓存策略(如果设为CJRequestCacheStrategyNoneCache，那么下面两个方法的缓存相当于只是缓存，却永远不会用，即白搭了)
@property (nonatomic, assign) CJRequestCacheStrategy cacheStrategy;

// 缓存时间,默认不缓存
@property (nonatomic, assign ) NSTimeInterval cacheTimeInterval;

@end
