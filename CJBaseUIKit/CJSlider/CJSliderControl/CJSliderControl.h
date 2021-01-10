//
//  CJSliderControl.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  注意：CJSliderControl可滑动的区域就是滑到的区域，并且是以滑块的中心来判断是否超出滑道区域的(而不是滑块的originX)

#import <UIKit/UIKit.h>
#import "CJSliderPopover.h"
#import "CJAdsorbModel.h"

@class CJSliderControl;

typedef NS_ENUM(NSUInteger, CJSliderType) {
    CJSliderTypeNormal,
    CJSliderTypeRange,
};

typedef NS_ENUM(NSUInteger, CJSliderRangeType) {
    CJSliderRangeTypeMidToMid,
    CJSliderRangeTypeMinToMin,
};


///移动变化类型
typedef NS_ENUM(NSUInteger, CJSliderMoveType) {
    CJSliderMoveTypeMaximumTrackImageViewWidthAspectFit = 0,/**< 宽度自适应，即会缩放 */
    CJSliderMoveTypeMaximumTrackImageViewWidthNoChange,     /**< 宽度不变，即会自动移动 */
};

/**
 *   弹出框显示内容的枚举类型
 */
typedef NS_ENUM(NSUInteger, CJSliderPopoverDispalyType) {
    CJSliderPopoverDispalyTypeNone,         /**< 没有Popover */
    CJSliderPopoverDispalyTypeNum,          /**< 纯数字显示 */
    CJSliderPopoverDispalyTypePercent,      /**< 百分比显示 */
};


//NS_ASSUME_NONNULL_BEGIN

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
- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value animatedDuration:(CGFloat)animatedDuration;

@end

/**
 *  单向滑竿、popover支持百分比和纯数字显示
 */
@interface CJSliderControl : UIControl {
    //注意①、不要使用setImage来设置图片，要使用setBackgroundImage来设置
}
@property (nonatomic, assign) CGFloat trackViewMinXMargin;  /**< 滑道的最小值离bound的边缘距离 */
@property (nonatomic, assign) CGFloat trackViewMaxXMargin;  /**< 滑道的最大值离bound的边缘距离 */
@property (nonatomic, assign) CGFloat thumbMoveMinXMargin;  /**< 滑块可移动到的最小X值离bound的边缘距离 */
@property (nonatomic, assign) CGFloat thumbMoveMaxXMargin;  /**< 滑块可移动到的最大X值离bound的边缘距离 */

@property (nonatomic, assign, readonly) CGFloat trackViewMinX;  /**< 滑道的最小值 */
@property (nonatomic, assign, readonly) CGFloat trackViewMaxX;  /**< 滑道的最大值 */
@property (nonatomic, assign, readonly) CGFloat thumbMoveMinX;  /**< 滑块可移动到的最小X值 */
@property (nonatomic, assign, readonly) CGFloat thumbMoveMaxX;  /**< 滑块可移动到的最大X值 */

@property (nonatomic, weak) id<CJSliderControlDelegate> delegate;
@property (nonatomic, assign) BOOL allowTouchChangeValue;   /**< 是否允许通过点击来改变值(默认否) */

@property (nonatomic, assign) CGFloat minValue;         /**< 最小值(默认0) */
@property (nonatomic, assign) CGFloat maxValue;         /**< 最大值(默认1) */

// 滑道视图
@property (nonatomic, strong) UIView *trackView;        /**< 滑道视图 */
@property (nonatomic, assign) CGFloat trackHeight;      /**< 滑道高度（未设置或者超过视图高度，都重置为等于视图的高） */
@property (nonatomic, assign) CGSize thumbSize;         /**< 滑块大小（默认CGSizeMake(30, 30) */

@property (nonatomic, strong) UIView *minimumTrackView; /**< 主滑块左侧的视图 */
@property (nonatomic, strong) UIView *maximumTrackView; /**< 主滑块右侧的视图 */

@property (nonatomic, assign) CGFloat value;            /**< 当前值 */

@property (nonatomic, assign) CJSliderRangeType rangeType;  /**< 标注区域的绘制是从哪到哪 */

// 滑块视图
@property (nonatomic, strong) UIButton *mainThumb;      /**< 主滑块视图 */
@property (nonatomic, strong) UIButton *leftThumb;      /**< 主滑块左侧的另一个滑块 */
@property (nonatomic, assign) CJSliderType sliderType;  /**< slider的类型（有Normal和Range两种类型） */

@property (nonatomic, assign) CGFloat baseValue;        /**< 基准值(默认0) */

// 弹出框视图
@property (nonatomic, assign) CJSliderPopoverDispalyType popoverType;   /**< 弹出框的类型 */
@property (nonatomic, assign) CGSize popoverSize;                       /**< 弹出框大小（默认CGSizeMake(30, 32)） */

@property (nonatomic, strong) NSArray<CJAdsorbModel *> *adsorbInfos;    /** 设置吸附信息(含吸附区间及该区间要吸附到什么值)，上面的值是具体的滑块值，不是百分比 */


@property (nonatomic, assign) CJSliderMoveType moveType;    /**< 移动变化类型 */

- (void)commonInit;

/*
 *  设置自定义的view，调用此方法可设置slider各部分为自己的视图（必须设置，各参数可为空）
 *
 *  @param createTrackViewBlock         创建自定义的滑道视图
 *  @param createMinimumTrackViewBlock  创建自定义的主滑块左侧的视图
 *  @param createMaximumTrackViewBlock  创建自定义的主滑块右侧的视图
 */
- (void)setupViewWithCreateTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
              createMinimumTrackViewBlock:(UIView * (^)(void))createMinimumTrackViewBlock
              createMaximumTrackViewBlock:(UIView * (^)(void))createMaximumTrackViewBlock;

///更新slider(可用于视图已经生成之后，有更改trackHeight或thumbSize的时候调用,一般很少用到)
- (void)reloadSlider;

/**
 *  隐藏或显示文字
 *
 *  @param isHidden 是否隐藏
 */
- (void)hidePopover:(BOOL)isHidden;


- (void)setValue:(float)value animated:(BOOL)animated;

@end

//NS_ASSUME_NONNULL_END
