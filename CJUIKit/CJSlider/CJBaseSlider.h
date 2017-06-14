//
//  CJBaseSlider.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJAdsorbModel.h"

typedef NS_ENUM(NSUInteger, CJSliderType) {
    CJSliderTypeDefault,
    CJSliderTypeRange,
};

/**
 *  可设置基准值的滑竿（即代表其是可自由左右滑动的Slider）
 */
@interface CJBaseSlider : UISlider

@property (nonatomic, assign) CGFloat trackHeight;          /**< 进度条的高度,即线的高度 */
//附：滑块的大小请使用- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;设置

@property (nonatomic, strong) NSArray<CJAdsorbModel *> *adsorbInfos; /** 设置吸附信息(含吸附区间及该区间要吸附到什么值)，上面的值是具体的滑块值，不是白费比 */


@property (nonatomic, assign) CJSliderType sliderType;

//以下值，只当sliderType为CJSliderTypeRange时，才有用
@property (nonatomic, assign) CGFloat basePercentValue; /** 基准值(默认50%，即为滑竿正中间) */
@property (nonatomic, strong) UIColor *blankColor;  /** 空白区域颜色(默认lightGrayColor) */
@property (nonatomic, strong) UIColor *rangeColor;  /** 非空白区域的颜色(默认blueColor) */


@end
