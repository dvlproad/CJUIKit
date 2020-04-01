//
//  UIView+CJGestureRecognizer.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/22/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIView+CJGestureRecognizer.h"

@implementation UIView (GestureRecognizer)


///添加单击手势
- (UITapGestureRecognizer *)cj_addSingleTapWithTarget:(id)target mSEL:(SEL)sel {
    [self setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    singleTapGR.numberOfTouchesRequired = 1;
    singleTapGR.numberOfTapsRequired = 1;
    [singleTapGR setCancelsTouchesInView:NO];
    
    [self addGestureRecognizer:singleTapGR];
    
    return singleTapGR;
}

///添加双击手势(只有当doubleTapGR识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别)
- (UITapGestureRecognizer *)cj_addDoubleTapWithTarget:(id)target mSEL:(SEL)sel ignoreSingleTapGR:(UITapGestureRecognizer *)singleTapGR {
    [self setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    doubleTapGR.numberOfTapsRequired = 2;
    doubleTapGR.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTapGR];
    
    [singleTapGR requireGestureRecognizerToFail:doubleTapGR];
    
    return doubleTapGR;
}


@end
