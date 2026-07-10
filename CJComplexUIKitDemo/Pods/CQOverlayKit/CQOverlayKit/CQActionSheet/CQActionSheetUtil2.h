//
//  CQActionSheetUtil2.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  再封装（含图片选择、地图选择）的ActionSheet弹出方法（基础的方法在CQActionSheetUtil类中）

#import <Foundation/Foundation.h>
#import <CJOverlayView/CJActionSheetModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQActionSheetUtil2 : NSObject {
    
}

/**
 *  弹出图片选择
 *
 *  @param takePhotoHandle 选择"拍摄"的回调
 *  @param pickImageHandle 选择"从手机相册选择"的回调
 */
+ (void)showPickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle
                              pickImageHandle:(void(^)(void))pickImageHandle;

/*
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

@end

NS_ASSUME_NONNULL_END
