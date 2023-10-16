//
//  CQEffectViewFactory.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQEffectViewFactory.h"

@implementation CQEffectViewFactory

+ (UIColor *)cqCustom_selfBottom_blankBGColor {
    UIColor *blankBGColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:.8];
    return blankBGColor;
}

+ (UIColor *)cqCustom_selfCenter_blankBGColor {
    UIColor *blankBGColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:.8];
    return blankBGColor;
}


/*
 *  对[backForSuperview中紧靠closeToSubview]的区域，添加[指定effectStyle]的毛玻璃效果，作为背景
 *
 *  @param effectStyle      毛玻璃样式
 *  @param backForSuperview 要添加的效果是作为哪个视图的背景层/第一层
 *  @param closeToSubview   要添加的效果是依靠布局在哪个视图区域上
 */
+ (UIVisualEffectView *)addEffectWithStyle:(UIBlurEffectStyle)effectStyle
                               backForView:(UIView *)backForSuperview
                               closeToView:(UIView *)closeToSubview
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effectStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    [self __addEffectView:effectView backForView:backForSuperview closeToView:closeToSubview];
    
    return effectView;
}

/*
 *  对[backForSuperview中紧靠closeToSubview]的区域，添加毛玻璃效果，作为背景
 *
 *  @param effectView       要添加的效果的视图样子
 *  @param backForSuperview 要效果的效果是作为哪个视图的背景层/第一层
 *  @param closeToSubview   要添加的效果是在哪个视图区域上
 */
+ (void)__addEffectView:(UIVisualEffectView *)effectView
            backForView:(UIView *)backForSuperview
            closeToView:(UIView *)closeToSubview
{
    //backForSuperview = closeToSubview.superview;
#ifdef DEBUG
    BOOL isChildView =  [closeToSubview isDescendantOfView:backForSuperview];
    NSAssert(isChildView == YES, @"请确保effectForView包含在backForSuperview中");
#endif
//    [backForSuperview insertSubview:effectView aboveSubview:closeToSubview];
    [backForSuperview addSubview:effectView];
    [backForSuperview sendSubviewToBack:effectView];   // popupView已经改成添加到blankView中了
    effectView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [backForSuperview addConstraint:
     [NSLayoutConstraint constraintWithItem:effectView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:closeToSubview
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [backForSuperview addConstraint:
     [NSLayoutConstraint constraintWithItem:effectView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:closeToSubview
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [backForSuperview addConstraint:
     [NSLayoutConstraint constraintWithItem:effectView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:closeToSubview
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    [backForSuperview addConstraint:
     [NSLayoutConstraint constraintWithItem:effectView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:closeToSubview
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
