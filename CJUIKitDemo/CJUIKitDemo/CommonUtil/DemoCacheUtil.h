//
//  DemoCacheUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/18.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoCacheUtil : NSObject

/// 保存图片到Document
+ (BOOL)saveImageData:(NSData *)imageData withImageName:(NSString *)imageName callback:(void(^)(NSString *absoluteImagePath))callback;

@end

NS_ASSUME_NONNULL_END
