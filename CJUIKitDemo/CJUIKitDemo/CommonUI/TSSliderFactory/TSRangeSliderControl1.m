//
//  TSRangeSliderControl1.m
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSRangeSliderControl1.h"

@interface TSRangeSliderControl1 ()<CJSliderControlDelegate> {
    
}
@property (nonatomic, copy) void(^chooseCompleteBlock)(CGFloat minValue, CGFloat maxValue);

@end

@implementation TSRangeSliderControl1

/*
 *  初始化
 *
 *  @param chooseCompleteBlock 选择结束，返回选择的最大和最小值
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithChooseCompleteBlock:(void(^)(CGFloat minValue, CGFloat maxValue))chooseCompleteBlock {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _chooseCompleteBlock = chooseCompleteBlock;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self setupViewWithCreateTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor redColor];
        return view;
        
    } createMinimumTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor greenColor];
        return view;
        
    } createMaximumTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor blueColor];
        return view;
    }];
//    [self.trackView setBackgroundColor:[UIColor redColor]];
//    [self.minimumTrackView setBackgroundColor:[UIColor yellowColor]];
//    [self.maximumTrackView setBackgroundColor:[UIColor redColor]];
    self.baseValue = 40; // 设置基准值
    self.minValue = 0.0f;
    self.maxValue = 100.0f;
    self.value = 80;
    self.trackHeight = 5;  // 设置滑道高度

    
    self.sliderType = CJSliderTypeRange;
//    self.thumbSize = CGSizeMake(50, 36);
//    self.thumbMoveMinXMargin = -self.thumbSize.width/2;
//    self.thumbMoveMaxXMargin = -self.thumbSize.width/2;
    UIImage *normalImage = [UIImage imageNamed:@"slider_double_thumbImage_b"];
    UIImage *highlightedImage = [UIImage imageNamed:@"slider_double_thumbImage_a"];
    [self.mainThumb setImage:normalImage forState:UIControlStateNormal];
    [self.mainThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    self.mainThumb.alpha = 0.5;
    [self.leftThumb setImage:normalImage forState:UIControlStateNormal];
    [self.leftThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    self.leftThumb.alpha = 0.5;
    
    self.popoverType = CJSliderPopoverDispalyTypeNum;
    
    self.delegate = self;
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    !_chooseCompleteBlock ?: _chooseCompleteBlock(self.baseValue, self.value);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
