//
//  CJDataEmptyView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/2/6.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataEmptyView.h"
#import <CJFoundation/NSString+CJTextSize.h>

@interface CJDataEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end



@implementation CJDataEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.imageSize = CGSizeMake(85, 73);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"cjNetworkDisable.png"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.centerY.mas_equalTo(self).mas_offset(-150);
        make.width.mas_equalTo(self.imageSize.width);
        make.height.mas_equalTo(self.imageSize.height);
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
    
    self.buttonSize = CGSizeMake(156, 47);
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
        make.width.mas_equalTo(self.buttonSize.width);
        make.height.mas_equalTo(self.buttonSize.height);
    }];
    self.button = button;
}

#pragma mark - Distance
- (void)setDistancBetweenButtonAndImage:(CGFloat)distancBetweenButtonAndImage {
    _distancBetweenButtonAndImage = distancBetweenButtonAndImage;
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(distancBetweenButtonAndImage);
        make.width.mas_equalTo(self.buttonSize.width);
        make.height.mas_equalTo(self.buttonSize.height);
    }];
}

- (void)setDistancBetweenTitleAndImage:(CGFloat)distancBetweenTitleAndImage {
    _distancBetweenTitleAndImage = distancBetweenTitleAndImage;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(distancBetweenTitleAndImage);
        make.left.right.mas_equalTo(self).mas_offset(10);
    }];
}

#pragma mark image
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageSize.width);
        make.height.mas_equalTo(imageSize.height);
    }];
}

#pragma mark title
- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

#pragma mark message
- (void)setMessage:(NSString *)message {
    _message = message;
    
    self.messageLabel.text = message;
    
    if (message.length > 0) {
        CGFloat maxWidth = CGRectGetWidth(self.frame)-20;
        CGFloat textHeight = [message cjTextHeightWithFont:[UIFont systemFontOfSize:17] infiniteHeightAndMaxWidth:maxWidth];
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(textHeight);
        }];
    } else {
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(8);
        }];
    }
}

#pragma mark reloadButton
- (void)setShowReloadButton:(BOOL)showReloadButton {
    _showReloadButton = showReloadButton;
    self.button.hidden = !showReloadButton;
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)setButtonSize:(CGSize)buttonSize {
    _buttonSize = buttonSize;
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonSize.width);
        make.height.mas_equalTo(buttonSize.height);
    }];
}

- (void)realoadAction {
    if (self.reloadBlock) {
        self.reloadBlock(self);
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
