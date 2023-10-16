//
//  CJTextInputAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"
//#import "CJTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJTextInputAlertView : CJBaseAlertView {
    
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) CGFloat textFieldHeight;


#pragma mark - Init
- (instancetype)initWithTitle:(NSString *)title
                    inputText:(NSString *)inputText
                  placeholder:(NSString *)placeholder
            cancelButtonTitle:(NSString *)cancelButtonTitle
                okButtonTitle:(NSString *)okButtonTitle
                 cancelHandle:(void(^)(CJTextInputAlertView *bAlertView))cancelHandle
                     okHandle:(void(^)(CJTextInputAlertView *bAlertView, NSString *outputText))okHandle;

#pragma mark - Get Method
/*
*  计算textInput弹窗最后的大小
*
*  @param shouldAutoFitHeight   是否根据文本自动适应高度(宽度固定)
*
*  @return textInput弹窗最终的大小
*/
- (CGSize)alertSizeWithShouldAutoFitHeight:(BOOL)shouldAutoFitHeight;

@end

NS_ASSUME_NONNULL_END
