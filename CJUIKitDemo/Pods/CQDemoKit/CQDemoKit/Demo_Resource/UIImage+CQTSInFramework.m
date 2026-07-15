//
//  UIImage+CQTSInFramework.m
//  CQDemoKit
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIImage+CQTSInFramework.h"

#pragma mark - 没使用 use_frameworks! 时候，资源的获取方式
@implementation UIImage (CQTSInFramework)

// 不进行缓存，仅限获取 非xcasset内 的图片
+ (nullable UIImage *)cqts_noCache_imageNamed:(nullable NSString *)name
                                     inBundle:(nullable NSBundle *)imageBundle
{
    NSString *fileExtension = [name pathExtension];
    NSString *fileNameWithoutExtension = [[name lastPathComponent] stringByDeletingPathExtension];
    NSString *imagePath = [imageBundle pathForResource:fileNameWithoutExtension ofType:fileExtension];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

@end




#pragma mark - 使用 use_frameworks! 时候，资源的获取方式

@implementation NSBundle (CQTSInFramework)

// 从指定OC类所在的 framework 中取出 resource bundle (来源: CJBaseUtil-Swift 的 Bundle+InFramework.swift)
+ (nullable NSBundle *)cqts_framework_resourceBundle:(NSString *)bundleName
                                         ocClassName:(NSString *)ocClassName {
    // 1. 参数校验
    if (!bundleName || bundleName.length == 0) {
        NSLog(@"[CQDemo] 警告：bundleName 为空");
        return nil;
    }
    
    if (!ocClassName || ocClassName.length == 0) {
        NSLog(@"[CQDemo] 警告：ocClassName 为空");
        return nil;
    }
    
    // 2. 通过 OC 类名获取 Class
    Class frameworkClass = NSClassFromString(ocClassName);
    if (!frameworkClass) {
        NSLog(@"[CQDemo] 警告：未找到类 %@", ocClassName);
        return nil;
    }
    
    // 3. 获取类所在的 Framework Bundle
    NSBundle *frameworkBundle = [NSBundle bundleForClass:frameworkClass];
    if (!frameworkBundle) {
        NSLog(@"[CQDemo] 警告：无法获取 framework bundle");
        return nil;
    }
    
    // 4. 从 Framework Bundle 中查找资源 bundle 的 URL
    NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleURL) {
        NSLog(@"[CQDemo] 警告：未找到 %@.bundle", bundleName);
        return nil;
    }
    
    // 5. 加载资源 bundle
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    if (!resourceBundle) {
        NSLog(@"[CQDemo] 警告：无法加载 %@.bundle", bundleName);
        return nil;
    }
    
    return resourceBundle;
}

@end
