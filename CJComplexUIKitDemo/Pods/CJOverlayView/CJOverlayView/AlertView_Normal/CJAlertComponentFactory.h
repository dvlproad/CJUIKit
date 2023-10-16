//
//  CJAlertComponentFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
//#import "CJTextField.h"
#import "CJAlertBottomButtonsModel.h"
@class CJAlertTitleLableModel, CJAlertMessageLableModel;

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertComponentFactory : NSObject {
    
}

///添加指示图标
+ (UIImageView *)flagImage:(UIImage *)flagImage;

///添加title
+ (CJAlertTitleLableModel *)titleLabelWithText:(NSString *)text
                           font:(UIFont *)font
                  textAlignment:(NSTextAlignment)textAlignment
             titleLabelMaxWidth:(CGFloat)titleLabelMaxWidth
                 paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
+ (CJAlertMessageLableModel *)messageLabelWithText:(NSString *)text
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
             messageLabelMaxWidth:(CGFloat)messageLabelMaxWidth
                   paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

+ (UITextField *)textFiledWithPlaceholder:(NSString *)placeholder;

+ (CJAlertBottomButtonsModel *)onlyOneBottomButtonWithIKnowButtonTitle:(NSString *)iKnowButtonTitle
                                                           iKnowHandle:(void(^)(UIButton *button))iKnowHandle;

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
                                                      okHandle:(void(^)(UIButton *button))okHandle;


@end


@interface CJAlertTitleLableModel : NSObject {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat titleTextHeight;

@end



@interface CJAlertMessageLableModel : NSObject {
    
}
@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) CGFloat messageTextHeight;

@end

NS_ASSUME_NONNULL_END
