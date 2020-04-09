//
//  CJUIKitResoucesUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitResoucesUtil.h"

@implementation CJUIKitResoucesUtil

+ (UIImage *)imageWithUrl:(NSString *)imageUrl {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    return image;
}


#pragma mark - icon Image
+ (UIImage *)cjts_iconImage1 {
    return [self imageWithUrl:[self cjts_iconImageUrl1]];
}

+ (UIImage *)cjts_iconImage2 {
    return [self imageWithUrl:[self cjts_iconImageUrl2]];
}

+ (UIImage *)cjts_iconImage3 {
    return [self imageWithUrl:[self cjts_iconImageUrl3]];
}

+ (UIImage *)cjts_iconImage4 {
    return [self imageWithUrl:[self cjts_iconImageUrl4]];
}

+ (UIImage *)cjts_iconImage5 {
    return [self imageWithUrl:[self cjts_iconImageUrl5]];
}

+ (UIImage *)cjts_iconImage6 {
    return [self imageWithUrl:[self cjts_iconImageUrl6]];
}

+ (UIImage *)cjts_iconImage7 {
    return [self imageWithUrl:[self cjts_iconImageUrl7]];
}

+ (UIImage *)cjts_iconImage8 {
    return [self imageWithUrl:[self cjts_iconImageUrl8]];
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


#pragma mark - normal Image
+ (UIImage *)cjts_image1 {
    return [self imageWithUrl:[self cjts_imageUrl1]];
}

+ (UIImage *)cjts_image2 {
    return [self imageWithUrl:[self cjts_imageUrl2]];
}

+ (UIImage *)cjts_image3 {
    return [self imageWithUrl:[self cjts_imageUrl3]];
}

+ (UIImage *)cjts_image4 {
    return [self imageWithUrl:[self cjts_imageUrl4]];
}

+ (UIImage *)cjts_image5 {
    return [self imageWithUrl:[self cjts_imageUrl5]];
}

+ (UIImage *)cjts_image6 {
    return [self imageWithUrl:[self cjts_imageUrl6]];
}

+ (UIImage *)cjts_image7 {
    return [self imageWithUrl:[self cjts_imageUrl7]];
}

+ (UIImage *)cjts_image8 {
    return [self imageWithUrl:[self cjts_imageUrl8]];
}

+ (UIImage *)cjts_image9 {
    return [self imageWithUrl:[self cjts_imageUrl9]];
}

+ (UIImage *)cjts_image10 {
    return [self imageWithUrl:[self cjts_imageUrl10]];
}

+ (UIImage *)cjts_image11 {
    return [self imageWithUrl:[self cjts_imageUrl11]];
}

+ (UIImage *)cjts_image12 {
    return [self imageWithUrl:[self cjts_imageUrl12]];
}

+ (UIImage *)cjts_image13 {
    return [self imageWithUrl:[self cjts_imageUrl13]];
}

+ (UIImage *)cjts_image14 {
    return [self imageWithUrl:[self cjts_imageUrl14]];
}

+ (UIImage *)cjts_image15 {
    return [self imageWithUrl:[self cjts_imageUrl15]];
}

+ (UIImage *)cjts_image16 {
    return [self imageWithUrl:[self cjts_imageUrl16]];
}

+ (UIImage *)cjts_image17 {
    return [self imageWithUrl:[self cjts_imageUrl17]];
}

+ (UIImage *)cjts_image18 {
    return [self imageWithUrl:[self cjts_imageUrl18]];
}

+ (UIImage *)cjts_image19 {
    return [self imageWithUrl:[self cjts_imageUrl19]];
}

+ (UIImage *)cjts_image20 {
    return [self imageWithUrl:[self cjts_imageUrl20]];
}

+ (UIImage *)cjts_image21 {
    return [self imageWithUrl:[self cjts_imageUrl21]];
}

+ (UIImage *)cjts_image22 {
    return [self imageWithUrl:[self cjts_imageUrl22]];
}

+ (UIImage *)cjts_image23 {
    return [self imageWithUrl:[self cjts_imageUrl23]];
}

+ (UIImage *)cjts_image24 {
    return [self imageWithUrl:[self cjts_imageUrl24]];
}

+ (UIImage *)cjts_image25 {
    return [self imageWithUrl:[self cjts_imageUrl25]];
}


#pragma mark normal ImageUrl
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
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=7f37b50d29c588696ae4fc2258b67636&imgtype=0&src=http%3A%2F%2Fwww.feizl.com%2Fupload2007%2F2014_09%2F14090617135391.jpg";
}

+ (NSString *)cjts_imageUrl11 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816373&di=09c5a0d72f2a5c407f2b4ee0d62ecc4b&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fe%2F0f%2F1b7e513753.jpg";
}

+ (NSString *)cjts_imageUrl12 {
    return @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2771695667,4069028531&fm=11&gp=0.jpg";
}

+ (NSString *)cjts_imageUrl13 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816372&di=6ea4fe20d6d7602e0679980989133320&imgtype=0&src=http%3A%2F%2Fimg.qq745.com%2Fuploads%2Fallimg%2F160813%2F11-160Q3102520.jpg";
}

+ (NSString *)cjts_imageUrl14 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816372&di=2dd8dc3c205c85eb3ca798be0a387846&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fca6d9b8ae88d6e3cef9a01599049bea9c9c549aa378a6-3RmOLu_fw658";
}

+ (NSString *)cjts_imageUrl15 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816372&di=71c862920a928db3a812ddb1249635ca&imgtype=0&src=http%3A%2F%2Fimg1c.xgo-img.com.cn%2Fpics%2F1699%2F1698893.jpg";
}

+ (NSString *)cjts_imageUrl16 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586203816371&di=93e727f5c4e0ea84c5a2a1b46348b2d7&imgtype=0&src=http%3A%2F%2Fimg.jk51.com%2Fimg_jk51%2F319203562.jpeg";
}

+ (NSString *)cjts_imageUrl17 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205486786&di=d5fdee80fe51461dd69a06bc118dc7a7&imgtype=0&src=http%3A%2F%2Fimg10.360buyimg.com%2Fimgzone%2Fjfs%2Ft2158%2F165%2F605407302%2F204006%2F3ef641b8%2F561b96b0N1ef5b568.jpg";
}

+ (NSString *)cjts_imageUrl18 {
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205486786&di=e08f92c5576be234968a977a0712f499&imgtype=0&src=http%3A%2F%2Fimage.namedq.com%2Fuploads%2F20191103%2F19%2F1572779306-CbwlrmPnJD.jpg";
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
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586205642604&di=7b2a95d4ff8df16491abe270addd72d2&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Fc%2Ffd%2F8dda1109631.jpg";
}

+ (NSString *)cjts_imageUrl26 {
    return @"https";
}


@end
