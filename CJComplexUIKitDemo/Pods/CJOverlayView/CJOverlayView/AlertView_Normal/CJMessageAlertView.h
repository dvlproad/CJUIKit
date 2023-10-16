//
//  CJMessageAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJMessageAlertView : CJBaseAlertView {
    
}
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, readonly) CGFloat flagImageViewHeight;

@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) CGFloat messageLabelHeight;

#pragma mark - Init
- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                    okButtonTitle:(NSString *)okButtonTitle
                         okHandle:(void(^)(CJMessageAlertView *bAlertView))okHandle;

- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(CJMessageAlertView *bAlertView))cancelHandle
                         okHandle:(void(^)(CJMessageAlertView *bAlertView))okHandle;

/// 创建调试的弹窗
+ (instancetype)debugMessageAlertViewWithTitle:(NSString *)title
                                       message:(NSString *)message
                          shouldContailAppInfo:(BOOL)shouldContailAppInfo
                           cancelCompleteBlock:(void(^)(CJMessageAlertView *bAlertView))cancelCompleteBlock
                            pasteCompleteBlock:(void(^)(CJMessageAlertView *bAlertView))pasteCompleteBlock;



#pragma mark - Get Method
/*
*  计算message弹窗最后的大小
*
*  @param shouldAutoFitHeight   是否根据文本自动适应高度(宽度固定)
*
*  @return message弹窗最终的大小
*/
- (CGSize)alertSizeWithShouldAutoFitHeight:(BOOL)shouldAutoFitHeight;


@end

NS_ASSUME_NONNULL_END
