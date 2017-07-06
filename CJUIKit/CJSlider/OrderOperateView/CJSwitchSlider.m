//
//  CJSwitchSlider.m
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSwitchSlider.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"

@interface CJSwitchSlider () <CJSliderControlDelegate>

@end


@implementation CJSwitchSlider

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.valueAccoringType = CJSliderValueAccoringTypeThumbMinX;
    self.trackHeight = 65;
    self.thumbSize = CGSizeMake(58, 31);
//    self.mainThumbImage = [[UIImage imageNamed:@"btn_hd.png"] cj_transformImageToSize:self.thumbSize];
    self.mainThumbImage = [UIImage imageNamed:@"btn_hd.png"];
    self.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.7 toValue:0],
                                              [[CJAdsorbModel alloc] initWithMin:0.7 max:1 toValue:1]];
    
    self.delegate = self;
}

/* 完整的描述请参见文件头部 */
- (void)updateStateForIndex:(NSInteger)index {
    _currentStep = index;
    
    CJSliderStatusModel *currentStepStatusModel = [self.statusModels objectAtIndex:self.currentStep];
    
    CJSliderStatusModel *nextStepStatusModel = [self.statusModels objectAtIndex:self.currentStep+1];
    
    self.maximumTrackImage = currentStepStatusModel.image;
    self.minimumTrackImage = nextStepStatusModel.image;
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
}

- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value {
    NSLog(@"slider adsorbToValue %1.2f",value);
    if (value >= 1.0) {
        BOOL isLastStep = self.currentStep == self.statusModels.count - 2;
        if (isLastStep) {
//            self.mainThumbAlpha = 0.0;
//            self.userInteractionEnabled = NO;
            
            self.value = 0.0; //恢复原状
            
        } else {
            _currentStep ++;
            
            [self updateStateForIndex:_currentStep];
            
            self.value = 0.0;
        }
        
        if (self.switchSuccessBlock) { //switchEvent
            self.switchSuccessBlock(self.currentStep-1);
        }
    }
}

@end
