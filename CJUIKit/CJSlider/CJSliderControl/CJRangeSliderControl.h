//
//  CJRangeSliderControl.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJRangeSliderControl;


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

@interface CJRangeSliderControl : UIControl

@property (nonatomic, assign) CGFloat minValue; /**< 最小值 */

@property (nonatomic, assign) CGFloat maxValue; /**< 最大值 */

@property (nonatomic, weak) id<CJRangeSliderControlDelegate> delegate;

@end
