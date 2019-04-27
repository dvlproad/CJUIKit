//
//  UITextField+CJPadding.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置 UITextField 的内边距
 */
@interface UITextField (CJPadding)

/**
 *  设置文字距左边框的距离
 *
 *  @param leftOffset 文字距左边框的距离
 */
- (void)cj_addLeftOffset:(CGFloat)leftOffset;

/**
 *  设置文字距右边框的距离
 *
 *  @param rightOffset 设置文字距右边框的距离
 */
- (void)cj_addRightOffset:(CGFloat)rightOffset;



///设置 UITextField 的上内边距
- (void)cj_setPaddingTop:(CGFloat)paddingTop;

///设置 UITextField 的左内边距
- (void)cj_setPaddingLeft:(CGFloat)paddingLeft;

///设置 UITextField 的下内边距
- (void)cj_setPaddingBottom:(CGFloat)paddingBottom;

///设置 UITextField 的右边距
- (void)cj_setPaddingRight:(CGFloat)paddingRight;

///设置 UITextField 的内边距
- (void)cj_setPaddingEdge:(UIEdgeInsets)paddingEdge;

@end
