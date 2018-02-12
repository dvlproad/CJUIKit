//
//  EmptyView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "EmptyView.h"
#import <Masonry/Masonry.h>

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"jiazhaishibai_bg.png"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.top.mas_equalTo(self).mas_offset(138);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(73);
    }];
    self.imageView = imageView;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.numberOfLines = 0;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]; //#B5B5B5
    label1.font = [UIFont systemFontOfSize:17];
    label1.text = NSLocalizedString(@"页面加载失败...", nil);
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(17);
        make.left.right.mas_equalTo(self).mas_offset(10);
    }];
    self.label1 = label1;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]; //#B5B5B5
    label2.font = [UIFont systemFontOfSize:17];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label1.mas_bottom).mas_offset(4);
        make.left.right.mas_equalTo(self).mas_offset(10);
    }];
    self.label2 = label2;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"重新加载", nil) forState:UIControlStateNormal];
    [button setTintColor:[UIColor blackColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setBackgroundColor:[UIColor colorWithRed:51/255.0 green:136/255.0 blue:255/255.0 alpha:1]]; //3388FF
    [button addTarget:self action:@selector(realoadAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.top.mas_equalTo(self.label2.mas_bottom).mas_offset(31);
        make.width.mas_equalTo(156);
        make.height.mas_equalTo(47);
    }];
    self.button = button;
}


- (void)showEmptyViewWithFailureMessage:(NSString *)failureMessage {
    self.label2.text = failureMessage;
}

- (void)realoadAction {
    if (self.reloadBlock) {
        self.reloadBlock();
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
