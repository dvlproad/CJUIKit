//
//  CQActionSheetUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQActionSheetUtil.h"
#import "CJActionSheetFactory.h"
#import "UIView+CJDemoPopupAction.h"


@implementation CQActionSheetUtil

/**
 *  弹出事项选择
 *
 *  @param itemTitles       可点击的事项标题数组
 *  @param itemClickBlock   点击事件
 */
+ (void)showWithItemTitles:(NSArray<NSString *> *)itemTitles
            itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock
{
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < itemTitles.count; i++) {
        CJActionSheetModel *sheetModel = [[CJActionSheetModel alloc] init];
        sheetModel.title = itemTitles[i];
        [sheetModels addObject:sheetModel];
    }
    
    [self showWithSheetModels:sheetModels itemClickBlock:itemClickBlock];
}

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

/**
 *  弹出图片选择
 *
 *  @param takePhotoHandle 选择"拍摄"的回调
 *  @param pickImageHandle 选择"从手机相册选择"的回调
 */
+ (void)showPickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle
                              pickImageHandle:(void(^)(void))pickImageHandle
{
    CJActionSheetView *actionSheet = [CJActionSheetFactory pickImageSheetWithTakePhotoHandle:takePhotoHandle pickImageHandle:pickImageHandle];
    
    [self __showActionSheet:actionSheet];
}


/**
 *  弹出地图选择
 *
 *  @param updateDefaultNavigationMap   是否在选择结束后更新默认的导航地图软件
 *  @param baiduMapBlock                选择"百度地图"
 *  @param amapBlock                    选择"高德地图"
 *  @param appleMapBlock                选择"苹果地图"
 */
+ (void)showMapsActionSheetWithUpdateMap:(BOOL)updateDefaultNavigationMap
                           baiduMapBlock:(void (^ __nullable)(BOOL canOpenBaiduMap))baiduMapBlock
                               amapBlock:(void (^ __nullable)(BOOL canOpenAmap))amapBlock
                           appleMapBlock:(void (^ __nullable)(void))appleMapBlock
{
    CJActionSheetView *actionSheet = [CJActionSheetFactory mapsActionSheetWithUpdateMap:updateDefaultNavigationMap baiduMapBlock:baiduMapBlock amapBlock:amapBlock appleMapBlock:appleMapBlock];
    
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
