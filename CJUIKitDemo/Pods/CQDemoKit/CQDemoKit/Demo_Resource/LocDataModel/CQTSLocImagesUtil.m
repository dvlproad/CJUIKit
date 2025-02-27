//
//  CQTSLocImagesUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSLocImagesUtil.h"
#import "UIImage+CQDemoKit.h"

@implementation CQTSLocImagesUtil

#pragma mark - placeholder Image
+ (UIImage *)cjts_placeholderImage01 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_placeholder01.jpg"];
}

/// 获取测试用的数据(image为本地图片)
///
/// @param count                图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder {
    NSArray<UIImage *> *images = [self cjts_localImages];
    
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    NSArray<NSString *> *titles = @[@"X透社", @"新鲜事", @"XX信", @"X角信", @"蓝精灵", @"年轻范", @"XX福", @"X之语"];
    
    for (NSInteger i = 0; i < count; i++) {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastImageSelIndex = maySelIndex%images.count;
        NSInteger lastTitleSelIndex = maySelIndex%titles.count;
        
        UIImage *image = [images objectAtIndex:lastImageSelIndex];
        //NSString *title = [NSString stringWithFormat:@"%zd:第index=%zd张", i, lastImageSelIndex];
        NSString *title = [titles objectAtIndex:lastTitleSelIndex];
        dataModel.image = image;
        dataModel.name = [NSString stringWithFormat:@"%02zd%@", i+1, title];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}
    
    

/// 获取测试用的数据(image为本地图片)
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModels {
    return [self __getTestLocalImageDataModelsWithCount:8 randomOrder:NO];
}


#pragma mark - local BGImage
+ (UIImage *)cjts_localImageBG1 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_bgSky.jpg"];
}

+ (UIImage *)cjts_localImageBG2 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_bgCar.jpg"];
}


#pragma mark - local Image

/// 所有的本地测试图片
+ (NSArray<UIImage *> *)cjts_localImages {
    NSMutableArray<UIImage *> *images = [[NSMutableArray alloc] init];
    
    NSArray<NSString *> *imageNames = [self cjts_localImageNames];
    NSInteger imageCount = [imageNames count];
    for (int i = 0; i < imageCount; i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        UIImage *image = [UIImage cqdemokit_xcassetImageNamed:imageName];
        if (image == nil) {
            image = [[UIImage alloc] init];
        }
        [images addObject:image];
    }
    
    return images;
}
/// 所有的本地测试图片的名称
+ (NSArray<NSString *> *)cjts_localImageNames {
    NSArray<NSString *> *imagesNames = @[@"cqts_1.jpg",
                                         @"cqts_2.jpg",
                                         @"cqts_3.jpg",
                                         @"cqts_4.jpg",
                                         @"cqts_5.jpg",
                                         @"cqts_6.jpg",
                                         @"cqts_7.jpg",
                                         @"cqts_8.jpg",
                                         @"cqts_9.jpg",
                                         @"cqts_10.jpg",
                                         @"cqts_long_horizontal_1.jpg",
                                         @"cqts_long_vertical_1.jpg",
    ];
    
    return imagesNames;
}

/// 随机的本地测试图片
+ (UIImage *)cjts_localImageRandom {
    NSArray<UIImage *> *images = [self cjts_localImages];
    NSInteger selIndex = random()%images.count;
    UIImage *image = [images objectAtIndex:selIndex];
    
    return image;
}

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (UIImage *)cjts_localImageAtIndex:(NSInteger)selIndex {
    NSArray<UIImage *> *images = [self cjts_localImages];
    if (selIndex >= images.count) { //位置太大的时候，固定使用第一张图片
        selIndex = 0;
    }
    UIImage *image = [images objectAtIndex:selIndex];
    return image;
}

+ (UIImage *)cjts_localImage1 {
    UIImage *image = [UIImage cqdemokit_xcassetImageNamed:@"cqts_1.jpg"];
    return image;
}

+ (UIImage *)cjts_localImage2 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_2.jpg"];
}

+ (UIImage *)cjts_localImage3 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_3.jpg"];
}

+ (UIImage *)cjts_localImage4 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_4.jpg"];
}

+ (UIImage *)cjts_localImage5 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_5.jpg"];
}

+ (UIImage *)cjts_localImage6 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_6.jpg"];
}

+ (UIImage *)cjts_localImage7 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_7.jpg"];
}

+ (UIImage *)cjts_localImage8 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_8.jpg"];
}

+ (UIImage *)cjts_localImage9 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_9.jpg"];
}

+ (UIImage *)cjts_localImage10 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_10.jpg"];
}

#pragma mark - test Image
/// 水平长图
+ (UIImage *)longHorizontal01 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_long_horizontal_1.jpg"];
}

/// 竖直长图
+ (UIImage *)longVertical01 {
    return [UIImage cqdemokit_xcassetImageNamed:@"cqts_long_vertical_1.jpg"];
}

@end
