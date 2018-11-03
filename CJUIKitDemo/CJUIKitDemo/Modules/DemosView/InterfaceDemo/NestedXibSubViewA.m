//
//  NestedXibSubViewA.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NestedXibSubViewA.h"

@implementation NestedXibSubViewA

//CustomXibView.m
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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    NSArray *views = [nib instantiateWithOwner:self options:nil];
    UIView *containerView = [views objectAtIndex:0];
    [self addSubview:containerView];
    
    //CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //containerView.frame = newFrame;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
