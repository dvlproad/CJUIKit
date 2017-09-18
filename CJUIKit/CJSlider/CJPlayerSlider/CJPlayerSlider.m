//
//  CJPlayerSlider.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/3/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJPlayerSlider.h"

#define Color_SliderTip_Font [UIColor colorWithRed:35/255.0 green:169/255.0 blue:238/255.0 alpha:1] //默认的提示的字体颜色 23A9EE
#define Color_SliderMinimumTrackTintColor  [UIColor colorWithRed:35/255.0 green:169/255.0 blue:238/255.0 alpha:1] //默认的拉杆左侧的颜色 23A9EE


@implementation CJPlayerSlider
{
    UIImageView *tipView; //提示值视图
    UILabel *tipLabel; //提视图Label
    float valueScale;   //初始滑杆的位置，根据该位置创建滑杆样式
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    
    valueScale = (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
    
    //  默认需要显示提示
    _enableTip = YES;
    
    //默认不需要自动吸附
    _isNeedAutoAdsorb = NO;
    
    [self setMinimumTrackTintColor:Color_SliderMinimumTrackTintColor];
    [self setMaximumTrackTintColor:[UIColor whiteColor]];
    
    [self setThumbImage:[UIImage imageNamed:@"slider_block_normal"] forState:UIControlStateNormal];
    
    //添加数值提示框
    tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_tip_background_normal"]];
    tipView.center = CGPointMake(20, -5.0f);
    tipView.hidden = YES;
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, tipView.frame.size.width - 4, tipView.frame.size.height - 5)];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.minimumScaleFactor = 0.5;
    tipLabel.adjustsFontSizeToFitWidth = YES;
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = Color_SliderTip_Font;
    [tipView addSubview:tipLabel];
    [self addSubview:tipView];
    
}

/**
 *@brief:根据颜色生成图片
 */
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGSize oSize = CGSizeMake(self.bounds.size.width, 10);
    
    UIGraphicsBeginImageContextWithOptions(oSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, oSize.width, oSize.height);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *@brief:隐藏提示视图
 */
- (void)hideTipView
{
    tipView.hidden = YES;
}

/**
 *@brief:自动吸附，拉杆吸附值在0-5，吸附在“5”上；在-5-0，吸附在“-5”上
 **/
- (CGFloat)valueAutoAdsorb:(CGFloat)value
{
    if (!_isNeedAutoAdsorb)
    {
        return value;
    }
    
    if (value > 0.3 && value < 5)
    {
        value = 5;
    }
    else if (value < -0.3 && value > -5)
    {
        value = -5;
    }
    else if (value < 0.3 && value > -0.3)
    {
        value = 0;
    }
    
    return value;
}

/**
 *@brief:设置数值需要重新修正视图
 */
- (void)setValue:(float)value
{
    [super setValue:value];
}

/**
 *@brief:手指点击
 */
- (void)touchDown
{
    _dragging = YES;
    self.value = [self valueAutoAdsorb:self.value];
    
    
    if (_enableTip)
    {
        [self adjustTipView];
        tipView.hidden = NO;
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cjPlayerSliderTouchDown:)])
    {
        [self.delegate cjPlayerSliderTouchDown:self];
    }
}

/**
 *@brief:手指放开
 */
- (void)touchUp
{
    _dragging = YES;
    self.value = [self valueAutoAdsorb:self.value];
    
    if (_enableTip)
    {
        tipView.hidden = YES;
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cjPlayerSliderTouchUp:)])
    {
        [self.delegate cjPlayerSliderTouchUp:self];
    }
}

/**
 *@brief:数值变化
 */
- (void)valueChanged
{
    self.value = [self valueAutoAdsorb:self.value];
    
    if (_enableTip)
    {
        [self adjustTipView];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cjPlayerSliderValueChanged:)])
    {
        [self.delegate cjPlayerSliderValueChanged:self];
    }
}

/**
 *@brief:修正数值提示框位置
 */
- (void)adjustTipView
{
    // 四舍五入取整，然后处理－0.0f 为 0.0
    float sliderValue =  roundf(self.value);
    if (fabsf(sliderValue) < 1.0f)
    {
        sliderValue = 0.0f;
    }
    
    NSString *sliderValueStr = [NSString stringWithFormat:@"%0.0f", sliderValue];
    
    //  如果数值显示有负值，则正值前加“+”
    if (self.minimumValue < -1.0)
    {
        if (sliderValue > 0.5f)
        {
            sliderValueStr = [@"+" stringByAppendingString:sliderValueStr];
        }
    }
    
    [tipLabel setText:sliderValueStr];
    UIImageView *imageView = [self.subviews objectAtIndex:self.subviews.count - 1];
    CGPoint tipCenter = tipView.center;
    tipCenter.x = imageView.center.x;
    tipView.center = tipCenter;
}

@end
