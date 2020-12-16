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
/// @param count 图片个数
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModelsWithCount:(NSInteger)count;
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
