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

#import "CJBaseOverlayThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

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

/**
 *  添加标题
 *
 *  @param title    标题
 *  @param titleLabelLeftOffset    titleLabelLeftOffset
 */
- (void)addTitle:(NSString *)title margin:(CGFloat)titleLabelLeftOffset;

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


@end

NS_ASSUME_NONNULL_END
