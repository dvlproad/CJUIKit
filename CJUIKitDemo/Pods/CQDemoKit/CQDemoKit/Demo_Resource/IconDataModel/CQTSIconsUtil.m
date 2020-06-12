//
//  CQTSIconsUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSIconsUtil.h"

@implementation CQTSIconsUtil

/// 获取测试用的数据(image为icon图片)
///
/// @param count 图片个数
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSIconDataModel *> *)__getTestIconImageDataModelsWithCount:(NSInteger)count {
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
        
        NSInteger selIndex = random()%selStrings.count;
        NSString *selString = [selStrings objectAtIndex:selIndex];
        SEL sel = NSSelectorFromString(selString);
        dataModel.imageUrl = [CQTSIconsUtil performSelector:sel];
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
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    return image;
}



#pragma mark - icon ImageUrl
+ (NSString *)cjts_iconImageUrl1 {
    return @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4012764803,2714809145&fm=26&gp=0.jpg";
}

+ (NSString *)cjts_iconImageUrl2 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263545058&di=cbe1e0a579231c04bf511c0d2fc72460&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D329733760%2C3032832928%26fm%3D214%26gp%3D0.jpg";
}

+ (NSString *)cjts_iconImageUrl3 {
    return @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2349859212,1053714951&fm=26&gp=0.jpg";
}

+ (NSString *)cjts_iconImageUrl4 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263068902&di=5874c527bfd19f27db2b066e74411eb6&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F5fdf8db1cb13495404d04cf4544e9258d0094a57.jpg";
}

+ (NSString *)cjts_iconImageUrl5 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263601036&di=3876d2d43d466f9678206ef237626834&imgtype=0&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D1879040502%2C280709257%26fm%3D214%26gp%3D0.jpg";
}

+ (NSString *)cjts_iconImageUrl6 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263627980&di=22fd69f597e7b87c353bc98a85a0d453&imgtype=0&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D3488745561%2C199519317%26fm%3D214%26gp%3D0.jpg";
}

+ (NSString *)cjts_iconImageUrl7 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263611842&di=04be24736a2727a95bfbf05fdefee3ea&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F30%2F37%2F19300001372833132237377419887.png";
}

+ (NSString *)cjts_iconImageUrl8 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586263649084&di=f84aae3f3e512116dec9fba77cd7027e&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3283679520%2C4132935319%26fm%3D214%26gp%3D0.jpg";
}


@end
