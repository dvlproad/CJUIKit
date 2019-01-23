//
//  DemoCacheUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/18.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ImageModuleType) {
    ImageModuleTypeDefault = 0, /**< 默认图片路径 */
    ImageModuleTypeContract,    /**< 电子合同 */
    ImageModuleTypeAsset,       /**< 资产管理 */
};


NS_ASSUME_NONNULL_BEGIN

@interface DemoCacheUtil : NSObject

/// 保存图片到Document
+ (BOOL)saveImageData:(NSData *)imageData callback:(void(^)(NSString *absoluteImagePath))callback;

/// 保存'电子合同'图片到Document
+ (BOOL)saveAssetImageData:(NSData *)imageData callback:(void(^)(NSString *absoluteImagePath))callback;

@end

NS_ASSUME_NONNULL_END
