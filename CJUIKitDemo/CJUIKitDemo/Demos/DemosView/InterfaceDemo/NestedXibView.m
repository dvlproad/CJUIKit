//
//  NestedXibView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NestedXibView.h"

@implementation NestedXibView

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
//    [self addSubViewByMethod1];
    [self addSubViewByMethod2];
}

///添加subview的方式1:将整个xib(该xib中已经包含各个子视图)添加进去(如果该xib中有某个自定义视图，则应该保证该自定义视图上的控件要么在该xib中实现了，要么在该自定义视图的代码中实现了)
- (void)addSubViewByMethod1 {
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

///添加subview的方式1:从将子视图一个个添加进去
- (void)addSubViewByMethod2 {
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setFrame:CGRectMake(10, 0, 200, 40)];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"CJTestButton" forState:UIControlStateNormal];
    [cjTestButton addTarget:self action:@selector(cjTestButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cjTestButton];
    
    UINib *nib1 = [UINib nibWithNibName:NSStringFromClass([NestedXibSubViewA class]) bundle:nil];
    NSArray *views1 = [nib1 instantiateWithOwner:self options:nil];
    NestedXibSubViewA *xibSubViewA = [views1 objectAtIndex:0];
    xibSubViewA.frame = CGRectMake(0, 50, 300, 100);
    [self addSubview:xibSubViewA];
    self.xibSubViewA = xibSubViewA;
}

- (void)cjTestButtonAction:(id)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
