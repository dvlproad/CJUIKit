//
//  CJActionSheetFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJActionSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetFactory : NSObject {
    
}

/**
 *  图片选择
 *
 *  @param takePhotoHandle 选择"拍摄"的回调
 *  @param pickImageHandle 选择"从手机相册选择"的回调
 */
+ (CJActionSheetView *)pickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle
                                         pickImageHandle:(void(^)(void))pickImageHandle;

/**
 *  地图选择
 *
 *  @param updateDefaultNavigationMap   是否在选择结束后更新默认的导航地图软件
 *  @param baiduMapBlock                选择"百度地图"
 *  @param amapBlock                    选择"高德地图"
 *  @param appleMapBlock                选择"苹果地图"
 */
+ (CJActionSheetView *)mapsActionSheetWithUpdateMap:(BOOL)updateDefaultNavigationMap
                                      baiduMapBlock:(void (^ __nullable)(BOOL canOpenBaiduMap))baiduMapBlock
                                          amapBlock:(void (^ __nullable)(BOOL canOpenAmap))amapBlock
                                      appleMapBlock:(void (^ __nullable)(void))appleMapBlock;

@end

NS_ASSUME_NONNULL_END
