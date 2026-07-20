//
//  CommentsPopView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/05/10.
//  Copyright © 2019年 dvlproad. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface CQCommentsPopView:UIView

+ (instancetype)commentsPopViewWithFrame:(CGRect)frame commentBackView:(UIView *)commentBackView;
- (void)showToView:(UIView *)view;
- (void)dismiss;

@end






