//
//  CJMessageAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJMessageAlertView.h"
#import "CJBaseOverlayThemeManager.h"

@interface CJMessageAlertView () {
    
}
@property (nonatomic, assign, readonly) CGSize imageViewSize;
@property (nonatomic, assign, readonly) CGFloat titleLabelLeftOffset;
@property (nonatomic, assign, readonly) CGFloat messageLabelLeftOffset;
@property (nonatomic, assign, readonly) CGFloat bottomButtonsLeftOffset;

@end



@implementation CJMessageAlertView

#pragma mark - Init
- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                    okButtonTitle:(NSString *)okButtonTitle
                         okHandle:(void(^)(CJMessageAlertView *bAlertView))okHandle
{
    self = [super init];
    if (self) {
        CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
        
        // flagImage、title、message
        [self __commonSetupWithAlertThemeModel:alertThemeModel flagImage:flagImage title:title message:message];
        
        // buttons
        _bottomButtonsLeftOffset = alertThemeModel.bottomButtonsLeftOffset;
        __weak typeof(self)weakSelf = self;
        [self addOnlyOneBottomButtonWithOKButtonTitle:okButtonTitle okHandle:^{
            !okHandle ?: okHandle(weakSelf);
        }];
        
        // 设置布局约束
        [self __setupConstraintsWithAlertThemeModel:alertThemeModel];
    }
    return self;
}

- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(CJMessageAlertView *bAlertView))cancelHandle
                         okHandle:(void(^)(CJMessageAlertView *bAlertView))okHandle
{
    self = [super init];
    if (self) {
        CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
        
        // flagImage、title、message
        [self __commonSetupWithAlertThemeModel:alertThemeModel flagImage:flagImage title:title message:message];
        
        // buttons
        _bottomButtonsLeftOffset = alertThemeModel.bottomButtonsLeftOffset;
        __weak typeof(self)weakSelf = self;
        [super addTwoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
            !cancelHandle ?: cancelHandle(weakSelf);
        } okHandle:^{
            !okHandle ?: okHandle(weakSelf);
        }];
        
        // 设置布局约束
        [self __setupConstraintsWithAlertThemeModel:alertThemeModel];
    }
    return self;
}

/// 创建调试的弹窗
+ (instancetype)debugMessageAlertViewWithTitle:(NSString *)title
                                       message:(NSString *)message
                          shouldContailAppInfo:(BOOL)shouldContailAppInfo
                           cancelCompleteBlock:(void(^)(CJMessageAlertView *bAlertView))cancelCompleteBlock
                            pasteCompleteBlock:(void(^)(CJMessageAlertView *bAlertView))pasteCompleteBlock
{
    NSMutableString *lastMessage = [NSMutableString string];
    if (shouldContailAppInfo) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"]; //app名
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//版本号
        NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];//buidId
        
        NSMutableString *apppInfoMessage = [NSMutableString string];
        [apppInfoMessage appendFormat:@"appName:%@\n", appName];
        [apppInfoMessage appendFormat:@"appVersion:%@\n", appVersion];
        [apppInfoMessage appendFormat:@"appBuild:  %@\n", appBuild];
        
        [lastMessage appendString:apppInfoMessage];
    }
    [lastMessage appendString:message];
    
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:title message:message cancelButtonTitle:NSLocalizedString(@"取消", nil) okButtonTitle:NSLocalizedString(@"复制到粘贴板", nil) cancelHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        //NSLog(@"调试面板:点击了取消按钮");
        !cancelCompleteBlock ?: cancelCompleteBlock(bAlertView);
    } okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        //NSLog(@"调试面板:调试信息已复制到粘贴板");
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
        
        !pasteCompleteBlock ?: pasteCompleteBlock(bAlertView);
    }];
    alertView.messageScrollView.layer.borderWidth = 0.5;
    //alertView.messageScrollView.layer.borderColor = borderColor;
    alertView.messageScrollView.layer.cornerRadius = 3;
    
    return alertView;
}


