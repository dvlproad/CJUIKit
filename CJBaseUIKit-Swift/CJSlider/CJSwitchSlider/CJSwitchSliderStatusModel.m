//
//  CJSwitchSliderStatusModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSwitchSliderStatusModel.h"

@implementation CJSwitchSliderStatusModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.goNextStepWhenSwitchEventOccur = YES;
    }
    return self;
}

@end
