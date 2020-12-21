//
//  CJDemoPopupView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoPopupView.h"
#import "UIView+CJPopupInView.h"

@implementation CJDemoPopupView

/**
 *  显示当前视图到window底部
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInBottomWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    /* 对popupView做一些默认设置 */
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, -2);
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOpacity = 0.8;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGFloat popupViewWidth = CGRectGetWidth(keyWindow.frame) - edgeInsets.left - edgeInsets.right;
//    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
//    [self cj_addRounderCornerWithRadius:10
//                                   size:popupViewSize
//                        backgroundColor:[UIColor orangeColor]
//                            borderWidth:4
//                            borderColor:[UIColor purpleColor]
//     ];
    
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [self hidePopupView];
    }];
}

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInCenterWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize popupViewSize = CGSizeMake(screenWidth-15, popupViewHeight);
    
    [self cj_popupInCenterWindow:CJAnimationTypeNormal withSize:popupViewSize centerOffset:CGPointZero blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [self hidePopupView];
    }];
}

/**
 *  隐藏弹出视图
 */
- (void)hidePopupView {
    [self cj_hidePopupView];
}


- (void)cj_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                      backgroundColor:(UIColor *)backgroundColor
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, backgroundColor.CGColor);   //设置填充颜色
    CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor);   //描边颜色
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