- (void)__commonSetupWithAlertThemeModel:(CJAlertThemeModel *)alertThemeModel
                               flagImage:(UIImage *)flagImage
                                   title:(NSString *)title
                                 message:(NSString *)message
{
    self.layer.cornerRadius = 14;
    self.backgroundColor = alertThemeModel.backgroundColor;
    self.clipsToBounds = YES;
    
    CGSize popupViewSize = CGSizeMake(alertThemeModel.alertWidth, 150);
    self.size = popupViewSize;
    
    // flagImage
    _imageViewSize = flagImage.size;
    [self addFlagImage:flagImage size:self.imageViewSize];
    
    //title
    _titleLabelLeftOffset = alertThemeModel.titleLabelLeftOffset;
    [super addTitle:title margin:self.titleLabelLeftOffset];
    
    //message
    _messageLabelLeftOffset = alertThemeModel.messageLabelLeftOffset;
    [self addMessage:message margin:self.messageLabelLeftOffset];
}

///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize {
    if (_flagImageView == nil && flagImage != nil) {
        UIImageView *flagImageView = [CJAlertComponentFactory flagImage:flagImage];
        [self addSubview:flagImageView];
        
        _flagImageView = flagImageView;
    }
    
    _flagImageViewHeight = imageViewSize.height;
}

