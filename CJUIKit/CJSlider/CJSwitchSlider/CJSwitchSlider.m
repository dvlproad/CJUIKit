//
//  CJSwitchSlider.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSwitchSlider.h"

@interface CJSwitchSlider () <CJSliderControlDelegate>

@end


@implementation CJSwitchSlider

- (void)commonInit {
    [super commonInit];
    
    self.valueAccoringType = CJSliderValueAccoringTypeThumbMinX;
    self.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.7 toValue:0],
                                              [[CJAdsorbModel alloc] initWithMin:0.7 max:1 toValue:1]];
    
    self.delegate = self;
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
}

- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value {
    NSLog(@"slider adsorbToValue %1.2f",value);
    if (value >= 1.0) {
        if (self.switchEventOccuBlock) {
            self.switchEventOccuBlock(self.currentStep);
        }
        
        self.value = 0.0; //不管是不是最后一个步骤，滑动后都使滑块恢复到0的状态
        
        BOOL isNextStepIsLast = self.currentStep == self.statusModels.count - 2;
        if (!isNextStepIsLast) {
            CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
            if (currentStepStatusModel.goNextStepWhenSwitchEventOccur) {
                [self goNextStep];
            }
        }
        
        
    }
}

/* 完整的描述请参见文件头部 */
- (void)showStep:(NSInteger)step {
    [self updateStateForIndex:step];
}

- (void)goNextStep {
    _currentStep ++;
    
    [self updateStateForIndex:_currentStep];
}

/**
 *  为指定步骤更新视图
 *
 *  @param index 指定的步骤
 */
- (void)updateStateForIndex:(NSInteger)index {
    _currentStep = index;
    
    CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
    
    CJSwitchSliderStatusModel *nextStepStatusModel = [self.statusModels objectAtIndex:self.currentStep+1];
    
    [self.trackImageView setImage:currentStepStatusModel.image];
    [self.minimumTrackImageView setImage:nextStepStatusModel.image];
}

@end
