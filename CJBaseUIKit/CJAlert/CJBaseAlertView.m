//
//  CJBaseAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"
#import "CJAlertComponentFactory.h"

#import <CoreText/CoreText.h>
#import "CJThemeManager.h"

@interface CJBaseAlertView () {
    
}
@property (nonatomic, readonly) CGSize size;

////第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
//@property (nonatomic, readonly) CGFloat firstVerticalInterval;
//
////第二个视图与第一个视图的间隔
//@property (nonatomic, readonly) CGFloat secondVerticalInterval;
//
////第三个视图与第二个视图的间隔
//@property (nonatomic, readonly) CGFloat thirdVerticalInterval;
//
////底部buttons视图与其上面的视图的最小间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
//@property (nonatomic, readonly) CGFloat bottomMinVerticalInterval;



@property (nonatomic, copy) void(^cancelHandle)(void);
@property (nonatomic, copy) void(^okHandle)(void);

@end




@implementation CJBaseAlertView


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
    CJBaseAlertView *alertView = [[CJBaseAlertView alloc] initWithSize:size firstVerticalInterval:15 secondVerticalInterval:10 thirdVerticalInterval:10 bottomMinVerticalInterval:10];
    
    //②添加 flagImage、titleLabel、messageLabel
    //[alertView setupFlagImage:flagImage title:title message:message configure:configure]; //已拆解成以下几个方法
    if (flagImage) {
        [alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
    }
    if (title.length > 0) {
        [alertView addTitleWithText:title font:[UIFont systemFontOfSize:18.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
    }
    if (message.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 4;
        [alertView addMessageWithText:message font:[UIFont systemFontOfSize:14.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:paragraphStyle];
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
 *  @param bottomMinVerticalInterval 底部buttons区域视图与其上面的视图的最小间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
 *
 *  @return alertView
 */
- (instancetype)initWithSize:(CGSize)size
       firstVerticalInterval:(CGFloat)firstVerticalInterval
      secondVerticalInterval:(CGFloat)secondVerticalInterval
       thirdVerticalInterval:(CGFloat)thirdVerticalInterval
   bottomMinVerticalInterval:(CGFloat)bottomMinVerticalInterval
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        
//        self.layer.cornerRadius = 14;
//        self.backgroundColor = CJColorFromHexString([CJThemeManager serviceThemeModel].alertThemeModel.backgroundColor);
//        self.clipsToBounds = YES;
        
        _size = size;
        _firstVerticalInterval = firstVerticalInterval;
        _secondVerticalInterval = secondVerticalInterval;
        _thirdVerticalInterval = thirdVerticalInterval;
        _bottomMinVerticalInterval = bottomMinVerticalInterval;
    }
    return self;
}

/**
 *  创建alertView
 *
 *  @param size                     alertView的大小
 *
 *  @return alertView
 */
- (instancetype)initWithSize:(CGSize)size
{
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
    CGSize titleTextSize = [CJBaseAlertView getTextSizeFromString:title withFont:titleLabelFont maxSize:titleLabelMaxSize mode:NSLineBreakByCharWrapping];
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
    CGSize messageTextSize = [CJBaseAlertView getTextSizeFromString:message withFont:messageLabelFont maxSize:messageLabelMaxSize mode:NSLineBreakByCharWrapping];
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

#pragma mark - 简洁的添加方法
/**
 *  添加标题
 *
 *  @param title    标题
 *  @param titleLabelLeftOffset    titleLabelLeftOffset
 */
- (void)addTitle:(NSString *)title margin:(CGFloat)titleLabelLeftOffset {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
   paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
   paragraphStyle.lineSpacing = 5;
   [self addTitleWithText:title font:[UIFont boldSystemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:titleLabelLeftOffset paragraphStyle:paragraphStyle];
    self.titleLabel.textColor = CJColorFromHexString(@"#000000");
}


#pragma mark - 完整的添加方法
///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize {
    if (_flagImageView == nil) {
        UIImageView *flagImageView = [CJAlertComponentFactory flagImage:flagImage];
        [self addSubview:flagImageView];
        
        _flagImageView = flagImageView;
    }
    
    _flagImageViewHeight = imageViewSize.height;
}

///添加title
- (void)addTitleWithText:(NSString *)text
                    font:(UIFont *)font
           textAlignment:(NSTextAlignment)textAlignment
                  margin:(CGFloat)titleLabelLeftOffset
          paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return;
    }
    
    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
    if (_titleLabel == nil) {
        CJAlertTitleLableModel *titleLableModel = [CJAlertComponentFactory titleLabelWithText:text font:font textAlignment:textAlignment titleLabelMaxWidth:titleLabelMaxWidth paragraphStyle:paragraphStyle];
        UILabel *titleLabel = titleLableModel.titleLable;
        [self addSubview:titleLabel];
        
        _titleLabel = titleLabel;
        _titleLabelHeight = titleLableModel.titleTextHeight;
    }
}

- (void)addMessage:(NSString *)message margin:(CGFloat)messageLabelLeftOffset {
    if (message.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.firstLineHeadIndent = 10;
        [self addMessageWithText:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:messageLabelLeftOffset paragraphStyle:paragraphStyle];
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
    
    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
    if (_messageScrollView == nil) {
        CJAlertMessageLableModel *messageLableModel = [CJAlertComponentFactory messageLabelWithText:text font:font textAlignment:textAlignment messageLabelMaxWidth:messageLabelMaxWidth paragraphStyle:paragraphStyle];
        
        UIScrollView *scrollView = messageLableModel.messageScrollView;
        [self addSubview:scrollView];
        self.messageScrollView = scrollView;
        
        UIView *containerView = messageLableModel.messageContainerView;
        [scrollView addSubview:containerView];
        self.messageContainerView = containerView;
        
        UILabel *messageLabel = messageLableModel.messageLabel;
        _messageLabel = messageLabel;
        
        _messageLabelHeight = messageLableModel.messageTextHeight;
    }
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

- (void)addTextFiledWithPlaceholder:(NSString *)placeholder {
    self.textField = [CJAlertComponentFactory textFiledWithPlaceholder:placeholder];
    __weak typeof(self)weakSelf = self;
    self.textField.cjTextDidChangeBlock = ^(UITextField *textField) {
        BOOL okEnable = textField.text.length > 0;
        weakSelf.okButton.enabled = okEnable;
    };
    [self addSubview:self.textField];
    
    self.textFieldHeight = 43;
}

/**
*  添加 "OK" 的 组合按钮
*
*  @param okButtonTitle        确认文案
*  @param okHandle             确认时间
*/
- (void)addOnlyOneBottomButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                       okHandle:(void(^)(void))okHandle
{
    __weak typeof(self)weakSelf = self;
    CJAlertBottomButtonsModel *bottomButtonsModel = [CJAlertComponentFactory onlyOneBottomButtonWithIKnowButtonTitle:okButtonTitle
                                                                                                        iKnowHandle:^(UIButton *button) {
        [weakSelf dismissWithDelay:0];
        if (okHandle) {
            okHandle();
        }
    }];
    self.okButton = bottomButtonsModel.okButton;
    _bottomButtonView = bottomButtonsModel.bottomButtonView;
    
//    _bottomPartHeight = 0 + actionButtonHeight + bottomInterval;
    _bottomPartHeight = 45;
    
    [self addSubview:bottomButtonsModel.bottomButtonView];
}


///添加底部按钮
/**
 *  添加 "Cancel" + "OK" 的 组合按钮
 *
 *  @param cancelButtonTitle    取消文案
 *  @param okButtonTitle        确认文案
 *  @param cancelHandle         取消事件
 *  @param okHandle             确认时间
 */
- (void)addTwoButtonsWithCancelButtonTitle:(NSString *)cancelButtonTitle
                             okButtonTitle:(NSString *)okButtonTitle
                              cancelHandle:(void(^)(void))cancelHandle
                                  okHandle:(void(^)(void))okHandle
{
    __weak typeof(self)weakSelf = self;
    CJAlertBottomButtonsModel *bottomButtonsModel = [CJAlertComponentFactory twoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^(UIButton *button) {
        [weakSelf dismissWithDelay:0];
        if (cancelHandle) {
            cancelHandle();
        }
    } okHandle:^(UIButton *button) {
        [weakSelf dismissWithDelay:0];
        if (okHandle) {
            okHandle();
        }
    }];
    self.okButton = bottomButtonsModel.okButton;
    self.cancelButton = bottomButtonsModel.cancelButton;
    self.bottomButtonView = bottomButtonsModel.bottomButtonView;
    
//    _bottomPartHeight = 0 + actionButtonHeight + bottomInterval;
    self.bottomPartHeight = bottomButtonsModel.bottomPartHeight;
    
    [self addSubview:bottomButtonsModel.bottomButtonView];
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
    _bottomPartHeight = actionButtonHeight+1;
    
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
    [self dismissWithDelay:0];
    
    if (self.cancelHandle) {
        self.cancelHandle();
    }
}

- (void)okButtonAction:(UIButton *)button {
    [self dismissWithDelay:0];
    
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
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight blankBGColor:(UIColor *)blankBGColor
{
    [self checkAndUpdateVerticalInterval];
    
    CGFloat fixHeight = 0;
    if (shouldFitHeight) {
        CGFloat minHeight = [self getMinHeight];
        fixHeight = minHeight;
    } else {
        fixHeight = self.size.height;
    }

    [self showWithFixHeight:fixHeight blankBGColor:blankBGColor];
}

/**
 *  显示弹窗并且是以指定高度显示的
 *
 *  @param fixHeight        高度
 *  @param blankBGColor     空白区域的背景颜色
 */
- (void)showWithFixHeight:(CGFloat)fixHeight blankBGColor:(UIColor *)blankBGColor {
    [self checkAndUpdateVerticalInterval];
    
    CGFloat minHeight = [self getMinHeight];
    if (fixHeight < minHeight) {
        NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度小于视图本身的最小高度%.2lf，会导致视图显示不全，请检查", minHeight];
        NSLog(@"%@", warningString);
    }
    
    CGFloat maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 60;
    if (fixHeight > maxHeight) {
        fixHeight = maxHeight;
        
        //NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度超过视图本身的最大高度%.2lf，会导致视图显示不全，已自动缩小", maxHeight];
        //NSLog(@"%@", warningString);
        if (self.messageScrollView) {
            CGFloat minHeightWithoutMessageLabel = _firstVerticalInterval + _flagImageViewHeight + _secondVerticalInterval + _titleLabelHeight + _thirdVerticalInterval + _bottomMinVerticalInterval + _bottomPartHeight;
            
            _messageLabelHeight = fixHeight - minHeightWithoutMessageLabel;
            [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self->_messageLabelHeight);
            }];
        }
        
    }
    
    CGSize popupViewSize = CGSizeMake(self.size.width, fixHeight);
    
    [self cj_popupInCenterWindow:CJAnimationTypeNormal
                        withSize:popupViewSize
                    blankBGColor:blankBGColor
                    showComplete:nil tapBlankComplete:nil];
}

- (void)dismissWithDelay:(CGFloat)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    });
}

///获取当前alertView最小应有的高度值
- (CGFloat)getMinHeight {
    CGFloat minHeightWithMessageLabel = _firstVerticalInterval + _flagImageViewHeight + _secondVerticalInterval + _titleLabelHeight + _thirdVerticalInterval + _messageLabelHeight + _bottomMinVerticalInterval + _bottomPartHeight;
    minHeightWithMessageLabel = ceil(minHeightWithMessageLabel);
    
    return minHeightWithMessageLabel;
}

@end
