//
//  CQTSIconsUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQTSIconDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSIconsUtil : NSObject


/// 获取测试用的数据(image为icon图片)
///
/// @param count                图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder;
/// 获取测试用的数据(image为网络图片)
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModels;

#pragma mark - icon Image
+ (UIImage *)cjts_iconImage1;
+ (UIImage *)cjts_iconImage2;
+ (UIImage *)cjts_iconImage3;
+ (UIImage *)cjts_iconImage4;
+ (UIImage *)cjts_iconImage5;
+ (UIImage *)cjts_iconImage6;
+ (UIImage *)cjts_iconImage7;
+ (UIImage *)cjts_iconImage8;


#pragma mark icon ImageUrl
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)cjts_iconUrls;

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_iconUrlAtIndex:(NSInteger)selIndex;

+ (NSString *)cjts_iconImageUrl1;
+ (NSString *)cjts_iconImageUrl2;
+ (NSString *)cjts_iconImageUrl3;
+ (NSString *)cjts_iconImageUrl4;
+ (NSString *)cjts_iconImageUrl5;
+ (NSString *)cjts_iconImageUrl6;
+ (NSString *)cjts_iconImageUrl7;
+ (NSString *)cjts_iconImageUrl8;

@end

NS_ASSUME_NONNULL_END
