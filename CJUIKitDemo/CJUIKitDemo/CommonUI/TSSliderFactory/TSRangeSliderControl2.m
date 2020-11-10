//
//  TSRangeSliderControl2.m
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSRangeSliderControl2.h"

@interface TSRangeSliderControl2 ()<CJRangeSliderControlDelegate> {
    
}
@property (nonatomic, copy) void(^chooseCompleteBlock)(CGFloat minValue, CGFloat maxValue);

@end

@implementation TSRangeSliderControl2

/*
 *  初始化
 *
 *  @param minRangeValue                选择范围的最小值
 *  @param maxRangeValue                选择范围的最大值
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 *  @param chooseCompleteBlock          选择结束，返回选择的最大和最小值
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithMinRangeValue:(CGFloat)minRangeValue
                        maxRangeValue:(CGFloat)maxRangeValue
                      startRangeValue:(CGFloat)startRangeValue
                        endRangeValue:(CGFloat)endRangeValue
                  chooseCompleteBlock:(void(^)(CGFloat minValue, CGFloat maxValue))chooseCompleteBlock
{
    self = [super initWithMinRangeValue:minRangeValue maxRangeValue:maxRangeValue startRangeValue:startRangeValue endRangeValue:endRangeValue createTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor redColor];
        return view;
    } createFrontViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor greenColor];
        return view;
    } popoverTextTransBlock:^NSString *(CGFloat percentValue, CGFloat realValue) {
        return [NSString stringWithFormat:@"%.1f", realValue];
    }];
    if (self) {
        _chooseCompleteBlock = chooseCompleteBlock;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor cyanColor];
    
    self.trackHeight = 15;                  // 设置滑道高度
    self.thumbSize = CGSizeMake(100, 30);   // 设置滑块大小
    
    UIImage *normalImage = [UIImage imageNamed:@"slider_double_thumbImage_a"];
    UIImage *highlightedImage = [UIImage imageNamed:@"slider_double_thumbImage_b"];
    [self.leftThumb setImage:normalImage forState:UIControlStateNormal];
    [self.leftThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.rightThumb setImage:normalImage forState:UIControlStateNormal];
    [self.rightThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    
    self.leftThumb.alpha = 0.5;
    self.rightThumb.alpha = 0.5;
    [self.leftThumb setBackgroundColor:[UIColor purpleColor]];
    [self.rightThumb setBackgroundColor:[UIColor brownColor]];
    
    self.delegate = self;
}

#pragma mark - CJRangeSliderControlDelegate
- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue {
    NSLog(@"rangeSlider rangion:%f,%f", minValue, maxValue);

    !_chooseCompleteBlock ?: _chooseCompleteBlock(minValue, maxValue);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
