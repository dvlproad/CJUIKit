//
//  UIView+CJGestureRecognizer.m
//  CJUIKitDemo
//
//  Created by lichq on 7/22/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "UIView+CJGestureRecognizer.h"

@implementation UIView (GestureRecognizer)


#pragma mark - 添加单击手势
- (void)addTapGestureWithTarget:(id)target mSEL:(SEL)sel{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [tap setCancelsTouchesInView:NO];
    
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:tap];
}


@end
