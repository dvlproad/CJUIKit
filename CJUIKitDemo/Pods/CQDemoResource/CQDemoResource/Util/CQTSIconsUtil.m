//
//  CQTSIconsUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSIconsUtil.h"
//#import <CQDemoKit/CQTSImageLoader.h>   // 在 subspec:BaseUIKit 下

#import "CQTSAssetSourceUtil.h"

@implementation CQTSIconsUtil

#pragma mark - icon Image
/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_iconUrlAtIndex:(NSInteger)trySelIndex {
    NSArray<NSString *> *imageUrls = [CQTSAssetSourceUtil iconUrls];
    NSInteger selIndex = trySelIndex % imageUrls.count;    //位置太大的时候，从头循环使用图片
    NSString *imageUrl = [imageUrls objectAtIndex:selIndex];
    
    return imageUrl;
}
/*
+ (UIImage *)cjts_iconImage1 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl1]];
}

+ (UIImage *)cjts_iconImage2 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl2]];
}

+ (UIImage *)cjts_iconImage3 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl3]];
}

+ (UIImage *)cjts_iconImage4 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl4]];
}

+ (UIImage *)cjts_iconImage5 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl5]];
}

+ (UIImage *)cjts_iconImage6 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl6]];
}

+ (UIImage *)cjts_iconImage7 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl7]];
}

+ (UIImage *)cjts_iconImage8 {
    return [self _iconImageWithUrl:[self cjts_iconImageUrl8]];
}

#pragma mark - Private Method
// 图片比较小只是测试临时使用
+ (UIImage *)_iconImageWithUrl:(NSString *)imageUrl {
    UIImage *image = [CQTSImageLoader syncLoadImageWithUrl:imageUrl optionUseCache:NO];
    return image;
}
*/


#pragma mark - icon ImageUrl
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)cjts_iconUrls {
    return [CQTSAssetSourceUtil iconUrls];
}
+ (NSString *)cjts_iconImageUrl1 {
    return self.cjts_iconUrls[0];
}

+ (NSString *)cjts_iconImageUrl2 {
    return self.cjts_iconUrls[1];
}

+ (NSString *)cjts_iconImageUrl3 {
    return self.cjts_iconUrls[2];
}

+ (NSString *)cjts_iconImageUrl4 {
    return self.cjts_iconUrls[3];
}

+ (NSString *)cjts_iconImageUrl5 {
    return self.cjts_iconUrls[4];
}

+ (NSString *)cjts_iconImageUrl6 {
    return self.cjts_iconUrls[5];
}

+ (NSString *)cjts_iconImageUrl7 {
    return self.cjts_iconUrls[6];
}

+ (NSString *)cjts_iconImageUrl8 {
    return self.cjts_iconUrls[7];
}


@end
