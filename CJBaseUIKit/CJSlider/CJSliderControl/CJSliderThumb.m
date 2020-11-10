//
//  CJSliderThumb.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSliderThumb.h"

@implementation CJSliderThumb

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.adjustsImageWhenHighlighted = NO;
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    frame.size = [self backgroundImageForState:UIControlStateNormal].size;
    self.frame = frame;
}


@end
