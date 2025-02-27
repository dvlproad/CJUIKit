//
//  UIImage+CQDemoKit.m
//  TSDemoDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIImage+CQDemoKit.h"

@implementation UIImage (CQDemoKit)

+ (nullable UIImage *)cqdemokit_imageNamed:(NSString *)name {
    NSString *imageName = [NSString stringWithFormat:@"CQDemoKit.bundle/%@", name];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

+ (nullable UIImage *)cqdemokit_xcassetImageNamed:(NSString *)name {
    return [self cqdemokit_xcassetImageNamed:name withCache:YES];
}

+ (nullable UIImage *)cqdemokit_xcassetImageNamed:(NSString *)name withCache:(BOOL)shouldCache {
    if(name == nil || [name isEqualToString:@""]) {
        return nil;
    }
    
    // bundle 获取
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CQTSLocImagesUtil")];
    if (bundle == nil) {
        bundle = [NSBundle bundleForClass:NSClassFromString(@"CJUIKitBaseTabBarViewController")];
    }
    NSURL *url = [bundle URLForResource:@"CQDemoKit" withExtension:@"bundle"];
    if (url == nil) {
        return nil;
    }
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    // image
    UIImage *image;
    if (!shouldCache) {
        NSString *fileExtension = [name pathExtension];
        NSString *fileNameWithoutExtension = [[name lastPathComponent] stringByDeletingPathExtension];
        NSString *imagePath = [imageBundle pathForResource:fileNameWithoutExtension ofType:fileExtension];
        image = [UIImage imageWithContentsOfFile:imagePath];
    } else {
        image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
    }
    return image;
}

@end
