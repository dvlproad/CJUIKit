//
//  UIView+CJGestureRecognizer.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/22/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GestureRecognizer)

///添加单击手势
- (UITapGestureRecognizer *)cj_addSingleTapWithTarget:(id)target mSEL:(SEL)sel;

///添加双击手势(只有当doubleTapGR识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别)
- (UITapGestureRecognizer *)cj_addDoubleTapWithTarget:(id)target mSEL:(SEL)sel ignoreSingleTapGR:(UITapGestureRecognizer *)singleTapGR;

@end
