//
//  UIImage+CJBundleImage.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImage+CJBundleImage.h"

@implementation UIImage (CJBundleImage)

+ (UIImage *)commonPickerImageNamed:(NSString *)imageName {
    return [self getImageWithBundleName:@"CQImageChooseViewBundle" imageName:imageName];
}

+ (UIImage *)getImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CJDemoDatePickerView")];//此处不能使用UIImage作为获取bundle的类
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    NSAssert(url, @"bundleUrl不能为空");
    
    NSBundle *targetBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:imageName inBundle:targetBundle compatibleWithTraitCollection:nil];
    return image;
}

@end
