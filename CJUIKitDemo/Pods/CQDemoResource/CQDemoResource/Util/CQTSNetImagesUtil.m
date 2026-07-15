//
//  CQTSNetImagesUtil.m
//  CQDemoResource
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSNetImagesUtil.h"
#import "CQTSAssetSourceUtil.h"

@implementation CQTSNetImagesUtil

#pragma mark network ImageUrl
/// 所有的网络测试图片地址
+ (NSArray<NSString *> *)cjts_imageUrls {
    NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
    [imageUrls addObjectsFromArray:[CQTSAssetSourceUtil networkFileUrls:@[@"jpg"]]];
    [imageUrls addObjectsFromArray:@[
        #pragma mark 以下网络图片从 https://stock.tuchong.com 中获取
        @"https://cdn6-banquan.ituchong.com/weili/l/1113166746308968471.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/966827220441759777.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/919795258271596547.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/57461353849430061.jpeg",
        
        #pragma mark 以下网络图片从 https://www.droitstock.com/ 中获取
        
        #pragma mark 以下网络图片从 https://www.veer.com 中获取
    ]];
    
    return imageUrls;
}

/// 随机的网络测试图片地址
+ (NSString *)cjts_imageUrlRandom {
    NSInteger trySelIndex = random();
    NSString *imageUrl = [self cjts_imageUrlAtIndex:trySelIndex];
    
    return imageUrl;
}

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_imageUrlAtIndex:(NSInteger)trySelIndex {
    NSArray<NSString *> *imageUrls = [self cjts_imageUrls];
    NSInteger selIndex = trySelIndex % imageUrls.count;    //位置太大的时候，从头循环使用图片
    NSString *imageUrl = [imageUrls objectAtIndex:selIndex];
    
    return imageUrl;
}


/// 所有的网络测试图片地址
+ (NSArray<NSString *> *)__cjts_imageUrlSelStrings {
    NSArray *selStrings = @[NSStringFromSelector(@selector(cjts_imageUrl1)),
                            NSStringFromSelector(@selector(cjts_imageUrl2)),
                            NSStringFromSelector(@selector(cjts_imageUrl3)),
                            NSStringFromSelector(@selector(cjts_imageUrl4)),
                            NSStringFromSelector(@selector(cjts_imageUrl5)),
                            NSStringFromSelector(@selector(cjts_imageUrl6)),
                            NSStringFromSelector(@selector(cjts_imageUrl7)),
                            NSStringFromSelector(@selector(cjts_imageUrl8)),
                            NSStringFromSelector(@selector(cjts_imageUrl9)),
                            NSStringFromSelector(@selector(cjts_imageUrl10)),
                            NSStringFromSelector(@selector(cjts_imageUrl11)),
                            NSStringFromSelector(@selector(cjts_imageUrl12)),
                            NSStringFromSelector(@selector(cjts_imageUrl13)),
                            NSStringFromSelector(@selector(cjts_imageUrl14)),
                            NSStringFromSelector(@selector(cjts_imageUrl15)),
                            NSStringFromSelector(@selector(cjts_imageUrl16)),
                            NSStringFromSelector(@selector(cjts_imageUrl17)),
                            NSStringFromSelector(@selector(cjts_imageUrl18)),
                            NSStringFromSelector(@selector(cjts_imageUrl19)),
                            NSStringFromSelector(@selector(cjts_imageUrl20)),
                            NSStringFromSelector(@selector(cjts_imageUrl21)),
                            NSStringFromSelector(@selector(cjts_imageUrl22)),
                            NSStringFromSelector(@selector(cjts_imageUrl23)),
                            NSStringFromSelector(@selector(cjts_imageUrl24)),
                            NSStringFromSelector(@selector(cjts_imageUrl25)),
    ];
    
    return selStrings;
}

+ (NSString *)cjts_imageUrl1 {
    return self.cjts_imageUrls[0];
}

+ (NSString *)cjts_imageUrl2 {
    return self.cjts_imageUrls[1];
}

+ (NSString *)cjts_imageUrl3 {
    return self.cjts_imageUrls[2];
}

+ (NSString *)cjts_imageUrl4 {
    return self.cjts_imageUrls[3];
}

+ (NSString *)cjts_imageUrl5 {
    return self.cjts_imageUrls[4];
}

+ (NSString *)cjts_imageUrl6 {
    return self.cjts_imageUrls[5];
}

+ (NSString *)cjts_imageUrl7 {
    return self.cjts_imageUrls[6];
}

+ (NSString *)cjts_imageUrl8 {
    return self.cjts_imageUrls[7];
}

+ (NSString *)cjts_imageUrl9 {
    return self.cjts_imageUrls[8];
}

+ (NSString *)cjts_imageUrl10 {
    return self.cjts_imageUrls[9];
}

+ (NSString *)cjts_imageUrl11 {
    return self.cjts_imageUrls[10];
}

+ (NSString *)cjts_imageUrl12 {
    return self.cjts_imageUrls[11];
}

+ (NSString *)cjts_imageUrl13 {
    return self.cjts_imageUrls[12];
}

+ (NSString *)cjts_imageUrl14 {
    return self.cjts_imageUrls[13];
}

+ (NSString *)cjts_imageUrl15 {
    return self.cjts_imageUrls[14];
}

+ (NSString *)cjts_imageUrl16 {
    return self.cjts_imageUrls[15];
}

+ (NSString *)cjts_imageUrl17 {
    return self.cjts_imageUrls[16];
}

+ (NSString *)cjts_imageUrl18 {
    return self.cjts_imageUrls[17];
}

+ (NSString *)cjts_imageUrl19 {
    return self.cjts_imageUrls[18];
}

+ (NSString *)cjts_imageUrl20 {
    return self.cjts_imageUrls[19];
}

+ (NSString *)cjts_imageUrl21 {
    return self.cjts_imageUrls[20];
}

+ (NSString *)cjts_imageUrl22 {
    return self.cjts_imageUrls[21];
}

+ (NSString *)cjts_imageUrl23 {
    return self.cjts_imageUrls[22];
}

+ (NSString *)cjts_imageUrl24 {
    return self.cjts_imageUrls[23];
}

+ (NSString *)cjts_imageUrl25 {
    return self.cjts_imageUrls[24];
}

+ (NSString *)cjts_imageUrl26 {
    return self.cjts_imageUrls[25];
}

+ (NSString *)cjts_imageUrl27 {
    return self.cjts_imageUrls[26];
}

+ (NSString *)cjts_imageUrl28 {
    return @"https";
}


@end
