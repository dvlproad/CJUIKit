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
    self.minValue = 0.0f;    //设置滑竿的最小值
    self.maxValue = 100.0f;  //设置滑竿的最大值
    
    self.delegate = self;
}

#pragma mark - CJRangeSliderControlDelegate
- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue {
    NSLog(@"rangeSlider rangion:%f,%f",minValue,maxValue);

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
