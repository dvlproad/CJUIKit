//
//  CJAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlertView.h"
#import <CJPopupAction/UIView+CJPopupInView.h>

@interface CJAlertView () {
    
}
@property (nonatomic, readonly) CGSize size;

@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, copy) void(^cancelHandle)(void);
@property (nonatomic, copy) void(^okHandle)(void);

@end




@implementation CJAlertView


+ (instancetype)alertViewWithSize:(CGSize)size
                        flagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle
{
    //①创建
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:size];
    
    //②添加 flagImage、titleLabel、messageLabel
    //[alertView setupFlagImage:flagImage title:title message:message configure:configure]; //已拆解成以下几个方法
    if (flagImage) {
        [alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
    }
    if (title.length > 0) {
        UIFont *titleLabelFont = [UIFont systemFontOfSize:18.0];
        [alertView addTitle:title font:titleLabelFont textAlignment:NSTextAlignmentCenter margin:20];
    }
    if (message.length > 0) {
        UIFont *messageLabelFont = [UIFont systemFontOfSize:15.0];
        [alertView addMessage:message font:messageLabelFont textAlignment:NSTextAlignmentCenter margin:20];
    }
    
    //③添加 cancelButton、okButton
    [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    
    return alertView;
}

- (instancetype)initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        
        _size = size;
    }
    return self;
}

/* //已拆解成以下几个方法
- (void)setupFlagImage:(UIImage *)flagImage
                 title:(NSString *)title
               message:(NSString *)message
{
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
    
    
    if (flagImage) {
        UIImageView *flagImageView = [[UIImageView alloc] init];
        flagImageView.image = flagImage;
        [self addSubview:flagImageView];
        [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(38);
            make.top.mas_equalTo(self).mas_offset(25);
            make.height.mas_equalTo(38);
        }];
        _flagImageView = flagImageView;
    }
    
    
    // titleLabel
    CGFloat titleLabelLeftOffset = 20;
    UIFont *titleLabelFont = [UIFont systemFontOfSize:18.0];
    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
    CGSize titleLabelMaxSize = CGSizeMake(titleLabelMaxWidth, CGFLOAT_MAX);
    CGSize titleTextSize = [CJAlertView getTextSizeFromString:title withFont:titleLabelFont maxSize:titleLabelMaxSize mode:NSLineBreakByCharWrapping];
    CGFloat titleTextHeight = titleTextSize.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = titleLabelFont;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(titleLabelLeftOffset);
        if (self.flagImageView) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(10);
        } else {
            make.top.mas_equalTo(self).mas_offset(25);
        }
        make.height.mas_equalTo(titleTextHeight);
    }];
    _titleLabel = titleLabel;
    
    
    // messageLabel
    CGFloat messageLabelLeftOffset = 20;
    UIFont *messageLabelFont = [UIFont systemFontOfSize:15.0];
    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
    CGSize messageLabelMaxSize = CGSizeMake(messageLabelMaxWidth, CGFLOAT_MAX);
    CGSize messageTextSize = [CJAlertView getTextSizeFromString:message withFont:messageLabelFont maxSize:messageLabelMaxSize mode:NSLineBreakByCharWrapping];
    CGFloat messageTextHeight = messageTextSize.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = messageLabelFont;
    messageLabel.textColor = messageTextColor;
    messageLabel.text = message;
    [self addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(messageLabelLeftOffset);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(messageTextHeight);
    }];
    _messageLabel = messageLabel;
}
*/

- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize {
    if (_flagImageView == nil) {
        UIImageView *flagImageView = [[UIImageView alloc] init];
        [self addSubview:flagImageView];
        [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(imageViewSize.width);
            make.top.mas_equalTo(self).mas_offset(25);
            make.height.mas_equalTo(imageViewSize.height);
        }];
        _flagImageView = flagImageView;
    }
    _flagImageView.image = flagImage;
    
    if (self.titleLabel) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(10);
        }];
    }
    
    if (self.messageLabel) {
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.titleLabel) {
                make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(10);
            } else {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
            }
        }];
    }
}

- (void)addTitle:(NSString *)title font:(UIFont *)titleLabelFont textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset {
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        //titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        _titleLabel = titleLabel;
    }
    
    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
    CGSize titleLabelMaxSize = CGSizeMake(titleLabelMaxWidth, CGFLOAT_MAX);
    CGSize titleTextSize = [CJAlertView getTextSizeFromString:title withFont:titleLabelFont maxSize:titleLabelMaxSize mode:NSLineBreakByCharWrapping];
    CGFloat titleTextHeight = titleTextSize.height;
    
    self.titleLabel.textAlignment = textAlignment;
    self.titleLabel.font = titleLabelFont;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(titleLabelLeftOffset);
        if (self.flagImageView) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(10);
        } else {
            make.top.mas_equalTo(self).mas_offset(25);
        }
        make.height.mas_equalTo(titleTextHeight);
    }];
    
    if (self.messageLabel) {
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        }];
    }
}

