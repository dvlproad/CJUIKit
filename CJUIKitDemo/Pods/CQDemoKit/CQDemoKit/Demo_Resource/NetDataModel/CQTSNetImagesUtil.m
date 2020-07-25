//
//  CQTSNetImagesUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSNetImagesUtil.h"

@implementation CQTSNetImagesUtil


+ (void)setupImageView:(UIImageView *)imageView withImageUrl:(NSString *)imageUrl {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}


/// 获取测试用的数据(image为网络图片地址)
///
/// @param count        图片个数
/// @param randomOrder  顺序是否随机
///
/// @return 返回图片数据
+ (NSMutableArray<CQTSNetImageDataModel *> *)__getTestNetImageDataModelsWithCount:(NSInteger)count randomOrder:(BOOL)randomOrder {
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
    
    
    NSMutableArray<CQTSNetImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < count; i++) {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        
        if (randomOrder) {
            NSInteger selIndex = random()%selStrings.count;
            NSString *selString = [selStrings objectAtIndex:selIndex];
            SEL sel = NSSelectorFromString(selString);
            dataModel.imageUrl = [CQTSNetImagesUtil performSelector:sel];
            dataModel.name = [NSString stringWithFormat:@"%ld:%@", i, selString];
        } else {
            NSInteger selIndex = i%selStrings.count;
            NSString *selString = [selStrings objectAtIndex:selIndex];
            SEL sel = NSSelectorFromString(selString);
            dataModel.imageUrl = [CQTSNetImagesUtil performSelector:sel];
            dataModel.name = [NSString stringWithFormat:@"%ld:%@", i, selString];
        }
        
        
        
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
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl1];
        dataModel.badgeCount = 0;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"2新鲜事";
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl2];
        dataModel.badgeCount = 1;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"3XX信";
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl3];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"4X角信";
        dataModel.badgeCount = 9;
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl4];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"5蓝精灵";
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl5];
        dataModel.badgeCount = 10;
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"6年轻范";
        dataModel.badgeCount = 99;
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl6];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"7XX福";
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl7];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"8X之语";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl8];
        [dataModels addObject:dataModel];
    }
    {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        dataModel.name = @"我是6个字";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = [CQTSNetImagesUtil cjts_imageUrl8];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}



#pragma mark network ImageUrl
+ (NSString *)cjts_imageUrl1 {
    return @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1586193729&di=00aed1f537a4cf78aefdc8bb72c028b6&src=http://hbimg.b0.upaiyun.com/e9c0871fe111ce790c22052ed395ac19a8a9200ba5afa-VLWA3b_fw658";
}

+ (NSString *)cjts_imageUrl2 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816375&di=8ead288b4c75c14d7d0c795f905ef47b&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F2f6ae348b19c83fdc721ca5a54d4adb8d7455fa31dc76-GMqiCq_fw658";
}

+ (NSString *)cjts_imageUrl3 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816375&di=719c1119d4a139e7d7e60b8be28bf358&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F4%2Fd4%2F12621298581.jpg";
}

+ (NSString *)cjts_imageUrl4 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816375&di=e4a1b195186cc2556e261972e30734d4&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F5%2Fe9%2F93291056298.jpg";
}

+ (NSString *)cjts_imageUrl5 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816375&di=fdbe4ae096886a373200172f782ded73&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F9%2Fc0%2Ffc32878982.jpg";
}

+ (NSString *)cjts_imageUrl6 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=c491ec7314a867fe5aa121efa97fa00d&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F8%2F4e%2F007c362887.jpg";
}

+ (NSString *)cjts_imageUrl7 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=66d63f9dd22d952e307e9ed2d02e6aa2&imgtype=0&src=http%3A%2F%2Fimgfs.oppo.cn%2Fuploads%2Fthread%2Fattachment%2F2017%2F04%2F11%2F14918641864969.jpg";
}

+ (NSString *)cjts_imageUrl8 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=3315a1932ba94c0f2db5e6aae23e1646&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F2%2F7c%2Fbed1803982.jpg";
}

+ (NSString *)cjts_imageUrl9 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=1c5ed7cf53127f0e239fda6d2b75db1a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fc%2F1d%2F50b21252532.jpg";
}

+ (NSString *)cjts_imageUrl10 {
    return @"http://pic1.win4000.com/mobile/2017-11-27/5a1bda5b4f261.jpg";
}

+ (NSString *)cjts_imageUrl11 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=09c5a0d72f2a5c407f2b4ee0d62ecc4b&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fe%2F0f%2F1b7e513753.jpg";
}

+ (NSString *)cjts_imageUrl12 {
    return @"http://pic1.win4000.com/wallpaper/2018-01-26/5a6ae7a58070f.jpg";
}

+ (NSString *)cjts_imageUrl13 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816372&di=6ea4fe20d6d7602e0679980989133320&imgtype=0&src=http%3A%2F%2Fimg.qq745.com%2Fuploads%2Fallimg%2F160813%2F11-160Q3102520.jpg";
}

+ (NSString *)cjts_imageUrl14 {
    return @"http://pic1.win4000.com/wallpaper/b/5680fcc0d31b2.jpg";
}

+ (NSString *)cjts_imageUrl15 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816372&di=71c862920a928db3a812ddb1249635ca&imgtype=0&src=http%3A%2F%2Fimg1c.xgo-img.com.cn%2Fpics%2F1699%2F1698893.jpg";
}

+ (NSString *)cjts_imageUrl16 {
    return @"http://pic1.win4000.com/wallpaper/2018-01-26/5a6ae83c820f4.jpg";
}

+ (NSString *)cjts_imageUrl17 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205486786&di=d5fdee80fe51461dd69a06bc118dc7a7&imgtype=0&src=http%3A%2F%2Fimg10.360buyimg.com%2Fimgzone%2Fjfs%2Ft2158%2F165%2F605407302%2F204006%2F3ef641b8%2F561b96b0N1ef5b568.jpg";
}

+ (NSString *)cjts_imageUrl18 {
    return @"http://pic1.win4000.com/wallpaper/2017-10-19/59e8762e07803.jpg";
}

+ (NSString *)cjts_imageUrl19 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205584400&di=e32682ff97d8408e9357b27a35ce1fae&imgtype=0&src=http%3A%2F%2Fpictu.duouoo.com%2Fupload%2F9%2F11%2F911f966bf254201d6d8a9b3cfd2f00de.jpg";
}

+ (NSString *)cjts_imageUrl20 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205609427&di=3dfd8a727f088bd02e68f951d874df92&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F6%2F54%2Fdc3f1074816.jpg";
}

+ (NSString *)cjts_imageUrl21 {
    return @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3155622504,3922873140&fm=26&gp=0.jpg";
}

+ (NSString *)cjts_imageUrl22 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205609425&di=330982aebc41804d6f049c2ec7c85195&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F1%2Fb5%2F40841125750.jpg";
}

+ (NSString *)cjts_imageUrl23 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205642604&di=56a79b70c84635a0e1c32d0047c137fb&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fc%2Fcf%2Fa4291211955.jpg";
}

+ (NSString *)cjts_imageUrl24 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205642604&di=0b80668cb734dd8b8e2d273b7c820648&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fd%2F21%2F2d9a1323615.jpg";
}

+ (NSString *)cjts_imageUrl25 {
    return @"http://pic1.win4000.com/wallpaper/b/5680fcc0d31b2.jpg";
}

+ (NSString *)cjts_imageUrl26 {
    return @"https";
}


@end
