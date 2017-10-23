//
//  CJCollectionViewHeaderFooterView.m
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJCollectionViewHeaderFooterView.h"

@implementation CJCollectionViewHeaderFooterView

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
    [self addGestureRecognizer:tapGestureRecognizer];
}


- (void)heaerOrFooterTapAction {
    if (self.tapHandle) {
        self.tapHandle(self.belongToSection);
    }
}

@end