- (void)addMessage:(NSString *)message font:(UIFont *)messageLabelFont textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset {
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    if (_messageLabel == nil) {
        UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        //messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = messageTextColor;
        messageLabel.text = message;
        [self addSubview:messageLabel];
        
        _messageLabel = messageLabel;
    }
    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
    CGSize messageLabelMaxSize = CGSizeMake(messageLabelMaxWidth, CGFLOAT_MAX);
    CGSize messageTextSize = [CJAlertView getTextSizeFromString:message withFont:messageLabelFont maxSize:messageLabelMaxSize mode:NSLineBreakByCharWrapping];
    CGFloat messageTextHeight = messageTextSize.height;
    
    self.messageLabel.font = messageLabelFont;
    self.messageLabel.textAlignment = textAlignment;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(messageLabelLeftOffset);
        if (self.titleLabel) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        } else if (self.flagImageView) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(10);
        } else {
            make.top.mas_equalTo(self).mas_offset(10);
        }
        
        make.height.mas_equalTo(messageTextHeight);
    }];
    
}


- (void)addBottomButtonWithHeight:(CGFloat)actionButtonHeight
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle
{
    UIColor *lineColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]; //#e5e5e5
    UIColor *cancelTitleColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
    UIColor *okTitleColor = [UIColor colorWithRed:66/255.0 green:135/255.0 blue:255/255.0 alpha:1]; //#4287ff
    
    
    self.cancelHandle = cancelHandle;
    self.okHandle = okHandle;
    
    BOOL existCancelButton = cancelButtonTitle.length > 0;
    BOOL existOKButton = okButtonTitle.length > 0;
    if (existCancelButton == NO && existOKButton == NO) {
        return;
    }
    
    UIButton *cancelButton = nil;
    if (existCancelButton) {
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setBackgroundColor:[UIColor clearColor]];
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:cancelTitleColor forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *okButton = nil;
    if (existOKButton) {
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [okButton setBackgroundColor:[UIColor clearColor]];
        [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
        [okButton setTitleColor:okTitleColor forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-actionButtonHeight-1);
        make.height.mas_equalTo(1);
    }];
    
    if (existCancelButton && existOKButton) {
        [self addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.5);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(actionButtonHeight);
        }];
        
        UIView *actionSeprateLineView = [[UIView alloc] init];
        actionSeprateLineView.backgroundColor = lineColor;
        [self addSubview:actionSeprateLineView];
        [actionSeprateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cancelButton.mas_right);
            make.width.mas_equalTo(1);
            make.top.bottom.mas_equalTo(cancelButton);
        }];
        
        [self addSubview:okButton];
        [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(actionSeprateLineView.mas_right);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(actionButtonHeight);
        }];
    } else if (existCancelButton) {
        [self addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(1);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(actionButtonHeight);
        }];
        
    } else if (existOKButton) {
        [self addSubview:okButton];
        [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(1);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(actionButtonHeight);
        }];
    }
}

- (void)addMessageLabelBoderWithWidth:(CGFloat)borderWidth {
    NSAssert(self.messageLabel, @"请先添加messageLabel");
    
    self.messageLabel.layer.borderWidth = borderWidth;
}

/* 完整的描述请参见文件头部 */
- (void)show {
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                        withSize:self.size
                    showComplete:nil tapBlankComplete:nil];
}

- (void)cancelButtonAction:(UIButton *)button {
    [self cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    
    if (self.cancelHandle) {
        self.cancelHandle();
    }
}

- (void)okButtonAction:(UIButton *)button {
    [self cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    
    if (self.okHandle) {
        self.okHandle();
    }
}

#pragma mark - Private
//以下两个获取textSize取自NSString+CJTextSize
+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font
{
    if (string.length == 0)
        return CGSizeZero;
    if ([string respondsToSelector:@selector(sizeWithAttributes:)])
    {
        CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)mode
{
    if (string.length == 0) {
        return CGSizeZero;
    }
    
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = mode;
        NSDictionary *attributes = @{NSFontAttributeName:           font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect textRect = [string boundingRectWithSize:maxSize
                                               options:options
                                            attributes:attributes
                                               context:nil];
        CGSize size = textRect.size;
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode];
#pragma clang diagnostic push
    }
}


@end
