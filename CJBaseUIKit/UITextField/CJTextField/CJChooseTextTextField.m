//
//  CJChooseTextTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJChooseTextTextField.h"

@interface CJChooseTextTextField ()

///FIXME:需要完善未设置pickerView的时候，第三方可能会自动补充键盘的ToolBar
@property (nonatomic, assign) BOOL textOnlyFromSelected;          /**< 是否隐藏光标(默认NO),隐藏光标的时候最好同时禁止手动输入 */

@end


@implementation CJChooseTextTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

/* 完整的描述请参见文件头部 */
- (void)setTextOnlyFromPickerView:(UIView *)pickerView {
    self.inputView = pickerView;
    
    self.textOnlyFromSelected = YES;
}

- (void)setTextOnlyFromSelected:(BOOL)textOnlyFromSelected {
    _textOnlyFromSelected = textOnlyFromSelected;
    
    if (textOnlyFromSelected) {
        self.tintColor = [UIColor clearColor];
    } else {
        self.tintColor = [UIColor blackColor];
    }
}



//通过实现UIResponse的- (BOOL)canPerformAction: withSender:方法来去除双击时的弹出框
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.textOnlyFromSelected == NO) {
        return [super canPerformAction:action withSender:sender];
    }
    
    
    if (self.hideMenuController) {
        if ([UIMenuController sharedMenuController]) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
        
    } else {
        if (action == @selector(select:) ||
            action == @selector(selectAll:) ||
            action == @selector(paste:))
        {
            return YES;
        }
        return NO;
    }
}


@end
