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
/// @param count 图片个数
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModelsWithCount:(NSInteger)count {
    NSArray<UIImage *> *images = [self cjts_localImages];
    
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < count; i++) {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = [NSString stringWithFormat:@"%zd", i];
        
        NSInteger selIndex = random()%images.count;
        UIImage *image = [images objectAtIndex:selIndex];
        dataModel.image = image;
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}
    
    

/// 获取测试用的数据(image为本地图片)
+ (NSMutableArray<CQTSLocImageDataModel *> *)__getTestLocalImageDataModels {
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"1X透社";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage1];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"2新鲜事";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage2];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"3XX信";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage3];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"4X角信";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage4];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"5蓝精灵";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage5];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"6年轻范";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage6];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"7XX福";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage7];
        [dataModels addObject:dataModel];
    }
    {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        dataModel.name = @"8X之语";
        dataModel.image = [CQTSLocImagesUtil cjts_localImage8];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
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
    NSArray<UIImage *> *images = @[[CQTSLocImagesUtil cjts_localImage1],
                                   [CQTSLocImagesUtil cjts_localImage2],
                                   [CQTSLocImagesUtil cjts_localImage3],
                                   [CQTSLocImagesUtil cjts_localImage4],
                                   [CQTSLocImagesUtil cjts_localImage5],
                                   [CQTSLocImagesUtil cjts_localImage6],
                                   [CQTSLocImagesUtil cjts_localImage7],
                                   [CQTSLocImagesUtil cjts_localImage8],
                                   [CQTSLocImagesUtil cjts_localImage9],
                                   [CQTSLocImagesUtil cjts_localImage10],
                                   [CQTSLocImagesUtil longHorizontal01],
                                   [CQTSLocImagesUtil longVertical01],
    ];
    
    return images;
}

/// 随机的本地测试图片
+ (UIImage *)cjts_localImageRandom {
    NSArray<UIImage *> *images = [self cjts_localImages];
    NSInteger selIndex = random()%images.count;
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
