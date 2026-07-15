//
//  CQTSLocImagesUtil.m
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSLocImagesUtil.h"
#import "CQTSAssetSourceUtil.h"

@implementation CQTSLocImagesUtil

#pragma mark - placeholder Image
+ (UIImage *)cjts_placeholderImage01 {
    return [UIImage cqresource_imageNamed:@"cqts_placeholder01.jpg"];
}

#pragma mark - local BGImage
+ (UIImage *)cjts_localImageBG1 {
    return [UIImage cqresource_imageNamed:@"cqts_bgSky.jpg"];
}

+ (UIImage *)cjts_localImageBG2 {
    return [UIImage cqresource_imageNamed:@"cqts_bgCar.jpg"];
}

#pragma mark - High Scale
/// 水平长图
+ (UIImage *)longHorizontal01 {
    return [UIImage cqresource_imageNamed:@"cqts_long_horizontal_1.jpg"];
}

/// 竖直长图
+ (UIImage *)longVertical01 {
    return [UIImage cqresource_imageNamed:@"cqts_long_vertical_1.jpg"];
}



#pragma mark - local Image

/// 所有的本地测试图片
+ (NSArray<UIImage *> *)cjts_localImages {
    NSMutableArray<UIImage *> *images = [[NSMutableArray alloc] init];
    
    NSArray<NSString *> *imageNames = [self cjts_localImageNames];
    NSInteger imageCount = [imageNames count];
    for (int i = 0; i < imageCount; i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        UIImage *image = [UIImage cqresource_imageNamed:imageName];
        if (image == nil) {
            image = [[UIImage alloc] init];
        }
        [images addObject:image];
    }
    
    return images;
}


/// 随机的本地测试图片
+ (UIImage *)cjts_localImageRandom {
    NSInteger trySelIndex = random();
    
    UIImage *image = [self cjts_localImageAtIndex:trySelIndex];
    return image;
}

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (UIImage *)cjts_localImageAtIndex:(NSInteger)trySelIndex {
    NSArray<NSString *> *imageNames = [self cjts_localImageNames];
    NSInteger selIndex = trySelIndex % imageNames.count;    //位置太大的时候，从头循环使用图片
    NSString *imageName = [imageNames objectAtIndex:selIndex];
    
    UIImage *image = [UIImage cqresource_imageNamed:imageName];
    if (image == nil) {
        NSLog(@"[%@]:CQDemoResource 加载本地图片失败 image == nil", imageName);
    }
    return image;
}

+ (NSArray<NSString *> *)cjts_localImageNames {
    NSArray<NSString *> *imageExtensions = @[@"png", @"jpg", @"gif", @"webp", @"svg"];
    return [CQTSAssetSourceUtil localFileNames:imageExtensions];
}


@end
