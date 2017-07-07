//
//  CJBadgeImageView.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBadgeImageView.h"

@implementation CJBadgeImageView

+ (void)initialize {
    // UIAppearance Proxy Defaults
    CJBadgeImageView *imageView = [self appearance];
    imageView.badgeBackgroudColor = [UIColor redColor];
    imageView.badgeTextColor = [UIColor whiteColor];
    imageView.badgeFont = [UIFont boldSystemFontOfSize:11];
    imageView.imageCornerRadius = 0;
    imageView.badgeSize = 20;
}

@end
