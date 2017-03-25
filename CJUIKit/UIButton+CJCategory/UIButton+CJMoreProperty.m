//
//  UIButton+CJMoreProperty.m
//  CJUIKitDemo
//
//  Created by lichq on 7/9/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "UIButton+CJMoreProperty.h"

static NSString *cjModelKey = @"cjModelKey";

@implementation UIButton (CJMoreProperty)

#pragma mark - runtime
//cjModel
- (id)cjModel {
    return objc_getAssociatedObject(self, &cjModelKey) ;
}

- (void)setCjModel:(id)cjModel {
    return objc_setAssociatedObject(self, &cjModelKey, cjModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
