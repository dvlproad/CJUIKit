//
//  CJSwitchSlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CJSliderControl.h"

@interface CJSwitchSlider : CJSliderControl {
    
}
@property (nonatomic, strong) NSMutableArray *sliderStatusModels;
@property (nonatomic, assign) NSInteger currentStep;

@end
