//
//  DemoCacheUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/18.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoConstant.h"

@interface DemoCacheUtil : NSObject

#pragma mark - Save
/// 保存图片到Document下的moduleType模块
+ (BOOL)saveImageData:(NSData *)imageData forModuleType:(DemoModuleType)moduleType callback:(void(^)(NSString *absoluteImagePath, NSString *imageName))callback;

#pragma mark - Clear
/// 删除所有'资产管理'图片
+ (void)clearAssetImage;

@end
