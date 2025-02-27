//
//  CQTSIconsUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSIconsUtil.h"
#import "CQTSImageLoader.h"

@implementation CQTSIconsUtil

/// 获取测试用的数据(image为icon图片)
///
/// @param count                图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder {
    NSArray *selStrings = @[NSStringFromSelector(@selector(cjts_iconImageUrl1)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl2)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl3)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl4)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl5)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl6)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl7)),
                            NSStringFromSelector(@selector(cjts_iconImageUrl8)),
    ];
    
    
    NSMutableArray<CQTSIconDataModel *> *dataModels = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < count; i++) {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastSelIndex = maySelIndex%selStrings.count;
        
        NSString *selString = [selStrings objectAtIndex:lastSelIndex];
        SEL sel = NSSelectorFromString(selString);
        dataModel.imageUrl = [CQTSIconsUtil performSelector:sel];
        dataModel.name = [NSString stringWithFormat:@"%zd:%@", i, selString];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}


/// 获取测试用的数据(image为icon图片)
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModels {
    NSMutableArray<CQTSIconDataModel *> *dataModels = [[NSMutableArray alloc] init];
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"1X透社";
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl1];
        dataModel.badgeCount = 0;
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"2新鲜事";
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl2];
        dataModel.badgeCount = 1;
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"3XX信";
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl3];
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"4X角信";
        dataModel.badgeCount = 9;
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl4];
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"5蓝精灵";
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl5];
        dataModel.badgeCount = 10;
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"6年轻范";
        dataModel.badgeCount = 99;
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl6];
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"7XX福";
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl7];
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"8X之语";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl8];
        [dataModels addObject:dataModel];
    }
    {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        dataModel.name = @"我是6个字";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = [CQTSIconsUtil cjts_iconImageUrl8];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}

#pragma mark - icon Image
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)cjts_iconUrls {
    NSArray<NSString *> *imageUrls = @[
        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4012764803,2714809145&fm=26&gp=0.jpg",
        @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2349859212,1053714951&fm=26&gp=0.jpg",
        #pragma mark 以下网络图片从 https://image.baidu.com 中获取
        @"https://img2.baidu.com/it/u=248809548,2992510422&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500",
        @"https://img0.baidu.com/it/u=3181153752,3984838184&fm=26&fmt=auto",
        @"https://img0.baidu.com/it/u=3087067444,242345469&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
        @"https://img0.baidu.com/it/u=2142566046,3495686177&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
        @"https://img2.baidu.com/it/u=3935222850,2993881202&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500",
        @"https://img1.baidu.com/it/u=1110022854,3922459600&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500",
        @"https://img0.baidu.com/it/u=2618490059,1120160608&fm=253&fmt=auto&app=138&f=JPEG?w=560&h=500",
    ];
    return imageUrls;
}

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_iconUrlAtIndex:(NSInteger)selIndex {
    NSArray<NSString *> *imageUrls = [self cjts_iconUrls];
    if (selIndex >= imageUrls.count) {  //位置太大的时候，固定使用第一张图片
        selIndex = 0;
    }
    NSString *imageUrl = [imageUrls objectAtIndex:selIndex];
    
    return imageUrl;
}

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



#pragma mark - icon ImageUrl
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
