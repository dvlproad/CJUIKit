//
//  CJSliderControl.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  注意：CJSliderControl可滑动的区域就是滑到的区域，并且是以滑块的中心来判断是否超出滑道区域的(而不是滑块的originX)

#import <UIKit/UIKit.h>
#import "CJSliderPopover.h"

@class CJSliderControl;
/**
 *   弹出框显示内容的枚举类型
 */
typedef NS_ENUM(NSUInteger, CJSliderPopoverDispalyType) {
    CJSliderPopoverDispalyTypeNone,         /**< 没有Popover */
    CJSliderPopoverDispalyTypeNum,          /**< 纯数字显示 */
    CJSliderPopoverDispalyTypePercent,      /**< 百分比显示 */
};

typedef NS_ENUM(NSUInteger, CJSliderControlThumbCannotBeyongXType) {
    CJSliderControlThumbCannotBeyongXTypeMidX,           /**< 默认(滑块的中心不可越界) */
    CJSliderControlThumbCannotBeyongXTypeAllX,          /**< 滑块的左右边界都不应该越界 */
};

@protocol CJSliderControlDelegate <NSObject>

/**
 *  slider拖动后处罚这个回调方法
 *
 *  @param slider 当前slider控件
 *  @param value  改变后的值
 */
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value;

@end

/**
 *  单向滑竿、popover支持百分比和纯数字显示
 */
@interface CJSliderControl : UIControl {
    
}
@property (nonatomic, weak) id<CJSliderControlDelegate> delegate;

@property (nonatomic, assign) CGFloat minValue;     /**< 最小值 */
@property (nonatomic, assign) CGFloat maxValue; /**< 最大值 */

@property (nonatomic, assign) CJSliderPopoverDispalyType popoverType; /**< 弹出框的类型 */
@property (nonatomic, assign) CJSliderControlThumbCannotBeyongXType thumbCannotBeyongXType; /**< 滑块的哪些X不能越界 */
@property (nonatomic, assign) CGSize thumbSize;
@property (nonatomic, assign) CGSize popoverSize;

@property (nonatomic, strong) UIColor *minimumTrackTintColor; /**< 最小值方向滑竿颜色值 */

@property (nonatomic, strong) UIColor *maximumTrackTintColor; /**< 最大值方向滑竿颜色值 */

@property (nonatomic, assign) CGFloat value;            /**< 当前值 */
@property (nonatomic, strong) UIImage *mainThumbImage;  /**< 滑块图片,默认是橙色按钮 */
@property (nonatomic, assign) CGFloat mainThumbAlpha;   /**< 主滑块的透明度 */

@property (nonatomic, assign) CGFloat baseValue;        /**< 基准值(默认0) */
@property (nonatomic, strong) UIImage *leftThumbImage;  //**< 左滑块的图片,默认是橙色按钮 */
@property (nonatomic, assign) CGFloat leftThumbAlpha;   /**< 左滑块的透明度 */

@property (nonatomic, assign) CGFloat trackHeight; //滑道高度

/**
 *  隐藏或显示文字
 *
 *  @param isHidden 是否隐藏
 */
- (void)hidePopover:(BOOL)isHidden;

- (void)showThumbOnBaseValue;

@end

