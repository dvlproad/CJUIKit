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
#import "CJAdsorbModel.h"

@class CJSliderControl;
/**
 *   弹出框显示内容的枚举类型
 */
typedef NS_ENUM(NSUInteger, CJSliderPopoverDispalyType) {
    CJSliderPopoverDispalyTypeNone,         /**< 没有Popover */
    CJSliderPopoverDispalyTypeNum,          /**< 纯数字显示 */
    CJSliderPopoverDispalyTypePercent,      /**< 百分比显示 */
};

typedef NS_ENUM(NSUInteger, CJSliderValueAccoringType) {
    CJSliderValueAccoringTypeThumbMidX, /**< 滑块的中心点所在的值，即为slider的值此时滑道长为view长减去滑块长) */
    CJSliderValueAccoringTypeThumbMinX, /**< 滑块的minX点所在的值，即为slider的值(此时滑道长即为view的长度) */
};

@protocol CJSliderControlDelegate <NSObject>

/**
 *  slider拖动后处罚这个回调方法
 *
 *  @param slider 当前slider控件
 *  @param value  改变后的值
 */
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value;

@optional
/**
 *  slider吸附到什么值
 *
 *  @param slider   当前slider控件
 *  @param value    吸附到的值
 */
- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value;

@end

/**
 *  单向滑竿、popover支持百分比和纯数字显示
 */
@interface CJSliderControl : UIControl {
    
}
/**
 *  slider的值有什么确认（默认根据滑块的中心确认值）
 *
 *  @attention ①值为CJSliderValueAccoringTypeThumbMidX时，滑块的中心点所在的值，即为slider的值，此时滑道长为view长减去滑块长；②CJSliderValueAccoringTypeThumbMinX时，滑块的minX点所在的值，即为slider的值(此时滑道长即为view的长度)
 */
@property (nonatomic, assign) CJSliderValueAccoringType valueAccoringType;

@property (nonatomic, weak) id<CJSliderControlDelegate> delegate;
@property (nonatomic, assign) BOOL allowTouchChangeValue;   /**< 是否允许通过点击来改变值(默认否) */

@property (nonatomic, assign) CGFloat minValue;     /**< 最小值(默认0) */
@property (nonatomic, assign) CGFloat maxValue;     /**< 最大值(默认1) */

@property (nonatomic, assign) CGFloat trackHeight;  /**< 滑道高度 */
@property (nonatomic, assign) CGSize thumbSize;     /**< 滑块大小 */

@property (nonatomic, strong) UIColor *minimumTrackTintColor;   /**< 最小值方向滑竿颜色值 */
@property (nonatomic, strong) UIImage *minimumTrackImage;       /**< 最小值方向滑竿的图片 */

@property (nonatomic, strong) UIColor *maximumTrackTintColor;   /**< 最大值方向滑竿颜色值 */
@property (nonatomic, strong) UIImage *maximumTrackImage;       /**< 最大值方向滑竿的图片 */

@property (nonatomic, assign) CGFloat value;            /**< 当前值 */
@property (nonatomic, strong) UIImage *mainThumbImage;  /**< 滑块图片,默认是橙色按钮 */
@property (nonatomic, assign) CGFloat mainThumbAlpha;   /**< 主滑块的透明度 */

@property (nonatomic, assign) CGFloat baseValue;        /**< 基准值(默认0) */
@property (nonatomic, strong) UIImage *leftThumbImage;  /**< 左滑块的图片,默认是橙色按钮 */
@property (nonatomic, assign) CGFloat leftThumbAlpha;   /**< 左滑块的透明度 */

@property (nonatomic, assign) CJSliderPopoverDispalyType popoverType; /**< 弹出框的类型 */
@property (nonatomic, assign) CGSize popoverSize;

@property (nonatomic, strong) NSArray<CJAdsorbModel *> *adsorbInfos; /** 设置吸附信息(含吸附区间及该区间要吸附到什么值)，上面的值是具体的滑块值，不是百分比 */

/**
 *  隐藏或显示文字
 *
 *  @param isHidden 是否隐藏
 */
- (void)hidePopover:(BOOL)isHidden;


- (void)setValue:(float)value animated:(BOOL)animated;

@end

