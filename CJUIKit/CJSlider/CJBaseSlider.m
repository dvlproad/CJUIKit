//
//  CJBaseSlider.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseSlider.h"

@interface CJBaseSlider ()

@property (nonatomic, strong) UIView *rangeView;    //非空白区域的视图

@end

@implementation CJBaseSlider

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
    _blankColor = [UIColor lightGrayColor];
    self.minimumTrackTintColor = _blankColor;
    self.maximumTrackTintColor = _blankColor;
    
    _baseValue = 0.5;
    
    _rangeColor = [UIColor blueColor];
    
    _adsorbInfo = [[CJAdsorbModel alloc] initWithMin:0 max:0 toValue:0];
    
    if (!_rangeView) {
        _rangeView = [[UIView alloc] initWithFrame:CGRectZero];
        _rangeView.backgroundColor = _rangeColor;
        [self addSubview:_rangeView];
    }
    
    [self addTarget:self action:@selector(adsorbToValue) forControlEvents:UIControlEventTouchUpInside];
}

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

/**
 *  设置吸附信息
 *
 *  @param adsorbInfo 吸附信息(含吸附区间及该区间要吸附到什么值)
 */
- (void)setAdsorbInfo:(CJAdsorbModel *)adsorbInfo {
    _adsorbInfo = adsorbInfo;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGFloat rangeViewY = rect.origin.y;
    
    CGRect trackRect = [self trackRectForBounds:bounds];
    CGFloat rangeViewHeight = CGRectGetHeight(trackRect);
    
    
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    CGFloat rangeViewX = CGRectGetMidX(thumbRect);
    
    CGFloat baseCenterX = self.baseValue * CGRectGetWidth(bounds);
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
    
    return thumbRect;
}

/**
 *  拖动结束后进行吸附判断及吸附到指定值
 */
- (void)adsorbToValue {
    CGFloat curValue = self.value;
    if (curValue > _adsorbInfo.adsorbMin && curValue < _adsorbInfo.adsorbMax) {
        [self setValue:_adsorbInfo.adsorbToValue animated:YES];
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
