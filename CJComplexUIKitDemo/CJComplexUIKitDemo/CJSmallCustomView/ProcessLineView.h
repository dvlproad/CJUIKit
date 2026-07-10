//
//  ProcessLineView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2014/8/14.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  流程线视图中的圆类型
 */
typedef NS_ENUM(NSUInteger, PLVCircleType) {
    PLVCircleTypeToDo,      /**< 还未进行的 */
    PLVCircleTypeDoing,     /**< 正进行的 */
    PLVCircleTypeDone,      /**< 已完成的 */
};

/**
 *  流程线视图中的圆上下的线要有哪些
 */
typedef NS_OPTIONS(NSUInteger, PLVCircleLinesOption) {
    PLVCircleLinesOptionNone = 1 << 0,      /**< 圆圈的上下不画线条 */
    PLVCircleLinesOptionTop = 1 << 1,       /**< 只绘制圆圈的上部分线条 */
    PLVCircleLinesOptionBottom = 1 << 2,    /**< 只绘制圆圈的下部分线条 */
};

/**
 *  流程线视图
 */
@interface ProcessLineView : UIView

@property (nonatomic, assign) PLVCircleType circleType;     /**< 流程线视图中的圆类型 */
@property (nonatomic, assign) PLVCircleLinesOption circleLinesOption;/**< 流程线视图中的圆上下的线要有哪些 */


@end
