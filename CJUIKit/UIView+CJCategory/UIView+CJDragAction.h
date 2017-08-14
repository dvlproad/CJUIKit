//
//  UIView+CJDragAction.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  类目说明：通过给View添加UIPanGestureRecognizer手势，使其可以移动到拖动的位置
 */
@interface UIView (CJDragAction)

@property (nonatomic, assign) BOOL cjDragEnable;   /**< 是否允许拖曳(默认YES) */
@property (nonatomic, copy) void(^cjDragBeginBlock)(UIView *view);    /**< 开始拖曳的回调 */
@property (nonatomic, copy) void(^cjDragDuringBlock)(UIView *view);   /**< 拖曳中的回调 */
@property (nonatomic, copy) void(^cjDragEndBlock)(UIView *view);      /**< 结束拖曳的回调 */


@end
