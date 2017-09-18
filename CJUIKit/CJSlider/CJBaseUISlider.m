//
//  CJBaseUISlider.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseUISlider.h"

@interface CJBaseUISlider ()

@property (nonatomic, assign) CGFloat thumbEnableTouchHeight;   /**< 设置滑块可触摸范围的大小,而不是滑块的大小（附：滑块的大小通过图片去设置）本控件滑块可触摸范围的大小，被我默认设置为frame的大小，而不是滑块的大小 */
@property (nonatomic, strong) UIView *rangeView;    //非空白区域的视图


@end

@implementation CJBaseUISlider

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

/**
 *  控件共通的初始化
 */
- (void)commonInit {
    
}

/**
 *  设置吸附信息
 *
 *  @param adsorbInfos 吸附信息(含吸附区间及该区间要吸附到什么值)
 */
- (void)setAdsorbInfos:(NSMutableArray<CJAdsorbModel *> *)adsorbInfos {
    _adsorbInfos = adsorbInfos;
    
    [self addTarget:self action:@selector(adsorbToValue) forControlEvents:UIControlEventTouchUpInside];
}


/**
 *  拖动结束后进行吸附判断及吸附到指定值
 */
- (void)adsorbToValue {
    CGFloat curValue = self.value;
    
    for (CJAdsorbModel *adsorbInfo in self.adsorbInfos) {
        if (curValue > adsorbInfo.adsorbMin && curValue < adsorbInfo.adsorbMax) {
            [self setValue:adsorbInfo.adsorbToValue animated:YES];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            break;
        }
    }
}


//返回 UISlider 上的进度条的尺寸的。但通常情况下，它的长度已经就是我们视图的长度，所以这里我们只修改它的高度
- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect trackRect = [super trackRectForBounds:bounds]; // 必须通过调用父类的trackRectForBounds 获取一个 bounds 值，否则 Autolayout 会失效，UISlider 的位置会跑偏。
    
    /* 如果有设置进度条的大小，则采用设置的大小 */
    if (self.trackHeight) {
        trackRect.origin.y = CGRectGetHeight(bounds)/2 - self.trackHeight/2;
        trackRect.size.height = self.trackHeight;
    }
    
    return trackRect;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.thumbEnableTouchHeight = frame.size.height;
}

//设置滑块的位置及滑块可触摸范围的大小(注不是设置滑块的大小，滑块的大小应通过图片去设置)，其中bounds 是滑块的大小，rect 是进度条的尺寸，而 value 则是 UISlider 当前的值
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    // 这次如果不调用的父类的方法 Autolayout 倒是不会有问题，但是滑块根本就不动~
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value]; //滑块的大小
    CGRect trackRect = [self trackRectForBounds:bounds];    //进度条的大小
    
    /* 如果是CJSliderTypeRange，则进行相应设置 */
    if (self.rangeView) {
        CGFloat rangeViewY = rect.origin.y;
        CGFloat rangeViewHeight = CGRectGetHeight(trackRect);
        CGFloat rangeViewX = CGRectGetMidX(thumbRect);
        
        CGFloat baseCenterX = self.basePercentValue * CGRectGetWidth(bounds);
        CGFloat rangeViewWidth = baseCenterX - rangeViewX;
        
        CGRect rangeViewFrame = CGRectMake(rangeViewX,
                                           rangeViewY,
                                           rangeViewWidth,
                                           rangeViewHeight);
        _rangeView.frame = rangeViewFrame;
        
        NSInteger indexRangeView = [self.subviews indexOfObject:_rangeView];
        if (indexRangeView == 0) {
            [self exchangeSubviewAtIndex:indexRangeView withSubviewAtIndex:2];
        }
    }
    
    /* 如果有设置滑块大小，则采用设置的大小 */
    if (self.thumbEnableTouchHeight) {
        thumbRect.origin.y = CGRectGetMidY(thumbRect) - self.thumbEnableTouchHeight/2;
        thumbRect.size.height = self.thumbEnableTouchHeight;
    }
    
    return thumbRect;
}

/**
 *  设置滑块样式
 *
 *  @param sliderType 滑块样式(CJSliderType)
 */
- (void)setSliderType:(CJUISliderType)sliderType {
    if (sliderType == CJUISliderTypeDefault) {
        if (_rangeView) {
            [_rangeView removeFromSuperview];
        }
        
    } else if (sliderType == CJUISliderTypeRange) {
        if (!_rangeView) { //有基准值的时候才有range
            _rangeView = [[UIView alloc] initWithFrame:CGRectZero];
            _rangeColor = [UIColor blueColor];
            _blankColor = [UIColor yellowColor];
            _basePercentValue = 0.5;
            [self addSubview:_rangeView];
            
            self.minimumTrackTintColor = _blankColor;
            self.maximumTrackTintColor = _blankColor;
            self.rangeView.backgroundColor = _rangeColor;
        }
    }
}

#pragma mark - 以下两个设置只对CJSliderRange有效
/**
 *  设置空白区域颜色
 *
 *  @param blankColor 空白区域颜色
 */
- (void)setBlankColor:(UIColor *)blankColor {
    _blankColor = blankColor;
    self.minimumTrackTintColor = _blankColor;
    self.maximumTrackTintColor = _blankColor;
}

/**
 *  设置非空白区域颜色
 *
 *  @param rangeColor 非空白区域颜色
 */
- (void)setRangeColor:(UIColor *)rangeColor {
    _rangeColor = rangeColor;
    _rangeView.backgroundColor = _rangeColor;
}


@end
