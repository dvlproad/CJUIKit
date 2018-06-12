//
//  CJAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlertView.h"

#ifdef CJTESTPOD
#import "UIView+CJPopupInView.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#endif


#import <CoreText/CoreText.h>

@interface CJAlertView () {
    CGFloat _flagImageViewHeight, _titleLabelHeight, _messageLabelHeight, _bottomButtonHeight;
}
@property (nonatomic, readonly) CGSize size;

//第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
@property (nonatomic, readonly) CGFloat firstVerticalInterval;

//第二个视图与第一个视图的间隔
@property (nonatomic, readonly) CGFloat secondVerticalInterval;

//第三个视图与第二个视图的间隔
@property (nonatomic, readonly) CGFloat thirdVerticalInterval;

//底部buttons视图与其上面的视图的间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
@property (nonatomic, readonly) CGFloat bottomVerticalInterval;

@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;

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
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:size firstVerticalInterval:25 secondVerticalInterval:10 thirdVerticalInterval:10 bottomVerticalInterval:10];
    
    //②添加 flagImage、titleLabel、messageLabel
    //[alertView setupFlagImage:flagImage title:title message:message configure:configure]; //已拆解成以下几个方法
    if (flagImage) {
        [alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
    }
    if (title.length > 0) {
        UIFont *titleLabelFont = [UIFont systemFontOfSize:18.0];
        [alertView addTitleWithText:title font:titleLabelFont textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
    }
    if (message.length > 0) {
        UIFont *messageLabelFont = [UIFont systemFontOfSize:15.0];
        [alertView addMessageWithText:message font:messageLabelFont textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
    }
    
    //③添加 cancelButton、okButton
    [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    
    return alertView;
}

/**
 *  创建alertView
 *  @brief  这里所说的三个视图范围为：flagImageView(有的话，一定是第一个)、titleLabel(有的话，有可能一或二)、messageLabel(有的话，有可能一或二或三)
 *
 *  @param size                     alertView的大小
 *  @param firstVerticalInterval    第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
 *  @param secondVerticalInterval   第二个视图与第一个视图的间隔(如果少于两个视图,这个值设为0即可)
 *  @param thirdVerticalInterval    第三个视图与第二个视图的间隔(如果少于三个视图,这个值设为0即可)
 *  @param bottomVerticalInterval   底部buttons视图与其上面的视图的间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
 *
 *  @return alertView
 */
- (instancetype)initWithSize:(CGSize)size
       firstVerticalInterval:(CGFloat)firstVerticalInterval
      secondVerticalInterval:(CGFloat)secondVerticalInterval
       thirdVerticalInterval:(CGFloat)thirdVerticalInterval
      bottomVerticalInterval:(CGFloat)bottomVerticalInterval
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        
        _size = size;
        _firstVerticalInterval = firstVerticalInterval;
        _secondVerticalInterval = secondVerticalInterval;
        _thirdVerticalInterval = thirdVerticalInterval;
        _bottomVerticalInterval = bottomVerticalInterval;
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

///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize {
    if (_flagImageView == nil) {
        UIImageView *flagImageView = [[UIImageView alloc] init];
        [self addSubview:flagImageView];
        
        _flagImageView = flagImageView;
    }
    _flagImageView.image = flagImage;
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(imageViewSize.width);
        make.top.mas_equalTo(self).mas_offset(self.firstVerticalInterval);
        make.height.mas_equalTo(imageViewSize.height);
    }];
    _flagImageViewHeight = imageViewSize.height;
    
    if (self.titleLabel) {
        //由于约束部分不一样，使用update会增加一个新约束，又没设置优先级，从而导致约束冲突。而如果用remake的话，又需要重新设置之前已经设置过的，否则容易缺失。所以使用masnory时候，使用优先级比较合适
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(self.secondVerticalInterval);
        }];
    }
    
    if (self.messageScrollView) {
        [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.titleLabel) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(self.thirdVerticalInterval);
                
            } else {
                make.top.mas_greaterThanOrEqualTo(self.flagImageView.mas_bottom).mas_offset(self.secondVerticalInterval);
            }
        }];
    }
}

