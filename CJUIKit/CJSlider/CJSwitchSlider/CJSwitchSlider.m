//
//  CJSwitchSlider.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSwitchSlider.h"

@interface CJSwitchSlider () <CJSliderControlDelegate> {
    
}
@property (nonatomic, strong) UIView *beforeBackgroundView;

@property (nonatomic, strong, readonly) UIImageView *currentStepImageView;

@end


@implementation CJSwitchSlider

- (void)commonInit {
    [super commonInit];
    
    self.trackViewMinXMargin = 0;
    self.trackViewMaxXMargin = 0;
    self.thumbMoveMinXMargin = 0;
    self.thumbMoveMaxXMargin = 0;
    self.rangeType = CJSliderRangeTypeMinToMin;
    
    self.criticalValue = 0.7;
    
    self.delegate = self;
}

- (void)setCriticalValue:(CGFloat)criticalValue {
    _criticalValue = criticalValue;
    
    self.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:criticalValue toValue:0],
                         [[CJAdsorbModel alloc] initWithMin:criticalValue max:1 toValue:1]];
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f", value);
    
    
    CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
    if (value == self.minValue) {
        if (currentStepStatusModel.dragingColor) {
            [self.currentStepImageView setImage:currentStepStatusModel.image];
            [self.currentStepImageView setBackgroundColor:[UIColor clearColor]];
        }
    } else {
        if (currentStepStatusModel.dragingColor) {
            [self.currentStepImageView setImage:nil];
            [self.currentStepImageView setBackgroundColor:currentStepStatusModel.dragingColor];
        }
    }
}

- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value animatedDuration:(CGFloat)animatedDuration {
    NSLog(@"slider adsorbToValue %1.2f", value);
    CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
    if (currentStepStatusModel.dragingColor) {
        [self.currentStepImageView setImage:currentStepStatusModel.image];
        [self.currentStepImageView setBackgroundColor:[UIColor clearColor]];
    }
    
    if (value >= 1.0) {
        if (self.switchEventOccuBlock) {
            self.switchEventOccuBlock(self.currentStep);
        }
        
        [self performSelector:@selector(restoreValue) withObject:nil afterDelay:animatedDuration];
    }
}

- (void)restoreValue {
    self.value = 0.0; //不管是不是最后一个步骤，滑动后都使滑块恢复到0的状态
    
    BOOL isNextStepIsLast = self.currentStep == self.statusModels.count - 2;
    if (!isNextStepIsLast) {
        CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
        if (currentStepStatusModel.goNextStepWhenSwitchEventOccur) {
            [self goNextStep];
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
    
    switch (self.switchAnimatedType) {
        case CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView:
        {
            _currentStepImageView = self.maximumTrackImageView;
            
            [self.maximumTrackImageView setImage:currentStepStatusModel.image];
            [self.trackImageView setImage:nextStepStatusModel.image];
            
            /* //此种方法占用太大内存
            UIColor *nextStepColor = [UIColor colorWithPatternImage:nextStepStatusModel.image];
            UIColor *currentStepColor = [UIColor colorWithPatternImage:currentStepStatusModel.image];
            self.trackImageView.backgroundColor = nextStepColor;
            self.maximumTrackImageView.backgroundColor = currentStepColor;
            */
//            self.trackImageView.layer.contents = (__bridge id _Nullable)(nextStepStatusModel.image.CGImage);
//            self.maximumTrackImageView.layer.contents = (__bridge id _Nullable)(currentStepStatusModel.image.CGImage);
            
            break;
        }
        case CJSwitchAnimatedTypeCurrentStepInTrackImageView:
        {
            _currentStepImageView = self.trackImageView;
            
            [self.trackImageView setImage:currentStepStatusModel.image];
            
//            [self.minimumTrackImageView setImage:nextStepStatusModel.image];
//            self.minimumTrackImageView.layer.contents = (__bridge id _Nullable)(nextStepStatusModel.image.CGImage);
            UIColor *nextStepColor = [UIColor colorWithPatternImage:nextStepStatusModel.image];
            self.minimumTrackImageView.backgroundColor = nextStepColor;
            
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
