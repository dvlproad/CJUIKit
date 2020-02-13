//
//  CQJumpMapUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/// 地图类型
typedef NS_ENUM(NSUInteger, CQMapType) {
    CQMapTypeUnset = 0,     /**< 未设置默认地图 */
    CQMapTypeBMKMap = 1,    /**< 百度地图 */
    CQMapTypeAMap,          /**< 高德地图 */
    CQMapTypeAppleMap,      /**< 苹果地图 */
};


NS_ASSUME_NONNULL_BEGIN

@interface CQJumpMapUtil : NSObject

/// 获取默认的导航地图软件类型
+ (CQMapType)defaultMapType;

/// 获取默认的导航地图软件名称
+ (NSString *)defaultMapTitle;

/// 更新默认的导航地图软件
+ (void)updateDefaultMapType:(CQMapType)mapType;

/// 打开百度地图
+ (void)openBMKMapWithCanOpen:(BOOL)canOpenBaiduMap lat:(CGFloat)lat lon:(CGFloat)lon;

+ (void)goToDownloadBaiduMap;

/// 打开高德地图
+ (void)openAMapWithCanOpen:(BOOL)canOpenAmap lat:(CGFloat)lat lon:(CGFloat)lon;

+ (void)goToDownloadAMap;

/// 打开苹果地图
+ (void)openAppleMapWithLat:(CGFloat)lat lon:(CGFloat)lon;

@end

NS_ASSUME_NONNULL_END