///添加title
- (void)addTitleWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        //titleLabel.backgroundColor = [UIColor purpleColor];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        _titleLabel = titleLabel;
    }
    
    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
    CGSize titleLabelMaxSize = CGSizeMake(titleLabelMaxWidth, CGFLOAT_MAX);
    

    CGSize titleTextSize = [CJAlertView getTextSizeFromString:text withFont:font maxSize:titleLabelMaxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:paragraphStyle];
    CGFloat titleTextHeight = titleTextSize.height;
    
    NSMutableArray *lineStringArray = [CJAlertView getLineStringArrayForText:text withFont:font maxTextWidth:titleLabelMaxWidth];
    CGFloat lineCount = lineStringArray.count;
    CGFloat lineSpacing = paragraphStyle.lineSpacing;
    if (lineSpacing == 0) {
        lineSpacing = 2;
    }
    titleTextHeight += lineCount * lineSpacing;
    
    self.titleLabel.text = text;
    self.titleLabel.font = font;
    self.titleLabel.textAlignment = textAlignment;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(titleLabelLeftOffset);
        if (self.flagImageView) {
            make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(self.secondVerticalInterval);
        } else {
            make.top.mas_greaterThanOrEqualTo(self).mas_offset(self.firstVerticalInterval);//优先级
        }
        make.height.mas_equalTo(titleTextHeight);
    }];
    _titleLabelHeight = titleTextHeight;
    
    if (self.messageScrollView) {
        [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.flagImageView) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(self.thirdVerticalInterval);
            } else {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(self.secondVerticalInterval);
            }
        }];
    }
}

///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
- (void)addMessageWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    //paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //paragraphStyle.lineSpacing = lineSpacing;
    //paragraphStyle.headIndent = 10;
    
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    if (_messageScrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        //scrollView.backgroundColor = [UIColor redColor];
        [self addSubview:scrollView];
        self.messageScrollView = scrollView;
        
        UIView *containerView = [[UIView alloc] init];
        //containerView.backgroundColor = [UIColor greenColor];
        [scrollView addSubview:containerView];
        self.messageContainerView = containerView;
        
        UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        messageLabel.numberOfLines = 0;
        //UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectZero];
        //messageLabel.editable = NO;
        
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = messageTextColor;
        [containerView addSubview:messageLabel];
        
        _messageLabel = messageLabel;
    }
    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
    CGSize messageLabelMaxSize = CGSizeMake(messageLabelMaxWidth, CGFLOAT_MAX);
    CGSize messageTextSize = [CJAlertView getTextSizeFromString:text withFont:font maxSize:messageLabelMaxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:paragraphStyle];
    CGFloat messageTextHeight = messageTextSize.height;
    
    NSMutableArray *lineStringArray = [CJAlertView getLineStringArrayForText:text withFont:font maxTextWidth:messageLabelMaxWidth];
    CGFloat lineCount = lineStringArray.count;
    CGFloat lineSpacing = paragraphStyle.lineSpacing;
    if (lineSpacing == 0) {
        lineSpacing = 2;
    }
    messageTextHeight += lineCount * lineSpacing;
    
    if (paragraphStyle == nil) {
        self.messageLabel.text = text;
    } else {
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedText addAttributes:attributes range:NSMakeRange(0, text.length)];
        //[attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        
        self.messageLabel.attributedText = attributedText;
    }
    
    self.messageLabel.font = font;
    self.messageLabel.textAlignment = textAlignment;
    [self.messageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(messageLabelLeftOffset);
        if (self.titleLabel) {
            if (self.flagImageView) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(self.thirdVerticalInterval);
            } else {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(self.secondVerticalInterval);
            }
        } else if (self.flagImageView) {
            make.top.mas_greaterThanOrEqualTo(self.flagImageView.mas_bottom).mas_offset(self.secondVerticalInterval);//优先级
        } else {
            make.top.mas_greaterThanOrEqualTo(self).mas_offset(self.firstVerticalInterval);//优先级
        }
        
        make.height.mas_equalTo(messageTextHeight);
    }];
    
    [self.messageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.messageScrollView);
        make.top.bottom.mas_equalTo(self.messageScrollView);
        make.width.mas_equalTo(self.messageScrollView.mas_width);
        make.height.mas_equalTo(messageTextHeight);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.messageContainerView);
        make.top.mas_equalTo(self.messageContainerView);
        make.height.mas_equalTo(messageTextHeight);
    }];
    _messageLabelHeight = messageTextHeight;
}

///添加 message 的边框等(几乎不会用到)
- (void)addMessageLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat)cornerRadius {
    NSAssert(self.messageScrollView, @"请先添加messageScrollView");
    
    self.messageScrollView.layer.borderWidth = borderWidth;
    
    if (borderColor) {
        self.messageScrollView.layer.borderColor = borderColor;
    }
    
    self.messageScrollView.layer.cornerRadius = cornerRadius;
}

