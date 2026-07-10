//
//  CQActionSheetUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQActionSheetUtil.h"
#import <CJOverlayView/CJActionSheetView.h>
#import "CQImageSheetView.h"
#import "UIView+CQPopupOverlayAction.h"

@implementation CQActionSheetUtil


#pragma mark - 常用的接口（简洁接口）
/*
 *  弹出常用的事项选择弹窗(可以下滑)
 *
 *  @param title                标题
 *  @param itemTitles           可点击的事项标题数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示，文字已固定为"取消"，若要改为"我再想想"请另取方法）
 *  @param itemClickBlock       点击事件
 */
+ (void)showNormalSheetWithTitle:(nullable NSString *)sheetTitle
                      itemTitles:(NSArray<NSString *> *)itemTitles
                      showCancel:(BOOL)showCancelSection
                  itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock
{
    CJActionSheetView *actionSheet = [CJActionSheetView normalSheetWithTitle:sheetTitle itemTitles:itemTitles showCancel:showCancelSection itemClickBlock:itemClickBlock];

    [self __showActionSheet:actionSheet shouldAddPanAction:YES];
}

/*
 *  弹出某个动作的【二次确认】弹窗
 *
 *  @param level                二次确认弹窗的级别(警告(文字颜色还是黑色，且弹窗可以下滑)、危险(文字颜色会变红色，且弹窗不能下滑))
 *  @param promptTitle          该操作的提醒标题
 *  @param cancelEventText      取消的文本(常为"取消",或"我再想想")
 *  @param operateEventText     该操作事项的文字
 *  @param operateEventBlock    该操作事项的点击回调
 */
+ (void)showSecondaryConfirmSheetWithLevel:(CQSecondaryConfirmLevel)level
                                     title:(NSString *)promptTitle
                           cancelEventText:(NSString *)cancelEventText
                          operateEventText:(NSString *)operateEventText
                         operateEventBlock:(void(^)(void))operateEventBlock
{
    CJActionSheetView *actionSheet = [CJActionSheetView confirmSheetWithTitle:promptTitle cancelEventText:cancelEventText operateEventText:operateEventText operateEventBlock:operateEventBlock];
    
    BOOL shouldAddPanAction = YES;
    if (level == CQSecondaryConfirmLevelDanger) {   // 危险(文字颜色会变红色，且弹窗不能下滑)
        shouldAddPanAction = NO;
    }
    [self __showActionSheet:actionSheet shouldAddPanAction:shouldAddPanAction];
}

/*
 *  弹出图片选择示例样图
 *
 *  @param sheetTitle               标题
 *  @param image                    图片
 *  @param imageWithHeightRatio     图片的宽高比
 *  @param clickHandle              选择"从手机相册选择"的回调
 */
+ (void)showImageSheetWithTitle:(NSString *)sheetTitle
                          image:(UIImage *)image
           imageWithHeightRatio:(CGFloat)imageWithHeightRatio
                    clickHandle:(void(^)(void))clickHandle
{
    CQImageSheetView *sheetView = [[CQImageSheetView alloc] initWithTitle:sheetTitle image:image imageWithHeightRatio:imageWithHeightRatio clickHandle:^(CQImageSheetView * _Nonnull bSheetView) {
        [bSheetView cqOverlay_actionSheet_hide];
        
        !clickHandle ?: clickHandle();
    }];
    
    [sheetView cqOverlay_actionSheet_showWithHeight:sheetView.totalHeight shouldAddPanAction:YES];
}


#pragma mark - 完整的基本接口（请优先考虑上述的常用接口）
/*
 *  弹出事项选择
 *
 *  @param title                标题
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示，文字已固定为"取消"，若要改为"我再想想"请另取方法）
 *  @param shouldAddPanAction   是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 *  @param itemClickBlock       点击事件
 */
+ (void)showWithSheetTitle:(nullable NSString *)sheetTitle
               sheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
                showCancel:(BOOL)showCancelSection
        shouldAddPanAction:(BOOL)shouldAddPanAction
            itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock
{
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithTitle:sheetTitle sheetModels:sheetModels showCancel:showCancelSection clickHandle:^(CJActionSheetModel *sheetModel, NSInteger selectIndex) {
        if (itemClickBlock) {
            itemClickBlock(selectIndex);
        }
    }];
    actionSheet.cancelText = @"取消"; // 标题常为"取消"或"我再想想"
    
    [self __showActionSheet:actionSheet shouldAddPanAction:shouldAddPanAction];
}


#pragma mark - Private Method
+ (void)__showActionSheet:(CJActionSheetView *)actionSheet shouldAddPanAction:(BOOL)shouldAddPanAction {
    actionSheet.commonClickAction = ^(CJActionSheetView * _Nonnull actionSheetView) {
        [actionSheetView cqOverlay_actionSheet_hide];
    };
    [actionSheet cqOverlay_actionSheet_showWithHeight:actionSheet.totalHeight shouldAddPanAction:shouldAddPanAction];
}

@end
