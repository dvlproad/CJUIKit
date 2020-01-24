//
//  CJBaseAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "CJAlertComponentFactory.h"
#import "CJThemeManager.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "UIView+CJPopupInView.h"
#import "UIColor+CJHex.h"
#import "CJTextField.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseUIKit/CJTextField.h>
#endif

/*
@class CJBaseAlertView;
@protocol CJAlertViewDelegate <NSObject>

@optional
- (void)cjAlertView_OK:(CJBaseAlertView *)alertView;
- (void)cjAlertView_Cancel:(CJBaseAlertView *)alertView;

@end
*/

/**
 *  仿系统 UIAlertView(使用类方法只能创建默认样式的alertView,若要创建更加自定义的alertView,请使用实例方法)
 */
@interface CJBaseAlertView : UIView {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, readonly) CGFloat titleLabelHeight;


@property (nonatomic, strong) UIView *bottomButtonView;
//@property (nonatomic, strong, readonly) NSArray<UIButton *> *bottomButtons;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, assign) CGFloat bottomPartHeight;  /**< 底部区域高度(包含底部按钮及可能的按钮上部的分隔线及按钮下部与边缘的距离) */

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat totalMarginVertical;

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
 *  添加标题
 *
 *  @param title    标题
 *  @param titleLabelLeftOffset    titleLabelLeftOffset
 */
- (void)addTitle:(NSString *)title margin:(CGFloat)titleLabelLeftOffset;

///添加title(paragraphStyle:当需要设置title行距、缩进等的时候才需要设置，其他设为nil即可)
- (void)addTitleWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

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
                                  okHandle:(void(^)(void))okHandle;

/**
*  添加 "OK" 的 组合按钮
*
*  @param okButtonTitle        确认文案
*  @param okHandle             确认时间
*/
- (void)addOnlyOneBottomButtonWithOKButtonTitle:(NSString *)okButtonTitle
                                       okHandle:(void(^)(void))okHandle;

/**
 *  添加底部按钮方法②：按默认布局(横排，1至2个)
 *
 *  @param actionButtonHeight   按钮高度
 *  @param cancelButtonTitle    取消按钮的文本
 *  @param okButtonTitle        确认按钮的文本
 *  @param cancelHandle         取消按钮的事件
 *  @param okHandle             确认按钮的事件
 */
- (void)addBottomButtonWithHeight:(CGFloat)actionButtonHeight
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;

///更改 Title 文字颜色
- (void)updateTitleTextColor:(UIColor *)textColor;


///更改底部 Cancel 按钮的文字颜色
- (void)updateCancelButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

///更改底部 OK 按钮的文字颜色
- (void)updateOKButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

///**
// *  显示 alert 弹窗
// *
// *  @param shouldFitHeight  是否需要自动适应高度(否:会以之前指定的size的height来显示)
// *  @param blankBGColor     空白区域的背景颜色
// */
//- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight
//       blankBGColor:(UIColor *)blankBGColor;


- (void)showPopupViewSize:(CGSize)popupViewSize;

/**
 *  隐藏 alert
 *
 *  @param delay        延迟多少秒后隐藏
 */
- (void)dismissWithDelay:(CGFloat)delay;


@end
