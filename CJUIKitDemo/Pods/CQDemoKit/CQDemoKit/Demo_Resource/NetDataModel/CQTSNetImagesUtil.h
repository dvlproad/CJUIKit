//
//  CQTSNetImagesUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQTSNetImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSNetImagesUtil : NSObject

/// 获取测试用的数据(image为网络图片)
+ (NSMutableArray<CQTSNetImageDataModel *> *)__getTestNetImageDataModels;

/// 获取测试用的数据(image为网络图片地址)
///
/// @param count        图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSNetImageDataModel *> *)__getTestNetImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder;


#pragma mark network ImageUrl
/// 所有的网络测试图片地址
+ (NSArray<NSString *> *)cjts_imageUrls;

/// 随机的网络测试图片地址
+ (NSString *)cjts_imageUrlRandom;

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_imageUrlAtIndex:(NSInteger)selIndex;

+ (NSString *)cjts_imageUrl1;

+ (NSString *)cjts_imageUrl2;

+ (NSString *)cjts_imageUrl3;

+ (NSString *)cjts_imageUrl4;

+ (NSString *)cjts_imageUrl5;

+ (NSString *)cjts_imageUrl6;

+ (NSString *)cjts_imageUrl7;

+ (NSString *)cjts_imageUrl8;

+ (NSString *)cjts_imageUrl9;

+ (NSString *)cjts_imageUrl10;

+ (NSString *)cjts_imageUrl11;

+ (NSString *)cjts_imageUrl12;

+ (NSString *)cjts_imageUrl13;

+ (NSString *)cjts_imageUrl14;

+ (NSString *)cjts_imageUrl15;

+ (NSString *)cjts_imageUrl16;

+ (NSString *)cjts_imageUrl17;

+ (NSString *)cjts_imageUrl18;

+ (NSString *)cjts_imageUrl19;

+ (NSString *)cjts_imageUrl20;

+ (NSString *)cjts_imageUrl21;

+ (NSString *)cjts_imageUrl22;

+ (NSString *)cjts_imageUrl23;

+ (NSString *)cjts_imageUrl24;

+ (NSString *)cjts_imageUrl25;

@end

NS_ASSUME_NONNULL_END
