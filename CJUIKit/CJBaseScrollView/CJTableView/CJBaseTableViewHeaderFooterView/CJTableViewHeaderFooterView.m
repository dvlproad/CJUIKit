//
//  CJTableViewHeaderFooterView.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJTableViewHeaderFooterView.h"

@implementation CJTableViewHeaderFooterView

- (void)awakeFromNib {
    // Initialization code
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
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heaerOrFooterTapAction)];
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
}


- (void)heaerOrFooterTapAction {
    if (self.tapHandle) {
        self.tapHandle(self.belongToSection);
    }
}

@end
