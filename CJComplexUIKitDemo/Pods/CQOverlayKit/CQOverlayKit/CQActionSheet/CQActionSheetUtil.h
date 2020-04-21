//
//  CQActionSheetUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJBaseOverlayKit/CJActionSheetModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQActionSheetUtil : NSObject {
    
}

#pragma mark - 常用的接口（简洁接口）
/**
 *  弹出事项选择
 *
 *  @param itemTitles       可点击的事项标题数组
 *  @param itemClickBlock   点击事件
 */
+ (void)showWithItemTitles:(NSArray<NSString *> *)itemTitles
            itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock;

/**
 *  弹出图片选择
 *
 *  @param takePhotoHandle 选择"拍摄"的回调
 *  @param pickImageHandle 选择"从手机相册选择"的回调
 */
+ (void)showPickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle
                              pickImageHandle:(void(^)(void))pickImageHandle;

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
                           appleMapBlock:(void (^ __nullable)(void))appleMapBlock;




#pragma mark - 完整的基本接口（请优先考虑上述的常用接口）
/**
 *  弹出事项选择
 *
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组)
 *  @param itemClickBlock   点击事件
 */
+ (void)showWithSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
             itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock;

@end

NS_ASSUME_NONNULL_END
