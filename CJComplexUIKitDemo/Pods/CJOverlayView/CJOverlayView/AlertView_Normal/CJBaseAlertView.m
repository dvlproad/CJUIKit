//
//  CJBaseAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"

#import <CoreText/CoreText.h>

@interface CJBaseAlertView () {
    
}
@property (nonatomic, copy) void(^cancelHandle)(void);
@property (nonatomic, copy) void(^okHandle)(void);

@end




@implementation CJBaseAlertView

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
    self.titleLabel.textColor = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel.textMainColor;
}


#pragma mark - 完整的添加方法
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
        UILabel *titleLabel = titleLableModel.titleLabel;
        [self addSubview:titleLabel];
        
        _titleLabel = titleLabel;
        _titleLabelHeight = titleLableModel.titleTextHeight;
    }
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
    //__weak typeof(self)weakSelf = self;
    CJAlertBottomButtonsModel *bottomButtonsModel = [CJAlertComponentFactory onlyOneBottomButtonWithIKnowButtonTitle:okButtonTitle iKnowHandle:^(UIButton *button) {
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
    //__weak typeof(self)weakSelf = self;
    CJAlertBottomButtonsModel *bottomButtonsModel = [CJAlertComponentFactory twoButtonsWithCancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^(UIButton *button) {
        if (cancelHandle) {
            cancelHandle();
        }
    } okHandle:^(UIButton *button) {
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
    
    
    _cancelHandle = cancelHandle;
    _okHandle = okHandle;
    
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

- (void)cancelButtonAction:(UIButton *)button {
    if (self.cancelHandle) {
        self.cancelHandle();
    }
}

- (void)okButtonAction:(UIButton *)button {
    if (self.okHandle) {
        self.okHandle();
    }
}



@end
