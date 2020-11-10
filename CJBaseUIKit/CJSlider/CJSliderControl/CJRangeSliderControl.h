//
//  CJRangeSliderControl.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJRangeSliderControl;

/**
 *   弹出框显示的时机
 */
typedef NS_ENUM(NSUInteger, CJSliderPopoverShowTimeType) {
    CJSliderPopoverShowTimeTypeAll,         /**< 始终显示 */
    CJSliderPopoverShowTimeTypeDrag,        /**< 只有Drag的时候才显示Popover */
};


@protocol CJRangeSliderControlDelegate <NSObject>

/**
 *  Slider的值改变后触发
 *
 *  @param slider   当前的slider控件
 *  @param minValue 选取的区间的最小值
 *  @param maxValue 选取的区间最大值
 */
- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue;

@end



@interface CJRangeSliderControl : UIControl {
    
}
@property (nonatomic, assign) CGFloat trackViewMinXMargin;  /**< 滑道的最小值离bound的边缘距离 */
@property (nonatomic, assign) CGFloat trackViewMaxXMargin;  /**< 滑道的最大值离bound的边缘距离 */

@property (nonatomic, assign, readonly) CGFloat trackViewMinX;  /**< 滑道的最小值 */
@property (nonatomic, assign, readonly) CGFloat trackViewMaxX;  /**< 滑道的最大值 */

@property (nonatomic, assign, readonly) CGFloat minValue; /**< 最小值 */
@property (nonatomic, assign, readonly) CGFloat maxValue; /**< 最大值 */

@property (nonatomic, assign, readonly) CGFloat startRangeValue;  /**< 范围的起始值 */
@property (nonatomic, assign, readonly) CGFloat endRangeValue;    /**< 范围的结束值 */

// 滑道视图
//@property (nonatomic, strong) UIView *trackView;    /**< 滑道视图 */
@property (nonatomic, assign) CGFloat trackHeight;  /**< 滑道高度（未设置或者超过视图高度，都重置为等于视图的高） */
@property (nonatomic, assign) CGSize thumbSize;     /**< 滑块大小（默认CGSizeMake(30, 30)） */

// 滑块视图
@property (nonatomic, strong) UIButton *leftThumb; /**< 左滑块视图 */
@property (nonatomic, strong) UIButton *rightThumb;/**<右左滑块视图 */

// 弹出框视图
@property (nonatomic, assign) CGSize popoverSize;           /**< 弹出框大小（默认CGSizeMake(30, 32)） */
@property (nonatomic, assign) BOOL popoverShowTimeType;     /**< 弹出框显示的时机（默认一直显示） */

@property (nonatomic, weak) id<CJRangeSliderControlDelegate> delegate;

/*
 *  初始化
 *
 *  @param minRangeValue                选择范围的最小值
 *  @param maxRangeValue                选择范围的最大值
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 *  @param createTrackViewBlock         trackView的创建方法
 *  @param createFrontViewBlock         frontView的创建方法
 *  @param popoverTextTransBlock        popover上的文本转换方法(默认使用realValue保留一位小数 )
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithMinRangeValue:(CGFloat)minRangeValue
                        maxRangeValue:(CGFloat)maxRangeValue
                      startRangeValue:(CGFloat)startRangeValue
                        endRangeValue:(CGFloat)endRangeValue
                 createTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
                 createFrontViewBlock:(UIView *(^)(void))createFrontViewBlock
                popoverTextTransBlock:(NSString *(^)(CGFloat percentValue, CGFloat realValue))popoverTextTransBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
