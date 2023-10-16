//
//  CJAlertComponentFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlertComponentFactory.h"
#import <CoreText/CoreText.h>
#import "CJBaseOverlayThemeManager.h"
#import "CJAlertButtonFactory.h"
#import "CJAlertBottomButtonsFactory.h"

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
    titleLableModel.titleLabel = titleLabel;
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
    messageTextHeight += 4;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //scrollView.backgroundColor = [UIColor redColor];
//    [self addSubview:scrollView];
//    self.messageScrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    //containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.bottom.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView.mas_width);
//        make.height.mas_equalTo(scrollView.mas_height).mas_offset(1);
        make.height.mas_equalTo(messageTextHeight);
    }];
    
    UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.numberOfLines = 0;
    //UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectZero];
    //messageLabel.editable = NO;
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = messageTextColor;
    [containerView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(containerView);
//        make.height.mas_equalTo(messageTextHeight);
        make.bottom.mas_equalTo(containerView);
    }];
    
    
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

+ (UITextField *)textFiledWithPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel.textFieldBackgroundColor;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.cornerRadius = 6;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // leftOffset
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.placeholder = placeholder;
    
    return textField;
}


///只添加一个按钮
+ (CJAlertBottomButtonsModel *)onlyOneBottomButtonWithIKnowButtonTitle:(NSString *)iKnowButtonTitle
                                                           iKnowHandle:(void(^)(UIButton *button))iKnowHandle
{
    UIView *bottomButtonView = [[UIView alloc] init];
    
    UIButton *iKnowButton = [CJAlertButtonFactory okButtonWithTitle:iKnowButtonTitle handle:iKnowHandle];
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
    horizontalLine.backgroundColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.separateLineColor;
    [bottomButtonView addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(bottomButtonView);
        make.bottom.mas_equalTo(iKnowButton.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    CGFloat actionButtonHeight = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel.actionButtonHeight;
    CJAlertBottomButtonsModel *bottomButtonsModel = [[CJAlertBottomButtonsModel alloc] init];
    bottomButtonsModel.bottomButtonView = bottomButtonView;
    bottomButtonsModel.bottomPartHeight = actionButtonHeight;
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
    //bottomButtons
    UIButton *cancelButton = [CJAlertButtonFactory cancelButtonWithTitle:cancelButtonTitle handle:cancelHandle];;
    UIButton *okButton = [CJAlertButtonFactory okButtonWithTitle:okButtonTitle handle:okHandle];
    
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    CGFloat actionButtonHeight = alertThemeModel.actionButtonHeight;
    CGFloat bottomButtonsLeftOffset = alertThemeModel.bottomButtonsLeftOffset;
    CGFloat bottomButtonsFixedSpacing = alertThemeModel.bottomButtonsFixedSpacing;
    CJAlertBottomButtonsModel *bottomButtonsModel =
        [CJAlertBottomButtonsFactory horizontalTwoButtonsWithCancelButton:cancelButton
                                                                 okButton:okButton
                                                       actionButtonHeight:actionButtonHeight
                                                  bottomButtonsLeftOffset:bottomButtonsLeftOffset
                                                             fixedSpacing:bottomButtonsFixedSpacing];
    
    BOOL isSpaceButtons = alertThemeModel.isSpaceButtons;
    if (!isSpaceButtons) {
        //bottomButtons
        UIView *bottomButtonView = bottomButtonsModel.bottomButtonView;
        
        UIColor *separateLineColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.separateLineColor;    //分割线颜色
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
    }
    
    
    return bottomButtonsModel;
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