///添加底部按钮
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
        _cancelButton = cancelButton;
    }
    
    UIButton *okButton = nil;
    if (existOKButton) {
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [okButton setBackgroundColor:[UIColor clearColor]];
        [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
        [okButton setTitleColor:okTitleColor forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _okButton = okButton;
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-actionButtonHeight-1);
        make.height.mas_equalTo(1);
    }];
    _bottomButtonHeight = actionButtonHeight+1;
    
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

///更改 Title 文字颜色
- (void)updateTitleTextColor:(UIColor *)textColor {
    self.titleLabel.textColor = textColor;
}

///更改 Message 文字颜色
- (void)updateMessageTextColor:(UIColor *)textColor {
    self.messageLabel.textColor = textColor;
}

///更改底部 Cancel 按钮的文字颜色
- (void)updateCancelButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor {
    [self.cancelButton setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

///更改底部 OK 按钮的文字颜色
- (void)updateOKButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor {
    [self.okButton setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self.okButton setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
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

/**
 *  通过检查位于bottomButtons上view的个数来判断并修正之前设置的VerticalInterval(防止比如有时候只设置两个view，thirdVerticalInterval却不为0)
 *  @brief 问题来源：比如少于三个视图,thirdVerticalInterval却没设为0,此时如果不通过此方法检查并修正，则容易出现高度计算错误的问题
 */
- (void)checkAndUpdateVerticalInterval {
    NSInteger upViewCount = 0;
    if (self.flagImageView) {
        upViewCount++;
    }
    if (self.titleLabel) {
        upViewCount++;
    }
    if (self.messageScrollView) {
        upViewCount++;
    }
    if (upViewCount == 2) {
        _thirdVerticalInterval = 0;
    } else if (upViewCount == 1) {
        _secondVerticalInterval = 0;
    }
}

/* 完整的描述请参见文件头部 */
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight {
    [self checkAndUpdateVerticalInterval];
    
    CGFloat fixHeight = 0;
    if (shouldFitHeight) {
        CGFloat minHeight = [self getMinHeight];
        fixHeight = minHeight;
    } else {
        fixHeight = self.size.height;
    }

    [self showWithFixHeight:fixHeight];
}

/**
 *  显示弹窗并且是以指定高度显示的
 *
 *  @param fixHeight 高度
 */
- (void)showWithFixHeight:(CGFloat)fixHeight {
    [self checkAndUpdateVerticalInterval];
    
    CGFloat minHeight = [self getMinHeight];
    if (fixHeight < minHeight) {
        NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度小于视图本身的最小高度%.2lf，会导致视图显示不全，请检查", minHeight];
        NSLog(@"%@", warningString);
    }
    
    CGFloat maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 60;
    if (fixHeight > maxHeight) {
        fixHeight = maxHeight;
        
        NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度超过视图本身的最大高度%.2lf，会导致视图显示不全，已自动缩小", maxHeight];
        NSLog(@"%@", warningString);
        if (self.messageScrollView) {
            CGFloat minHeightWithoutMessageLabel = _firstVerticalInterval + _flagImageViewHeight + _secondVerticalInterval + _titleLabelHeight + _thirdVerticalInterval + _bottomVerticalInterval + _bottomButtonHeight;
            
            _messageLabelHeight = fixHeight - minHeightWithoutMessageLabel;
            [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(_messageLabelHeight);
            }];
        }
        
    }
    
    CGSize popupViewSize = CGSizeMake(self.size.width, fixHeight);
    
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                        withSize:popupViewSize
                    showComplete:nil tapBlankComplete:nil];
}

///获取当前alertView最小应有的高度值
- (CGFloat)getMinHeight {
    CGFloat minHeight = _firstVerticalInterval + _flagImageViewHeight + _secondVerticalInterval + _titleLabelHeight + _thirdVerticalInterval + _messageLabelHeight + _bottomVerticalInterval + _bottomButtonHeight;
    minHeight = ceil(minHeight);
    
    return minHeight;
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


+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font
                        maxSize:(CGSize)maxSize
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    if (string.length == 0) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        if (paragraphStyle == nil) {
            paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = lineBreakMode;
        }
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        
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
        return [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}



///获取每行的字符串组成的数组
+ (NSMutableArray<NSString *> *)getLineStringArrayForText:(NSString *)labelText
                                                 withFont:(UIFont *)font
                                             maxTextWidth:(CGFloat)maxTextWidth
{
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:labelText];
    
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxTextWidth, 100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    
    NSMutableArray *lineStringArray = [[NSMutableArray alloc] init];
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [labelText substringWithRange:range];
        
        [lineStringArray addObject:lineString];
        
    }
    
    return lineStringArray;
}

@end
