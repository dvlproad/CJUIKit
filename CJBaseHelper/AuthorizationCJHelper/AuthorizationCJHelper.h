//
//  AuthorizationCJHelper.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>   //UIImagePickerController需要使用

typedef NS_ENUM(NSUInteger, CJDeviceComponentType) {
    CJDeviceComponentTypeCamera,    /**< 相机 */
    CJDeviceComponentTypeAlbum,     /**< 相册 */
    CJDeviceComponentTypeLocation,  /**< 定位 */
};

@interface AuthorizationCJHelper : NSObject {
    
}

#pragma mark - C函数
/// 跳转到偏好设置页面(C函数)
UIKIT_EXTERN void openSettingCJHelper(void(^completionHandler)(BOOL success));

#pragma mark - OC方法
/**
 *  检查是否able该功能，disable的时候，如果viewController不为空，会在该viewController中弹出权限弹窗
 *
 *  @param deviceComponentType  那个弹窗是要给谁的
 *  @param viewController       在哪个视图控制器中弹那个窗(可以为nil,为nil不会不会有弹窗)
 */
+ (BOOL)checkEnableForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                         inViewController:(UIViewController *)viewController;


/// 跳转到偏好设置页面(OC方法)
+ (void)openSettingWithCompletionHandler:(void(^)(BOOL success))completionHandler;

@end
