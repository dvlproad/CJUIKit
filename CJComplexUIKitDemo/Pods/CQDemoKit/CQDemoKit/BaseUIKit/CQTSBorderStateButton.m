//
//  CQTSBorderStateButton.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSBorderStateButton.h"

@implementation CQTSBorderStateButton

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self __updateBorderColor];
    
    // selected 改变时候的回调
    if (self.selectedChangeCompleteBlock) {
        self.selectedChangeCompleteBlock(self);
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    [self __updateBorderColor];
}

#pragma mark - Private Method
/**
 *  根据 selected 和 enabled 更新 borderColor
 */
- (void)__updateBorderColor {
    BOOL selected = self.selected;  //是否选中
    BOOL enabled = self.enabled;    //是否可操作
    
    if (selected) {
        self.layer.borderWidth = self.cjSelectedBorderWidth;
        if (enabled) {
            if (self.cjSelectedBorderColor) {
                self.layer.borderColor = self.cjSelectedBorderColor.CGColor;
            }
        } else {
            if (self.cjSelectedDisabledBorderColor) {
                self.layer.borderColor = self.cjSelectedDisabledBorderColor.CGColor;
            }
        }
    } else {
        self.layer.borderWidth = self.cjNormalBorderWidth;
        if (enabled) {
            if (self.cjNormalBorderColor) {
                self.layer.borderColor = self.cjNormalBorderColor.CGColor;
            }
        } else {
            if (self.cjDisabledBorderColor) {
                self.layer.borderColor = self.cjDisabledBorderColor.CGColor;
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
