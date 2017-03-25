//
//  UIImage+CJLaunchImage.m
//  CJUIKitDemo
//
//  Created by lichq on 2016/12/14.
//  Copyright © 2016年 ciyouzen. All rights reserved.
//

#import "UIImage+CJLaunchImage.h"

NSString * const CJDefaultLaunchImageName = @"LaunchImage";

@implementation UIImage (CJLaunchImage)

+ (UIImage *)cj_LaunchImageDefault {
    return [self cj_LaunchImageNamed:CJDefaultLaunchImageName];
}

+ (UIImage *)cj_LaunchImageNamed:(NSString *)name {
    NSMutableString *imageName = [NSMutableString stringWithString:name];
    
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    //isiPad
    BOOL isiPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    //isLandscape
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(statusBarOrientation);
    
    if (isiPad) {
        if (isLandscape) {
            [imageName appendString:@"-700-Landscape"];
        } else {
            [imageName appendString:@"-700-Portrait"];
        }
        
        [imageName appendString:@"~ipad"];
        
    } else if (height == 568.f) {
        [imageName appendString:@"-700-568h"];
        
    } else if (height == 667.f) {
        [imageName appendString:@"-800-667h"];
        
    } else if (height == 736.f || height == 414.f) {
        if (isLandscape) {
            [imageName appendString:@"-800-Landscape-736h"];
        } else {
            [imageName appendString:@"-800-Portrait-736h"];
        }
        
    } else {
        [imageName appendString:@"-700"];
        
    }
    
    return [UIImage imageNamed:imageName];
}

@end
