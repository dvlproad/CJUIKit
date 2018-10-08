//
//  CJBaseUISlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJAdsorbModel.h"

typedef NS_ENUM(NSUInteger, CJUISliderType) {
    CJUISliderTypeDefault,
    CJUISliderTypeRange,
};

/**
 *  可设置基准值的滑竿（即代表其是可自由左右滑动的Slider）
 */
@interface CJBaseUISlider : UISlider

@property (nonatomic, assign) CGFloat trackHeight;          /**< 滑道/进度条的高度,即线的高度（TODO:设置的值太大，太接近thumb高度的时候滑动到比较靠左和靠右的时候会有问题） */
//附：滑块的大小请使用- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;设置

@property (nonatomic, strong) NSArray<CJAdsorbModel *> *adsorbInfos; /** 设置吸附信息(含吸附区间及该区间要吸附到什么值)，上面的值是具体的滑块值，不是百分比 */


@property (nonatomic, assign) CJUISliderType sliderType;

//以下值，只当sliderType为CJSliderTypeRange时，才有用
@property (nonatomic, assign) CGFloat basePercentValue; /** 基准值(默认50%，即为滑竿正中间) */
@property (nonatomic, strong) UIColor *blankColor;      /** 空白区域颜色(默认lightGrayColor) */
@property (nonatomic, strong) UIColor *rangeColor;      /** 非空白区域的颜色(默认blueColor) */


@end
