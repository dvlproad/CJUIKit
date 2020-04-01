//
//  CJLabel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLabel.h"

@interface CJLabel ()


@end


@implementation CJLabel

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
