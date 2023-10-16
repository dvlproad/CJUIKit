//
//  CJCacheDataModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJCacheDataModel : NSObject <NSCoding>

@property (nonatomic, strong) id<NSCoding> dataObject;              /**< 存储对象的数据 */
@property (nonatomic, strong) NSDate *beginDate;                    /**< 存储对象开始的时间 */
@property (nonatomic, assign, readonly) BOOL needCache;             /**< 存储对象多久 */
@property (nonatomic, strong, readonly) NSDate *expiredDate;        /**< 存储对象过期的时间 */

///初始化不会缓存
- (instancetype)initWithDataObject:(id<NSCoding>)object;

///初始化(如果不需要缓存，请将timeInterval的值设为负值)
- (instancetype)initWithDataObject:(id<NSCoding>)object timeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
