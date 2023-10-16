//
//  CJTextInputAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJTextInputAlertView.h"

@interface CJTextInputAlertView () {
    
}

@end



@implementation CJTextInputAlertView

#pragma mark - Init
- (instancetype)initWithTitle:(NSString *)title
                    inputText:(NSString *)inputText
                  placeholder:(NSString *)placeholder
            cancelButtonTitle:(NSString *)cancelButtonTitle
                okButtonTitle:(NSString *)okButtonTitle
                 cancelHandle:(void(^)(CJTextInputAlertView *bAlertView))cancelHandle
                     okHandle:(void(^)(CJTextInputAlertView *bAlertView, NSString *outputText))okHandle
{
    self = [super init];
    if (self) {
        CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
        
        self.layer.cornerRadius = 14;
        self.backgroundColor = alertThemeModel.backgroundColor;
        self.clipsToBounds = YES;
        
        CGSize popupViewSize = CGSizeMake(alertThemeModel.alertWidth, 174);
        self.size = popupViewSize;
        
        //title
        CGFloat titleLabelLeftOffset = 20;
        [super addTitle:title margin:titleLabelLeftOffset];
        
        //textField
        [self addTextFiledWithPlaceholder:placeholder];
        
        //bottomButtons
        __weak typeof(self)weakSelf = self;
        [self addTwoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^{
            !cancelHandle ?: cancelHandle(weakSelf);
        } okHandle:^{
            NSString *outputText = weakSelf.textField.text;
            !okHandle ?: okHandle(weakSelf, outputText);
        }];
        
        self.textField.text = inputText;
        
        [self __setupConstraintsWithTitleLabelLeftOffset:titleLabelLeftOffset];
    }
    return self;
}

- (void)addTextFiledWithPlaceholder:(NSString *)placeholder {
    self.textField = [CJAlertComponentFactory textFiledWithPlaceholder:placeholder];
    /// TODO:
//    __weak typeof(self)weakSelf = self;
//    self.textField.cjTextDidChangeBlock = ^(UITextField *textField) {
//        BOOL okEnable = textField.text.length > 0;
//        weakSelf.okButton.enabled = okEnable;
//    };
    [self addSubview:self.textField];
    
    self.textFieldHeight = 43;
}


#pragma mark - Get Method
/*
*  计算textInput弹窗最后的大小
*
*  @param shouldAutoFitHeight   是否根据文本自动适应高度(宽度固定)
*
*  @return textInput弹窗最终的大小
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
- (CGFloat)__calculateAlertHeightWithShouldAutoFitHeight:(BOOL)shouldAutoFitHeight {
    // 计算最后 textFieldHeight 的值
    CGFloat minHeightWithoutTextField = [self getMinHeightExpectTextField];

    CGFloat textFieldHeight = 0;
    if (shouldAutoFitHeight) {
        textFieldHeight = self.textFieldHeight;
    } else {
        textFieldHeight = self.size.height - minHeightWithoutTextField;
    }
    
    // 使用计算出来的最后 textFieldHeight
    CGFloat fixHeight = minHeightWithoutTextField + textFieldHeight;
    
    return fixHeight;
}

///获取当前alertView最小应有的高度值
- (CGFloat)getMinHeightExpectTextField {
    CGFloat minHeightWithoutMessageLabel = self.totalMarginVertical + self.titleLabelHeight + self.bottomPartHeight;;
    minHeightWithoutMessageLabel = ceil(minHeightWithoutMessageLabel);
    
    return minHeightWithoutMessageLabel;
}


- (void)__setupConstraintsWithTitleLabelLeftOffset:(CGFloat)titleLabelLeftOffset
{
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    
    // alert 竖直上的间距:alertMarginVertical
    NSArray *alertMarginVerticals = @[@0, @0, @0, @0];
    NSInteger titleVerticalIndex = -1;
    NSInteger textFieldVerticalIndex = -1;
    NSInteger buttonsVerticalIndex = -1;
    alertMarginVerticals = alertThemeModel.marginVertical_title_textField_buttons;
    titleVerticalIndex = 0;
    textFieldVerticalIndex = 1;
    buttonsVerticalIndex = 2;
    for (NSNumber *marginVertical in alertMarginVerticals) {
        self.totalMarginVertical += [marginVertical floatValue];
    }
    
    
    CGFloat titleTextHeight = self.titleLabelHeight;
    NSNumber *titleMarginTop = alertMarginVerticals[titleVerticalIndex];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(titleLabelLeftOffset);
        make.top.mas_greaterThanOrEqualTo(self).mas_offset(titleMarginTop);//优先级
        make.height.mas_equalTo(titleTextHeight);
    }];
    
    NSNumber *textFieldMarginTop = alertMarginVerticals[textFieldVerticalIndex];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(textFieldMarginTop);
        make.height.mas_equalTo(43);
    }];
    
    
    CGFloat actionButtonHeight = 45;
    CGFloat bottomInterval = 0;
    CGFloat bottomButtonsLeftOffset = 0;
    [self.bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-bottomInterval);
        make.height.mas_equalTo(actionButtonHeight);
        make.left.mas_equalTo(self).mas_offset(bottomButtonsLeftOffset);
        make.centerX.mas_equalTo(self);
    }];
}

@end
