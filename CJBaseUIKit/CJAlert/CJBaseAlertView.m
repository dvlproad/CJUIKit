//
//  CJBaseAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"

#import <CoreText/CoreText.h>
#import "CJThemeManager.h"

@interface CJBaseAlertView () {
    
}
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




/////获取当前alertView最小应有的高度值
//- (CGFloat)getMinHeight {
//    CGFloat minHeightWithMessageLabel = self.size.height;
//    
//    return minHeightWithMessageLabel;
//}
//
//
///* 完整的描述请参见文件头部 */
//- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight blankBGColor:(UIColor *)blankBGColor
//{
//    CGFloat fixHeight = 0;
//    if (shouldFitHeight) {
//        CGFloat minHeight = [self getMinHeight];
//        fixHeight = minHeight;
//    } else {
//        fixHeight = self.size.height;
//    }
//
//    [self showWithFixHeight:fixHeight blankBGColor:blankBGColor];
//}

/**
 *  显示弹窗并且是以指定高度显示的
 *
 *  @param fixHeight        高度
 *  @param blankBGColor     空白区域的背景颜色
 */
- (void)showWithFixHeight:(CGFloat)fixHeight blankBGColor:(UIColor *)blankBGColor {
//    CGFloat minHeight = [self getMinHeight];
//    if (fixHeight < minHeight) {
//        NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度小于视图本身的最小高度%.2lf，会导致视图显示不全，请检查", minHeight];
//        NSLog(@"%@", warningString);
//    }
//
//    CGFloat maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 60;
//    if (fixHeight > maxHeight) {
//        fixHeight = maxHeight;
//
//        //NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度超过视图本身的最大高度%.2lf，会导致视图显示不全，已自动缩小", maxHeight];
//        //NSLog(@"%@", warningString);
//        if (self.messageScrollView) {
//            CGFloat minHeightWithoutMessageLabel = _firstVerticalInterval + _flagImageViewHeight + _secondVerticalInterval + _titleLabelHeight + _thirdVerticalInterval + _bottomMinVerticalInterval + _bottomPartHeight;
//
//            _messageLabelHeight = fixHeight - minHeightWithoutMessageLabel;
//            [self.messageScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(self->_messageLabelHeight);
//            }];
//        }
//
//    }
//
//    CGSize popupViewSize = CGSizeMake(self.size.width, fixHeight);
//    [self showPopupViewSize:popupViewSize];
}

- (void)showPopupViewSize:(CGSize)popupViewSize blankBGColor:(UIColor *)blankBGColor {
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



@end
