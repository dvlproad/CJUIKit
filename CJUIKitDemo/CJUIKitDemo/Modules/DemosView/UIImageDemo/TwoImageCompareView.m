//
//  TwoImageCompareView.m
//  CJUIKitDemo
//
//  Created by qian on 2021/1/13.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TwoImageCompareView.h"
#import <Masonry/Masonry.h>

@implementation TwoImageCompareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView1];
    self.imageView1 = imageView1;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView2];
    self.imageView2 = imageView2;
    
    NSArray<UIView *> *imageViews = @[imageView1, imageView2];
    [imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
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
