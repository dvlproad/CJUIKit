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
@property (nonatomic, copy) void(^updateTrackViewBlock)(UIView *trackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts);
@property (nonatomic, copy) void(^updateMinimumTrackViewBlock)(UIView *minimumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts);
@property (nonatomic, copy) void(^updateMaximumTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts);

@property (nonatomic, strong) UIView *beforeBackgroundView;

@property (nonatomic, strong, readonly) UIView *currentStepImageView;

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

/* 完整的描述请参见文件头部 */
- (void)setupUpdateTrackViewBlock:(void (^)(UIView *, CJSwitchSliderStatusModel *, BOOL))updateTrackViewBlock
      updateMinimumTrackViewBlock:(void (^)(UIView *, CJSwitchSliderStatusModel *, BOOL))updateMinimumTrackViewBlock
      updateMaximumTrackViewBlock:(void (^)(UIView *, CJSwitchSliderStatusModel *, BOOL))updateMaximumTrackViewBlock
{
    self.updateTrackViewBlock = updateTrackViewBlock;
    self.updateMinimumTrackViewBlock = updateMinimumTrackViewBlock;
    self.updateMaximumTrackViewBlock = updateMaximumTrackViewBlock;
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
    
    BOOL useDragingStauts = YES;    //注：移动时候，又移动回初始0的时候这个位置算为不是移动状态
    if (value == self.minValue) {
        useDragingStauts = NO;
    } else {
        useDragingStauts = YES;
    }
    
    if (self.currentStepImageView == self.maximumTrackView) {
        self.updateMaximumTrackViewBlock(self.maximumTrackView, currentStepStatusModel, useDragingStauts);
    } else if (self.currentStepImageView == self.minimumTrackView) {
        self.updateMinimumTrackViewBlock(self.minimumTrackView, currentStepStatusModel, useDragingStauts);
    }
}

- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value animatedDuration:(CGFloat)animatedDuration {
    NSLog(@"slider adsorbToValue %1.2f", value);
    CJSwitchSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
    
    BOOL useDragingStauts = NO;
    if (self.currentStepImageView == self.maximumTrackView) {
        self.updateMaximumTrackViewBlock(self.maximumTrackView, currentStepStatusModel, useDragingStauts);
    } else if (self.currentStepImageView == self.minimumTrackView) {
        self.updateMinimumTrackViewBlock(self.minimumTrackView, currentStepStatusModel, useDragingStauts);
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
    
    BOOL useDragingStauts = NO;
    switch (self.switchAnimatedType) {
        case CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView:
        {
            _currentStepImageView = self.maximumTrackView;
            
            NSAssert(self.updateMaximumTrackViewBlock != nil, @"主滑块右侧的视图maximumTrackView对statusModel的设置不能为空");
            self.updateMaximumTrackViewBlock(self.maximumTrackView, currentStepStatusModel, useDragingStauts);
            
            NSAssert(self.updateTrackViewBlock != nil, @"滑道trackView对statusModel的设置不能为空");
            self.updateTrackViewBlock(self.trackView, nextStepStatusModel, useDragingStauts);
            
            /* //此种方法占用太大内存
            UIColor *nextStepColor = [UIColor colorWithPatternImage:nextStepStatusModel.image];
            UIColor *currentStepColor = [UIColor colorWithPatternImage:currentStepStatusModel.image];
            self.trackView.backgroundColor = nextStepColor;
            self.maximumTrackView.backgroundColor = currentStepColor;
            */
//            self.trackView.layer.contents = (__bridge id _Nullable)(nextStepStatusModel.image.CGImage);
//            self.maximumTrackView.layer.contents = (__bridge id _Nullable)(currentStepStatusModel.image.CGImage);
            
            break;
        }
        /*
        case CJSwitchAnimatedTypeCurrentStepInTrackImageView:
        {
            _currentStepImageView = self.trackView;
            
            [self.trackView setImage:currentStepStatusModel.image];
            
//            [self.minimumTrackView setImage:nextStepStatusModel.image];
//            self.minimumTrackView.layer.contents = (__bridge id _Nullable)(nextStepStatusModel.image.CGImage);
            UIColor *nextStepColor = [UIColor colorWithPatternImage:nextStepStatusModel.image];
            self.minimumTrackView.backgroundColor = nextStepColor;
            
            break;
        }
        */
        default:
        {
            break;
        }
    }
}

@end
