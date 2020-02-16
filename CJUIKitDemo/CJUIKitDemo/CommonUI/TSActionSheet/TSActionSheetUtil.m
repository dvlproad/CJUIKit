//
//  TSActionSheetUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSActionSheetUtil.h"
#import "CJActionSheetView.h"
#import "UIView+CJDemoPopupAction.h"

@implementation TSActionSheetUtil

/**
 *  弹出事项选择
 *
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组)
 *  @param itemClickBlock   点击事件
 */
+ (void)showWithSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
             itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock
{
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithSheetModels:sheetModels clickHandle:^(CJActionSheetModel *sheetModel, NSInteger selectIndex) {
        if (itemClickBlock) {
            itemClickBlock(selectIndex);
        }
    }];
    
    [self __showActionSheet:actionSheet];
}


#pragma mark - Private Method
+ (void)__showActionSheet:(CJActionSheetView *)actionSheet {
    actionSheet.commonClickAction = ^(CJActionSheetView * _Nonnull actionSheetView) {
        [actionSheetView cjdemo_hidePopupView];
    };
    [actionSheet cjdemo_popupInBottomWithHeight:actionSheet.totalHeight];
}

@end
