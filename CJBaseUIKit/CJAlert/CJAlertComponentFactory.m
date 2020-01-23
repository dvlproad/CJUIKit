//
//  CJAlertComponentFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlertComponentFactory.h"
#import <CoreText/CoreText.h>
#import "CJThemeManager.h"


@implementation CJAlertComponentFactory


#pragma mark - 完整的添加方法
///添加指示图标
+ (UIImageView *)flagImage:(UIImage *)flagImage {
    UIImageView *flagImageView = [[UIImageView alloc] init];
    flagImageView.image = flagImage;
    
    return flagImageView;
}

///添加title
+ (CJAlertTitleLableModel *)titleLabelWithText:(NSString *)text
                           font:(UIFont *)font
                  textAlignment:(NSTextAlignment)textAlignment
             titleLabelMaxWidth:(CGFloat)titleLabelMaxWidth
                 paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
//    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
//        return;
//    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //titleLabel.backgroundColor = [UIColor purpleColor];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    
    if (text == nil) {
        text = @""; //若为nil,则设置[[NSMutableAttributedString alloc] initWithString:labelText]的时候会崩溃
    }
    
//    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
    CGSize titleLabelMaxSize = CGSizeMake(titleLabelMaxWidth, CGFLOAT_MAX);
    

    CGSize titleTextSize = [CJAlertComponentFactory getTextSizeFromString:text withFont:font maxSize:titleLabelMaxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:paragraphStyle];
    CGFloat titleTextHeight = titleTextSize.height;
    
    NSMutableArray *lineStringArray = [CJAlertComponentFactory getLineStringArrayForText:text withFont:font maxTextWidth:titleLabelMaxWidth];
    CGFloat lineCount = lineStringArray.count;
    CGFloat lineSpacing = paragraphStyle.lineSpacing;
    if (lineSpacing == 0) {
        lineSpacing = 2;
    }
    titleTextHeight += lineCount * lineSpacing;
    
    if (paragraphStyle == nil) {
        titleLabel.text = text;
    } else {
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedText addAttributes:attributes range:NSMakeRange(0, text.length)];
        //[attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        
        titleLabel.attributedText = attributedText;
    }
    
    titleLabel.font = font;
    titleLabel.textAlignment = textAlignment;
    
    CJAlertTitleLableModel *titleLableModel = [[CJAlertTitleLableModel alloc] init];
    titleLableModel.titleLable = titleLabel;
    titleLableModel.titleTextHeight = titleTextHeight;
    
    return titleLableModel;
}

///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
+ (CJAlertMessageLableModel *)messageLabelWithText:(NSString *)text
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
             messageLabelMaxWidth:(CGFloat)messageLabelMaxWidth
                   paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    //paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //paragraphStyle.lineSpacing = lineSpacing;
    //paragraphStyle.headIndent = 10;
    
//    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
//        return;
//    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //scrollView.backgroundColor = [UIColor redColor];
//    [self addSubview:scrollView];
//    self.messageScrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    //containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
//    self.messageContainerView = containerView;
    
    UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.numberOfLines = 0;
    //UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectZero];
    //messageLabel.editable = NO;
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = messageTextColor;
    [containerView addSubview:messageLabel];
    
//    _messageLabel = messageLabel;
    
    
    
//    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
    CGSize messageLabelMaxSize = CGSizeMake(messageLabelMaxWidth, CGFLOAT_MAX);
    CGSize messageTextSize = [CJAlertComponentFactory getTextSizeFromString:text withFont:font maxSize:messageLabelMaxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:paragraphStyle];
    CGFloat messageTextHeight = messageTextSize.height;
    
    NSMutableArray *lineStringArray = [CJAlertComponentFactory getLineStringArrayForText:text withFont:font maxTextWidth:messageLabelMaxWidth];
    CGFloat lineCount = lineStringArray.count;
    CGFloat lineSpacing = paragraphStyle.lineSpacing;
    if (lineSpacing == 0) {
        lineSpacing = 2;
    }
    messageTextHeight += lineCount * lineSpacing;
    
    if (paragraphStyle == nil) {
        messageLabel.text = text;
    } else {
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedText addAttributes:attributes range:NSMakeRange(0, text.length)];
        //[attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        
        messageLabel.attributedText = attributedText;
    }
    
    messageLabel.font = font;
    messageLabel.textAlignment = textAlignment;
    
    CJAlertMessageLableModel *messageLableModel = [[CJAlertMessageLableModel alloc] init];
    messageLableModel.messageScrollView = scrollView;
    messageLableModel.messageContainerView = containerView;
    messageLableModel.messageLabel = messageLabel;
    messageLableModel.messageTextHeight = messageTextHeight;
    
