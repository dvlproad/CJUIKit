//
//  CJFloatingWindow.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJFloatingWindow.h"

@implementation CJFloatingWindow

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.windowLevel = UIWindowLevelAlert + 1;  //如果想在 alert 之上，则改成 + 2
    [self makeKeyAndVisible];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
