//
//  CJAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

/*
@class CJAlertView;
@protocol CJAlertViewDelegate <NSObject>

@optional
- (void)cjAlertView_OK:(CJAlertView *)alertView;
- (void)cjAlertView_Cancel:(CJAlertView *)alertView;

@end
*/

/**
 *  仿系统 UIAlertView
 */
@interface CJAlertView : UIView {
    
}
+ (instancetype)alertViewWithSize:(CGSize)size
                        flagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;


- (instancetype)initWithSize:(CGSize)size;

///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize;

///添加title
- (void)addTitleWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset;

///添加message的方法①
- (void)addMessageTextWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset;

///添加message的方法②(常用于处理message多行需要设置行距的时候)
- (void)addMessageAttributedTextWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

///添加 message 的边框等(几乎不会用到)
- (void)addMessageLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat)cornerRadius;

///添加底部按钮
- (void)addBottomButtonWithHeight:(CGFloat)actionButtonHeight
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;

///显示 alert（如系统 UIAlertView）
- (void)show;

@end