//    _messageLabelHeight = messageTextHeight;
    return messageLableModel;
}

+ (CJTextField *)textFiledWithPlaceholder:(NSString *)placeholder {
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString([CJThemeManager serviceThemeModel].alertThemeModel.textFieldBackgroundColor);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.cornerRadius = 6;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField cj_addLeftOffset:15];
    
    textField.placeholder = placeholder;
    
    return textField;
}


///只添加一个按钮
+ (CJAlertBottomButtonsModel *)onlyOneBottomButtonWithIKnowButtonTitle:(NSString *)iKnowButtonTitle
                                                           iKnowHandle:(void(^)(UIButton *button))iKnowHandle
{
    UIView *bottomButtonView = [[UIView alloc] init];
    
    UIButton *iKnowButton = [self __okButtonWithOKButtonTitle:iKnowButtonTitle okHandle:iKnowHandle];
    [bottomButtonView addSubview:iKnowButton];
//    CGFloat actionButtonHeight = 45;
//    CGFloat bottomInterval = 0;
//    CGFloat bottomButtonsLeftOffset = 0;
    [iKnowButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-bottomInterval);
//        make.height.mas_equalTo(actionButtonHeight);
//        make.left.mas_equalTo(bottomButtonView).mas_offset(bottomButtonsLeftOffset);
//        make.centerX.mas_equalTo(bottomButtonView);
        make.left.right.bottom.mas_equalTo(bottomButtonView);
        make.top.mas_equalTo(bottomButtonView).mas_equalTo(-1);
    }];
    
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = CJColorFromHexString([CJThemeManager serviceThemeModel].separateLineColor);
    [bottomButtonView addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(bottomButtonView);
        make.bottom.mas_equalTo(iKnowButton.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    CJAlertBottomButtonsModel *bottomButtonsModel = [[CJAlertBottomButtonsModel alloc] init];
    bottomButtonsModel.bottomButtonView = bottomButtonView;
    bottomButtonsModel.bottomPartHeight = 45;
    bottomButtonsModel.okButton = iKnowButton;
    
    return bottomButtonsModel;
}

/**
 *  添加 "Cancel" + "OK" 的 组合按钮
 *
 *  @param cancelButtonTitle    取消文案
 *  @param okButtonTitle            确认文案
 *  @param cancelHandle              取消事件
 *  @param okHandle                       确认事件
 */
+ (CJAlertBottomButtonsModel *)twoButtonsWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                                 okButtonTitle:(NSString *)okButtonTitle
                                                  cancelHandle:(void(^)(UIButton *button))cancelHandle
                                                      okHandle:(void(^)(UIButton *button))okHandle
{
    if (0) {
        return [self __spaceTwoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    } else {
        return [self __closeTwoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    }
}


/**
 *  添加 "Cancel" + "OK" 的 组合按钮
 *
 *  @param cancelButtonTitle    取消文案
 *  @param okButtonTitle            确认文案
 *  @param cancelHandle              取消事件
 *  @param okHandle                       确认事件
 */
+ (CJAlertBottomButtonsModel *)__spaceTwoButtonsWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                                      okButtonTitle:(NSString *)okButtonTitle
                                                       cancelHandle:(void(^)(UIButton *button))cancelHandle
                                                           okHandle:(void(^)(UIButton *button))okHandle
{
    //bottomButtons
    UIButton *cancelButton = [self __sapceCancelButtonWithCancelButtonTitle:cancelButtonTitle cancelHandle:cancelHandle];;
    UIButton *okButton = [self __spaceOKButtonWithOKButtonTitle:okButtonTitle okHandle:okHandle];
    
    CGFloat actionButtonHeight = 32;
    CGFloat bottomInterval = 15;
    CGFloat fixedSpacing = 10;
    CGFloat leadSpacing = 15;
    CGFloat tailSpacing = 15;
    CJAlertBottomButtonsModel *bottomButtonsModel = [self __twoButtonsWithCancelButton:cancelButton
                                                                              okButton:okButton
                                                                    actionButtonHeight:actionButtonHeight
                                                                        bottomInterval:bottomInterval
                                                                          fixedSpacing:fixedSpacing
                                                                           leadSpacing:leadSpacing
                                                                           tailSpacing:tailSpacing];
    return bottomButtonsModel;
}


/**
 *  添加 "Cancel" + "OK" 的 组合按钮
 *
 *  @param cancelButtonTitle    取消文案
 *  @param okButtonTitle            确认文案
 *  @param cancelHandle              取消事件
 *  @param okHandle                       确认事件
 */
+ (CJAlertBottomButtonsModel *)__closeTwoButtonsWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                                      okButtonTitle:(NSString *)okButtonTitle
                                                       cancelHandle:(void(^)(UIButton *button))cancelHandle
                                                           okHandle:(void(^)(UIButton *button))okHandle
{
    //bottomButtons
    UIButton *cancelButton = [self __cancelButtonWithCancelButtonTitle:cancelButtonTitle cancelHandle:cancelHandle];;
    UIButton *okButton = [self __okButtonWithOKButtonTitle:okButtonTitle okHandle:okHandle];
    
    CGFloat actionButtonHeight = 45;
    CGFloat bottomInterval = 0;
    CGFloat fixedSpacing = 1;
    CGFloat leadSpacing = 0;
    CGFloat tailSpacing = 0;
    CJAlertBottomButtonsModel *bottomButtonsModel = [self __twoButtonsWithCancelButton:cancelButton
                                                                              okButton:okButton
                                                                    actionButtonHeight:actionButtonHeight
                                                                        bottomInterval:bottomInterval
                                                                          fixedSpacing:fixedSpacing
                                                                           leadSpacing:leadSpacing
                                                                           tailSpacing:tailSpacing];
    UIView *bottomButtonView = bottomButtonsModel.bottomButtonView;
    
    UIColor *separateLineColor = CJColorFromHexString([CJThemeManager serviceThemeModel].separateLineColor);    //分割线颜色
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = separateLineColor;
    [bottomButtonView addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(bottomButtonView);
        make.bottom.mas_equalTo(okButton.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = separateLineColor;
    [bottomButtonView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancelButton);
        make.bottom.mas_equalTo(bottomButtonView);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.width.mas_equalTo(0.5);
    }];
    
    return bottomButtonsModel;
}

///**
// *  添加 "Cancel" + "OK" 的 组合按钮
// *
// *  @param cancelButtonTitle    取消文案
// *  @param okButtonTitle            确认文案
// *  @param cancelHandle              取消事件
// *  @param okHandle                       确认事件
// */
//+ (CJAlertBottomButtonsModel *)spaceTwoButtonsWithCancelButtonTitle:(NSString *)cancelButtonTitle
//                                                 okButtonTitle:(NSString *)okButtonTitle
//                                                  cancelHandle:(void(^)(UIButton *button))cancelHandle
//                                                      okHandle:(void(^)(UIButton *button))okHandle
//{
//     UIView *bottomButtonView = [[UIView alloc] init];
//            
//    //bottomButtons
//    UIButton *cancelButton = [self __sapceCancelButtonWithCancelButtonTitle:cancelButtonTitle cancelHandle:cancelHandle];;
//    UIButton *okButton = [self __spaceOKButtonWithOKButtonTitle:okButtonTitle okHandle:okHandle];
////    self.cancelButton = cancelButton;
////    self.okButton = okButton;
//    
//    NSArray<UIButton *> *bottomButtons = @[cancelButton, okButton];
////        [self addBottomButtons:bottomButtons withHeight:32 bottomInterval:15 alongAxis:MASAxisTypeHorizontal fixedSpacing:10 leadSpacing:15 tailSpacing:15];
//    
//    CGFloat bottomPartHeight = 0;
//    CGFloat actionButtonHeight = 32;
//    CGFloat bottomInterval = 15;
//    MASAxisType axisType = MASAxisTypeHorizontal;
//    CGFloat fixedSpacing = 10;
//    CGFloat leadSpacing = 15;
//    CGFloat tailSpacing = 15;
//    NSInteger buttonCount = bottomButtons.count;
//    if (axisType == MASAxisTypeHorizontal) {
//        bottomPartHeight = 0 + actionButtonHeight + bottomInterval;
//    } else {
//        bottomPartHeight = leadSpacing + buttonCount*(actionButtonHeight+fixedSpacing)-fixedSpacing + tailSpacing;
//    }
//    self.bottomPartHeight = bottomPartHeight;
//                
//        for (UIButton *bottomButton in bottomButtons) {
//            [bottomButtonView addSubview:bottomButton];
//        }
//    //    _bottomButtons = bottomButtons;
//        
//        if (buttonCount > 1) {
//            [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.mas_equalTo(-bottomInterval);
//                make.height.mas_equalTo(actionButtonHeight);
//            }];
//            [bottomButtons mas_distributeViewsAlongAxis:axisType withFixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
//        } else {
//            [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.mas_equalTo(-bottomInterval);
//                make.height.mas_equalTo(actionButtonHeight);
//                make.left.mas_equalTo(bottomButtonView).mas_offset(leadSpacing);
//                make.right.mas_equalTo(bottomButtonView).mas_offset(-tailSpacing);
//            }];
//        }
//        
//     
//    
//    self.okButton = okButton;
//    self.cancelButton = cancelButton;
//    self.bottomButtonView = bottomButtonView;
//    
//
//    [self addSubview:bottomButtonView];
//}
//
//+ (UIButton *)__spaceOKButtonWithOKButtonTitle:(NSString *)okButtonTitle
//                                 okHandle:(void(^)(UIButton *button))okHandle
//{
//    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [okButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateNormal];
//    okButton.cjNormalBGColor = CJColorFromHexString(@"#2F7DE1");
//    okButton.layer.masksToBounds = YES;
//    okButton.layer.cornerRadius = 16;
//    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
//    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    [okButton setCjTouchUpInsideBlock:okHandle];
//    
//    return okButton;
//}
//
//+ (UIButton *)__sapceCancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
//                                     cancelHandle:(void(^)(UIButton *button))cancelHandle
//{
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setTitleColor:CJColorFromHexString(@"#2F7DE1") forState:UIControlStateNormal];
//    cancelButton.cjNormalBGColor = CJColorFromHexString(@"#FFFFFF");
//    cancelButton.layer.cornerRadius = 16;
//    cancelButton.layer.borderWidth = 1;
//    cancelButton.layer.borderColor = CJColorFromHexString(@"#2F7DE1").CGColor;
//    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
//    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    [cancelButton setCjTouchUpInsideBlock:cancelHandle];
//    
//    return cancelButton;
//}


#pragma mark - Private Method
/**
 *  添加 "Cancel" + "OK" 的 组合按钮
 *
 *  @param cancelButton                     取消按钮
 *  @param okButton                              确认按钮
 *  @param actionButtonHeight        actionButtonHeight
 *  @param bottomInterval                 bottomInterval
 *  @param fixedSpacing                      fixedSpacing
 *  @param leadSpacing                        leadSpacing
 *  @param tailSpacing                        tailSpacing
 */
+ (CJAlertBottomButtonsModel *)__twoButtonsWithCancelButton:(UIButton *)cancelButton
                                                   okButton:(UIButton *)okButton
                                         actionButtonHeight:(CGFloat)actionButtonHeight
                                             bottomInterval:(CGFloat)bottomInterval
                                               fixedSpacing:(CGFloat)fixedSpacing
                                                leadSpacing:(CGFloat)leadSpacing
                                                tailSpacing:(CGFloat)tailSpacing
                                            
{
    UIView *bottomButtonView = [[UIView alloc] init];
    
    //bottomButtons
    MASAxisType axisType = MASAxisTypeHorizontal;
    
    CGFloat bottomPartHeight = 0;
    NSArray<UIButton *> *bottomButtons = @[cancelButton, okButton];
    NSInteger buttonCount = bottomButtons.count;
    if (axisType == MASAxisTypeHorizontal) {
        bottomPartHeight = 0 + actionButtonHeight + bottomInterval;
    } else {
        bottomPartHeight = leadSpacing + buttonCount*(actionButtonHeight+fixedSpacing)-fixedSpacing + tailSpacing;
    }
    
    for (UIButton *bottomButton in bottomButtons) {
        [bottomButtonView addSubview:bottomButton];
    }
    if (buttonCount > 1) {
        [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-bottomInterval);
            make.height.mas_equalTo(actionButtonHeight);
        }];
        [bottomButtons mas_distributeViewsAlongAxis:axisType withFixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
    } else {
        [bottomButtons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-bottomInterval);
            make.height.mas_equalTo(actionButtonHeight);
            make.left.mas_equalTo(bottomButtonView).mas_offset(leadSpacing);
            make.right.mas_equalTo(bottomButtonView).mas_offset(-tailSpacing);
        }];
    }
    
    CJAlertBottomButtonsModel *bottomButtonsModel = [[CJAlertBottomButtonsModel alloc] init];
    bottomButtonsModel.bottomButtonView = bottomButtonView;
    bottomButtonsModel.bottomPartHeight = bottomPartHeight;
    bottomButtonsModel.okButton = okButton;
    bottomButtonsModel.cancelButton = cancelButton;
    
    return bottomButtonsModel;
}

