//
//  CJAdsorbModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAdsorbModel.h"

@implementation CJAdsorbModel

/* 完整的描述请参见文件头部 */
- (instancetype)initWithMin:(CGFloat)adsorbMin max:(CGFloat)adsorbMax toValue:(CGFloat)adsorbToValue {
    self = [super init];
    if (self) {
        self.adsorbMin = adsorbMin;
        self.adsorbMax = adsorbMax;
        self.adsorbToValue = adsorbToValue;
    }
    return self;
}

@end
