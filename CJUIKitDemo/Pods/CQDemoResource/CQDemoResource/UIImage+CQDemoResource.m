//
//  UIImage+CQDemoResource.m
//  CQDemoResource
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIImage+CQDemoResource.h"
#import <CQDemoKit/UIImage+CQTSInFramework.h>

@implementation UIImage (CQDemoResource)
/*
+ (nullable UIImage *)cqdemokit_imageNamed:(NSString *)name {
    NSString *imageName = [NSString stringWithFormat:@"CQDemoKit.bundle/%@", name];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}
*/

+ (nullable UIImage *)cqresource_imageNamed:(NSString *)name {
    // bundle 获取
    /*
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CQTSLocImagesUtil")];
    if (bundle == nil) {
        return nil;
    }
    NSURL *url = [bundle URLForResource:@"CQDemoKit" withExtension:@"bundle"];
    if (url == nil) {
        return nil;
    }
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    */
    NSBundle *imageBundle = [NSBundle cqdemo_framework_resourceBundle];
    
    UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
    return image;
}

// 不进行缓存，仅限获取 非xcasset内 的图片
+ (nullable UIImage *)cqresource_noCache_imageNamed:(NSString *)name {
    NSBundle *imageBundle = [NSBundle cqdemo_framework_resourceBundle];
    
    // 来源于 CQDemoKit 的 UIImage *image = [self cqts_noCache_imageNamed:name inBundle:imageBundle];
    NSString *fileExtension = [name pathExtension];
    NSString *fileNameWithoutExtension = [[name lastPathComponent] stringByDeletingPathExtension];
    NSString *imagePath = [imageBundle pathForResource:fileNameWithoutExtension ofType:fileExtension];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

@end



@implementation NSBundle (CQDemoResource)

// 参数 bundleName ，用来处理这个 pod 里有多个 bundle 需要获取的情况
+ (nullable NSBundle *)cqdemo_framework_resourceBundle {
    NSString *bundleName = @"CQDemoResource";
    return [NSBundle cqts_framework_resourceBundle:bundleName ocClassName:@"CQTSAssetSourceUtil"];
}

@end