+ (UIButton *)__okButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                 okHandle:(void(^)(UIButton *button))okHandle
{
    UIColor *okButtonEnableTitleColor = CJColorFromHexStringAndAlpha([CJThemeManager serviceThemeModel].themeBlueColor, 1.0);
    UIColor *okButtondisableTitleColor = CJColorFromHexStringAndAlpha([CJThemeManager serviceThemeModel].themeBlueColor, 0.6);
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitleColor:okButtonEnableTitleColor forState:UIControlStateNormal];
    [okButton setTitleColor:okButtondisableTitleColor forState:UIControlStateDisabled];
    okButton.cjNormalBGColor = [UIColor clearColor];
    okButton.cjHighlightedBGColor = [UIColor clearColor];
    okButton.cjDisabledBGColor = [UIColor clearColor];
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [okButton setCjTouchUpInsideBlock:okHandle];
    
//    okButton.layer.masksToBounds = YES;
//    okButton.layer.cornerRadius = 16;
    
    return okButton;
}

+ (UIButton *)__cancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                     cancelHandle:(void(^)(UIButton *button))cancelHandle
{
    UIColor *cancelButtonEnableTitleColor = CJColorFromHexStringAndAlpha([CJThemeManager serviceThemeModel].text666Color, 1.0);
    UIColor *cancelButtondisableTitleColor = CJColorFromHexStringAndAlpha([CJThemeManager serviceThemeModel].text666Color, 0.6);
    
    UIButton *cancelButton = [self __okButtonWithOKButtonTitle:cancelButtonTitle okHandle:cancelHandle];
    [cancelButton setTitleColor:cancelButtonEnableTitleColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:cancelButtondisableTitleColor forState:UIControlStateDisabled];
    
    return cancelButton;
}

#pragma mark - Private Method
+ (UIButton *)__spaceOKButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                 okHandle:(void(^)(UIButton *button))okHandle
{
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateNormal];
    okButton.cjNormalBGColor = CJColorFromHexString(@"#2F7DE1");
    okButton.layer.masksToBounds = YES;
    okButton.layer.cornerRadius = 16;
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [okButton setCjTouchUpInsideBlock:okHandle];
    
    return okButton;
}

+ (UIButton *)__sapceCancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle
                                     cancelHandle:(void(^)(UIButton *button))cancelHandle
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitleColor:CJColorFromHexString(@"#2F7DE1") forState:UIControlStateNormal];
    cancelButton.cjNormalBGColor = CJColorFromHexString(@"#FFFFFF");
    cancelButton.layer.cornerRadius = 16;
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.borderColor = CJColorFromHexString(@"#2F7DE1").CGColor;
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [cancelButton setCjTouchUpInsideBlock:cancelHandle];
    
    return cancelButton;
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
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:labelText];
    [attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, attString.length)];
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxTextWidth, 100000));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
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


@implementation CJAlertTitleLableModel

@end

@implementation CJAlertMessageLableModel

@end

@implementation CJAlertBottomButtonsModel

@end
