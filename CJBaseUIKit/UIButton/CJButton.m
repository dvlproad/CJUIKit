//
//  CJButton.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJButton.h"

@implementation CJButton

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        if (self.cjSelectedBorderColor) {
            self.layer.borderColor = self.cjSelectedBorderColor.CGColor;
        }
        
    } else {
        if (self.cjNormalBorderColor) {
            self.layer.borderColor = self.cjNormalBorderColor.CGColor;
        }
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        if (self.selected) {
            if (self.cjSelectedBorderColor) {
                self.layer.borderColor = self.cjSelectedBorderColor.CGColor;
            }
            
        } else {
            if (self.cjNormalBorderColor) {
                self.layer.borderColor = self.cjNormalBorderColor.CGColor;
            }
            
        }
    } else {
        if (self.cjDisabledBorderColor) {
            self.layer.borderColor = self.cjDisabledBorderColor.CGColor;
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
