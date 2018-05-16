//
//  DemoEmptyView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/2/6.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoEmptyView.h"

@interface DemoEmptyView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIButton *button;

@end



@implementation DemoEmptyView

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
        make.centerY.mas_equalTo(self).mas_offset(-100);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(73);
    }];
    self.imageView = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]; //#B5B5B5
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = NSLocalizedString(@"页面加载失败...", nil);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(17);
        make.left.right.mas_equalTo(self).mas_offset(10);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //messageLabel.text = NSLocalizedString(@"请检查您的手机是否联网", nil);
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]; //#B5B5B5
    messageLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(4);
        make.left.right.mas_equalTo(self).mas_offset(10);
    }];
    self.messageLabel = messageLabel;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"重新加载", nil) forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    [button setTintColor:[UIColor blackColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setBackgroundColor:[UIColor colorWithRed:51/255.0 green:136/255.0 blue:255/255.0 alpha:1]]; //3388FF
    [button addTarget:self action:@selector(realoadAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(31);
        make.width.mas_equalTo(156);
        make.height.mas_equalTo(47);
    }];
    self.button = button;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    
    self.messageLabel.text = message;
    
    if (message.length > 0) {
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom).mas_offset(31);
        }];
    } else {
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(31);
        }];
    }
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
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
