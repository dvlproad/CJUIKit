//
//  CQTSLocImagesUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQTSLocImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSLocImagesUtil : NSObject

#pragma mark - placeholder Image
+ (UIImage *)cjts_placeholderImage01;

/// 获取测试用的数据(image为本地图片)
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModels;

/// 获取测试用的数据(image为本地图片)
///
/// @param count 图片个数
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModelsWithCount:(NSInteger)count;


#pragma mark - local BGImage
+ (UIImage *)cjts_localImageBG1;
+ (UIImage *)cjts_localImageBG2;

#pragma mark - local Image
/// 所有的本地测试图片
+ (NSArray<UIImage *> *)cjts_localImages;
/// 随机的本地测试图片
+ (UIImage *)cjts_localImageRandom;
+ (UIImage *)cjts_localImage1;
+ (UIImage *)cjts_localImage2;
+ (UIImage *)cjts_localImage3;
+ (UIImage *)cjts_localImage4;
+ (UIImage *)cjts_localImage5;
+ (UIImage *)cjts_localImage6;
+ (UIImage *)cjts_localImage7;
+ (UIImage *)cjts_localImage8;
+ (UIImage *)cjts_localImage9;
+ (UIImage *)cjts_localImage10;

#pragma mark - test Image
/// 水平长图
+ (UIImage *)longHorizontal01;
/// 竖直长图
+ (UIImage *)longVertical01;

@end

NS_ASSUME_NONNULL_END
