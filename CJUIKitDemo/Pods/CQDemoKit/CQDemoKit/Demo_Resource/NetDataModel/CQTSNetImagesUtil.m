//
//  CQTSNetImagesUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSNetImagesUtil.h"

@implementation CQTSNetImagesUtil

/// 获取测试用的数据(image为网络图片地址)
///
/// @param count        图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSNetImageDataModel *> *)__getTestNetImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder {
    NSArray<NSString *> *selStrings = [self __cjts_imageUrlSelStrings];
    
    NSMutableArray<CQTSNetImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < count; i++) {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastSelIndex = maySelIndex%selStrings.count;
        
        NSString *selString = [selStrings objectAtIndex:lastSelIndex];
        SEL sel = NSSelectorFromString(selString);
        dataModel.imageUrl = [CQTSNetImagesUtil performSelector:sel];
        //dataModel.imageUrl = self.cjts_imageUrls[selIndex];
        dataModel.name = [NSString stringWithFormat:@"%zd:%@", i, selString];
        dataModel.badgeCount = i;
        
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}
   


/// 获取测试用的数据(image为网络图片)
+ (NSMutableArray<CQTSNetImageDataModel *> *)__getTestNetImageDataModels {
    NSMutableArray<CQTSNetImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"1X透社";
        dataModel.imageUrl =  self.cjts_imageUrls[0];
        dataModel.badgeCount = 0;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"2新鲜事";
        dataModel.imageUrl = self.cjts_imageUrls[1];
        dataModel.badgeCount = 1;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"3XX信";
        dataModel.imageUrl = self.cjts_imageUrls[2];
        dataModel.badgeCount = 0;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"4X角信";
        dataModel.badgeCount = 9;
        dataModel.imageUrl = self.cjts_imageUrls[3];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"5蓝精灵";
        dataModel.imageUrl = self.cjts_imageUrls[4];
        dataModel.badgeCount = 10;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"6年轻范";
        dataModel.badgeCount = 99;
        dataModel.imageUrl = self.cjts_imageUrls[5];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"7XX福";
        dataModel.imageUrl = self.cjts_imageUrls[6];
        dataModel.badgeCount = 1;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"8X之语";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = self.cjts_imageUrls[7];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"我是6个字";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = self.cjts_imageUrls[8];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}



#pragma mark network ImageUrl
/// 所有的网络测试图片地址
+ (NSArray<NSString *> *)cjts_imageUrls {
    NSArray<NSString *> *imageUrls = @[
        #pragma mark 以下网络图片从 https://stock.tuchong.com 中获取
        @"https://cdn3-banquan.ituchong.com/weili/l/903088213443084399.jpeg",
        @"https://cdn3-banquan.ituchong.com/weili/l/902924454934609986.jpeg",
        @"https://cdn9-banquan.ituchong.com/weili/l/914495302984269898.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/1113166746308968471.jpeg",
        @"https://cdn9-banquan.ituchong.com/weili/l/1113170740519632955.jpeg",
        @"https://cdn3-banquan.ituchong.com/weili/l/1068890057315319833.jpeg",
        @"https://cdn9-banquan.ituchong.com/weili/l/1016768155267367042.jpeg",
        @"https://cdn9-banquan.ituchong.com/weili/l/1026741765014028478.jpeg",
        @"https://cdn9-banquan.ituchong.com/weili/l/967833239214751792.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/966827220441759777.jpeg",
        
        @"https://cdn6-banquan.ituchong.com/weili/l/919795258271596547.jpeg",
        @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=355970603,3245667099&fm=26&gp=0.jpg",
        @"https://cdn3-banquan.ituchong.com/weili/l/1073188615191658529.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/57461353849430061.jpeg",
        @"https://cdn6-banquan.ituchong.com/weili/l/1017308169985458197.jpeg",
        #pragma mark 以下网络图片从 https://www.droitstock.com/ 中获取
        @"https://img1.droitstock.com/middleW/0a/3c/373880000.jpg",
        @"https://img1.droitstock.com/middleW/76/d4/324995286.jpg",
        @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1892357736,3979425284&fm=26&gp=0.jpg",
        @"https://img1.droitstock.com/middleW/bd/f0/241894345.jpg",
        @"https://img1.droitstock.com/middleW/41/4f/134317211.jpg",
        
        @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3155622504,3922873140&fm=26&gp=0.jpg",
        @"https://img1.droitstock.com/middleW/5b/9c/824812856.jpg",
        @"https://img1.droitstock.com/middleW/5a/8d/381503287.jpg",
        @"https://img1.droitstock.com/middleW/b6/22/164126642.jpg",
        @"https://img1.droitstock.com/middleW/df/26/271782228.jpg",
        
        #pragma mark 以下网络图片从 https://www.veer.com 中获取
        @"https://alifei04.cfp.cn/creative/vcg/veer/800water/veer-163722653.jpg",
        @"https://alifei01.cfp.cn/creative/vcg/veer/800water/veer-132426620.jpg"
        
    ];
    
    return imageUrls;
}

/// 随机的网络测试图片地址
+ (NSString *)cjts_imageUrlRandom {
    NSArray<NSString *> *imageUrls = [self cjts_imageUrls];
    NSInteger selIndex = random()%imageUrls.count;
    NSString *imageUrl = [imageUrls objectAtIndex:selIndex];
    
    return imageUrl;
}

/// 获取指定位置的图片(为了cell显示的图片不会一直变化)
+ (NSString *)cjts_imageUrlAtIndex:(NSInteger)selIndex {
    NSArray<NSString *> *imageUrls = [self cjts_imageUrls];
    if (selIndex >= imageUrls.count) {  //位置太大的时候，固定使用第一张图片
        selIndex = 0;
    }
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
