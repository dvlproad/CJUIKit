//
//  CJAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIView+CJPopupInView.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#endif

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
 *  @param secondVerticalInterval   第二个视图与第一个视图的间隔(如果少于两个视图,这个值设为0即可)
 *  @param thirdVerticalInterval    第三个视图与第二个视图的间隔(如果少于三个视图,这个值设为0即可)
 *  @param bottomMinVerticalInterval 底部buttons区域视图与其上面的视图的最小间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
 *
 *  @return alertView
 */
- (instancetype)initWithSize:(CGSize)size
       firstVerticalInterval:(CGFloat)firstVerticalInterval
      secondVerticalInterval:(CGFloat)secondVerticalInterval
       thirdVerticalInterval:(CGFloat)thirdVerticalInterval
   bottomMinVerticalInterval:(CGFloat)bottomMinVerticalInterval;

///添加指示图标
- (void)addFlagImage:(UIImage *)flagImage size:(CGSize)imageViewSize;

///添加title(paragraphStyle:当需要设置title行距、缩进等的时候才需要设置，其他设为nil即可)
- (void)addTitleWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)titleLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
- (void)addMessageWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment margin:(CGFloat)messageLabelLeftOffset paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

///添加 message 的边框等(几乎不会用到)
- (void)addMessageLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat)cornerRadius;

///添加底部按钮
/**
 *  添加底部按钮方法①：按指定布局添加底部按钮
 *
 *  @param bottomButtons        要添加的按钮组合(得在外部额外实现点击后的关闭alert操作)
 *  @param actionButtonHeight   按钮高度
 *  @param bottomInterval       按钮与底部的距离
 *  @param axisType             横排还是竖排
 *  @param fixedSpacing         两个控件间隔
 *  @param leadSpacing          第一个控件与边缘的间隔
 *  @param tailSpacing          最后一个控件与边缘的间隔
 */
- (void)addBottomButtons:(NSArray<UIButton *> *)bottomButtons
              withHeight:(CGFloat)actionButtonHeight
          bottomInterval:(CGFloat)bottomInterval
               alongAxis:(MASAxisType)axisType
            fixedSpacing:(CGFloat)fixedSpacing
             leadSpacing:(CGFloat)leadSpacing
             tailSpacing:(CGFloat)tailSpacing;

///只添加一个按钮
- (void)addOnlyOneBottomButton:(UIButton *)bottomButton
                    withHeight:(CGFloat)actionButtonHeight
                bottomInterval:(CGFloat)bottomInterval
                    leftOffset:(CGFloat)leftOffset
                   rightOffset:(CGFloat)rightOffset;

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

///更改 Message 文字颜色
- (void)updateMessageTextColor:(UIColor *)textColor;

///更改底部 Cancel 按钮的文字颜色
- (void)updateCancelButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

///更改底部 OK 按钮的文字颜色
- (void)updateOKButtonNormalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

/**
 *  显示 alert 弹窗
 *
 *  @param shouldFitHeight  是否需要自动适应高度(否:会以之前指定的size的height来显示)
 *  @param blankBGColor     空白区域的背景颜色
 */
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight
       blankBGColor:(UIColor *)blankBGColor;

/**
 *  隐藏 alert
 *
 *  @param delay        延迟多少秒后隐藏
 */
- (void)dismissWithDelay:(CGFloat)delay;


@end
