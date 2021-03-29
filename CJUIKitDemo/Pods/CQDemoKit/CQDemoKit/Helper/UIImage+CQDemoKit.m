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
    if(name && ![name isEqualToString:@""]) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CQTSLocImagesUtil")];
        if (bundle == nil) {
            bundle = [NSBundle bundleForClass:NSClassFromString(@"CJUIKitBaseTabBarViewController")];
        }
        NSURL *url = [bundle URLForResource:@"CQDemoKit" withExtension:@"bundle"];
        if (url == nil) {
            return nil;
        }
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
        return image;
    }
    
    return nil;
}

@end