- (void)addMessage:(NSString *)message margin:(CGFloat)messageLabelLeftOffset {
    
    if (message.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.firstLineHeadIndent = 10;
//        [self addMessageWithText:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:messageLabelLeftOffset paragraphStyle:paragraphStyle];
        CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
        CJAlertMessageLableModel *messageLabelModel = [CJAlertComponentFactory messageLabelWithText:message
                                                                                               font:[UIFont systemFontOfSize:15.0]
                                                                                      textAlignment:NSTextAlignmentCenter
                                                                               messageLabelMaxWidth:messageLabelMaxWidth
                                                                                     paragraphStyle:paragraphStyle];
        self.messageScrollView = messageLabelModel.messageScrollView;
        self.messageLabel = messageLabelModel.messageLabel;
        self.messageLabelHeight = messageLabelModel.messageTextHeight;
        
        [self addSubview:self.messageScrollView];
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

///更改 Message 文字颜色
- (void)updateMessageTextColor:(UIColor *)textColor {
    self.messageLabel.textColor = textColor;
}


///获取当前alertView最小应有的高度值，处信息之外
- (CGFloat)getMinHeightExpectMessageLabel {
    CGFloat minHeightWithoutMessageLabel = self.totalMarginVertical + self.flagImageViewHeight + self.titleLabelHeight + self.bottomPartHeight;
    minHeightWithoutMessageLabel = ceil(minHeightWithoutMessageLabel);
    
    return minHeightWithoutMessageLabel;
}

///获取当前alertView最小应有的高度值
- (CGFloat)getMinHeight {
    CGFloat minHeightWithoutMessageLabel = [self getMinHeightExpectMessageLabel];
    CGFloat minHeight = minHeightWithoutMessageLabel + self.messageLabelHeight;
    
    return minHeight;
}


#pragma mark - Get Method
/*
*  计算message弹窗最后的大小
*
*  @param shouldAutoFitHeight   是否根据文本自动适应高度(宽度固定)
*
*  @return message弹窗最终的大小
*/
- (CGSize)alertSizeWithShouldAutoFitHeight:(BOOL)shouldAutoFitHeight
{
    CGFloat popupViewHeight = [self __calculateAlertHeightWithShouldAutoFitHeight:shouldAutoFitHeight];
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    CGFloat popupViewWidth = alertThemeModel.alertWidth;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    return popupViewSize;
}

/*
*  计算弹窗最后的高度
*
*  @param shouldAutoFitHeight   是否根据文本自动适应高度
*
*  @return 最终的高度
*/
- (CGFloat)__calculateAlertHeightWithShouldAutoFitHeight:(BOOL)shouldAutoFitHeight
{
    // 计算最后 messageLabelHeight 的值
    CGFloat minHeightWithoutMessageLabel = [self getMinHeightExpectMessageLabel];
    CGFloat maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 200;
    CGFloat maxMessageLabelHeight = maxHeight - minHeightWithoutMessageLabel;
    
    CGFloat messageLabelHeight = 0;
    if (shouldAutoFitHeight) {
        messageLabelHeight = self.messageLabelHeight;
    } else {
        messageLabelHeight = self.size.height - minHeightWithoutMessageLabel;
//        if (messageLabelHeight < 0) {
//            NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度太小，会导致视图显示不全，请检查"];
//            NSLog(@"%@", warningString);
//        }
    }
    
    if (messageLabelHeight > maxMessageLabelHeight) {
        messageLabelHeight = maxMessageLabelHeight;
    }
    
    
    // 使用计算出来的最后 messageLabelHeight
    if (self.messageScrollView) {
        _messageLabelHeight = messageLabelHeight;
        [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(messageLabelHeight);
        }];
    }
    CGFloat fixHeight = minHeightWithoutMessageLabel + messageLabelHeight;

    return fixHeight;
}


#pragma mark - Private Method
- (void)__setupConstraintsWithAlertThemeModel:(CJAlertThemeModel *)alertThemeModel
{
    // alert 竖直上的间距:alertMarginVertical
    NSArray *alertMarginVerticals = @[@0, @0, @0, @0];
    NSInteger flagImageVerticalIndex = -1;
    NSInteger titleVerticalIndex = -1;
    NSInteger messageVerticalIndex = -1;
    NSInteger buttonsVerticalIndex = -1;
    if (self.flagImageView) {
        alertMarginVerticals = alertThemeModel.marginVertical_flagImage_title_message_buttons;
        flagImageVerticalIndex = 0;
        titleVerticalIndex = 1;
        messageVerticalIndex = 2;
        buttonsVerticalIndex = 3;
    } else {
        if (self.titleLabel) {
            if (self.messageLabel) {
                alertMarginVerticals = alertThemeModel.marginVertical_title_message_buttons;
                flagImageVerticalIndex = -1;
                titleVerticalIndex = 0;
                messageVerticalIndex = 1;
                buttonsVerticalIndex = 2;
            } else {
                alertMarginVerticals = alertThemeModel.marginVertical_title_buttons;
                flagImageVerticalIndex = -1;
                titleVerticalIndex = 0;
                messageVerticalIndex = -1;
                buttonsVerticalIndex = 1;
            }
        } else {
            alertMarginVerticals = alertThemeModel.marginVertical_message_buttons;
            flagImageVerticalIndex = -1;
            titleVerticalIndex = -1;
            messageVerticalIndex = 0;
            buttonsVerticalIndex = 1;
        }
    }
    
    for (NSInteger i = 0; i <= buttonsVerticalIndex; i++) {
        NSNumber *marginVertical = alertMarginVerticals[i];
        self.totalMarginVertical += [marginVertical floatValue];
    }
    
    
    if (self.flagImageView) {
        NSNumber *flagImageMarginTop = alertMarginVerticals[flagImageVerticalIndex];
        [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(self.imageViewSize.width);
            make.top.mas_equalTo(self).mas_offset(flagImageMarginTop);
            make.height.mas_equalTo(self.imageViewSize.height);
        }];
    }
    
    if (self.titleLabel) {
        CGFloat titleTextHeight = self.titleLabelHeight;
        NSNumber *titleMarginTop = alertMarginVerticals[titleVerticalIndex];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(self.titleLabelLeftOffset);
            if (self.flagImageView) {
                make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(titleMarginTop);
            } else {
                make.top.mas_greaterThanOrEqualTo(self).mas_offset(titleMarginTop);//优先级
            }
            make.height.mas_equalTo(titleTextHeight);
        }];
    }
    
    
    if (self.messageScrollView) {
        CGFloat messageTextHeight = self.messageLabelHeight;
        NSNumber *messageMarginTop = alertMarginVerticals[messageVerticalIndex];
        [self.messageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(self.messageLabelLeftOffset);
            if (self.titleLabel) {
                if (self.flagImageView) {
                    make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(messageMarginTop);
                } else {
                    make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(messageMarginTop);
                }
            } else if (self.flagImageView) {
                make.top.mas_greaterThanOrEqualTo(self.flagImageView.mas_bottom).mas_offset(messageMarginTop);//优先级
            } else {
                make.top.mas_greaterThanOrEqualTo(self).mas_offset(messageMarginTop);//优先级
            }
            
            make.height.mas_equalTo(messageTextHeight);
        }];
    }
    
    //NSNumber *buttonMarginTop = alertMarginVerticals[buttonsVerticalIndex];
    NSNumber *buttonMarginBottom = alertMarginVerticals[buttonsVerticalIndex+1];
    CGFloat actionButtonHeight = alertThemeModel.actionButtonHeight;
    [self.bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(buttonMarginTop);
        make.bottom.mas_equalTo(-[buttonMarginBottom floatValue]);
        make.height.mas_equalTo(actionButtonHeight);
        make.left.mas_equalTo(self).mas_offset(self.bottomButtonsLeftOffset);
        make.centerX.mas_equalTo(self);
    }];
}


@end
