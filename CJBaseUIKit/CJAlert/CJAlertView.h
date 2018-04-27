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
 *  仿系统 UIAlertView(使用类方法只能创建默认样式的alertView,若要创建更加自定义的alertView,请使用实例方法)
 */
@interface CJAlertView : UIView {
    
}

///创建alertView(使用类方法只能创建默认样式的alertView,若要创建更加自定义的alertView,请使用实例方法)
+ (instancetype)alertViewWithSize:(CGSize)size
                        flagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;


/**
 *  创建alertView
 *  @brief  这里所说的三个视图范围为：flagImageView(有的话，一定是第一个)、titleLabel(有的话，有可能一或二)、messageLabel(有的话，有可能一或二或三)
 *
 *  @param size                     alertView的大小
 *  @param firstVerticalInterval    第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
 *  @param secondVerticalInterval   第二个视图与第一个视图的间隔(如果少于两个视图，这个值设为0即可)
 *  @param thirdVerticalInterval    第三个视图与第二个视图的间隔(如果少于三个视图，这个值设为0即可)
 *
 *  @return alertView
 */
- (instancetype)initWithSize:(CGSize)size
       firstVerticalInterval:(CGFloat)firstVerticalInterval
      secondVerticalInterval:(CGFloat)secondVerticalInterval
       thirdVerticalInterval:(CGFloat)thirdVerticalInterval;

///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize;

///添加title
- (void)addTitleWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset;

///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
- (void)addMessageWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

///添加 message 的边框等(几乎不会用到)
- (void)addMessageLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat)cornerRadius;

///添加底部按钮
- (void)addBottomButtonWithHeight:(CGFloat)actionButtonHeight
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;

///更改 Title 文字颜色
- (void)updateTitleTextColor:(UIColor *)textColor;

///更改 Message 文字颜色
- (void)updateMessageTextColor:(UIColor *)textColor;

///更改底部 Cancel 按钮的文字颜色
- (void)updateCancelButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

///更改底部 OK 按钮的文字颜色
- (void)updateOKButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

///显示 alert（如系统 UIAlertView）
- (void)show;

@end
