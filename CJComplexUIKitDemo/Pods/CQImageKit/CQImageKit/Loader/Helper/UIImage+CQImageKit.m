//
//  UIImage+CQImageKit.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIImage+CQImageKit.h"

@implementation UIImage (CQImageKit)

+ (nullable UIImage *)cqImagekit_imageNamed:(NSString *)name {
    NSString *imageName = [NSString stringWithFormat:@"CQImageKit.bundle/%@", name];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

+ (nullable UIImage *)cqImagekit_xcassetImageNamed:(NSString *)name {
    if(name && ![name isEqualToString:@""]) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"UIImageCQCutHelper")];
        if (bundle == nil) {
            return nil;
        }
        NSURL *url = [bundle URLForResource:@"CQImageKit" withExtension:@"bundle"];
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
