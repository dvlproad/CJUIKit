//
//  CJTextInputAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"
#import "CJTextField.h"

@interface CJTextInputAlertView : CJBaseAlertView {
    
}
@property (nonatomic, strong) CJTextField *textField;
@property (nonatomic, assign) CGFloat textFieldHeight;

- (instancetype)initWithTitle:(NSString *)title
                    inputText:(NSString *)inputText
                  placeholder:(NSString *)placeholder
            cancelButtonTitle:(NSString *)cancelButtonTitle
                okButtonTitle:(NSString *)okButtonTitle
                 cancelHandle:(void(^)(void))cancelHandle
                     okHandle:(void(^)(NSString *outputText))okHandle;

- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight blankBGColor:(UIColor *)blankBGColor;

@end
