//
//  TSAgeRangeSliderControl.m
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSAgeRangeSliderControl.h"

@interface TSAgeRangeSliderControl ()<CJRangeSliderControlDelegate> {
    
}
@property (nonatomic, copy) void(^chooseCompleteBlock)(NSInteger minAge, NSInteger maxAge);

@end

@implementation TSAgeRangeSliderControl

/*
 *  初始化
 *
 *  @param minRangeAge                  选择范围的最小值
 *  @param maxRangeAge                  选择范围的最大值
 *  @param startRangeAge                初始范围的起始值
 *  @param endRangeAge                  初始范围的结束值
 *  @param chooseCompleteBlock          选择结束，返回选择的最大和最小值
 *
 *  @param 年龄范围选择slider滑块视图
 */
- (instancetype)initWithMinRangeAge:(NSInteger)minRangeAge
                        maxRangeAge:(NSInteger)maxRangeAge
                      startRangeAge:(NSInteger)startRangeAge
                        endRangeAge:(NSInteger)endRangeAge
                chooseCompleteBlock:(void(^)(NSInteger minAge, NSInteger maxAge))chooseCompleteBlock
{
    self = [super initWithMinRangeValue:minRangeAge maxRangeValue:maxRangeAge startRangeValue:startRangeAge endRangeValue:endRangeAge createTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor redColor];
        return view;
    } createFrontViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor greenColor];
        return view;
    } popoverTextTransBlock:^NSString *(CGFloat percentValue, CGFloat realValue) {
        NSInteger age = (NSInteger)realValue;
        return [NSString stringWithFormat:@"%zd", age];
    }];
    if (self) {
        _chooseCompleteBlock = chooseCompleteBlock;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor cyanColor];
    
    self.trackHeight = 15;  // 设置滑道高度
    
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
    //NSLog(@"age rangeSlider rangion:%f,%f", minValue, maxValue);
    
    NSInteger minAge = (NSInteger)minValue;
    NSInteger maxAge = (NSInteger)maxValue;

    !_chooseCompleteBlock ?: _chooseCompleteBlock(minAge, maxAge);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
