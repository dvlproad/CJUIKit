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

- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize;
- (void)addTitle:(NSString *)title font:(UIFont *)titleLabelFont textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset;
- (void)addMessage:(NSString *)message font:(UIFont *)messageLabelFont textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset;
- (void)addBottomButtonWithHeight:(CGFloat)actionButtonHeight
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;

///对 messageLabel 添加 border
- (void)addMessageLabelBoderWithWidth:(CGFloat)borderWidth;

///显示 alert（如系统 UIAlertView）
- (void)show;

@end
