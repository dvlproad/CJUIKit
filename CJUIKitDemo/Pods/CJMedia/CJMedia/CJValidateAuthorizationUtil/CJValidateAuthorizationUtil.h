//
//  CJValidateAuthorizationUtil.h
//  CJPickerDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>   //UIImagePickerController需要使用

// [iOS判断是否有权限访问相机，相册，定位](http://blog.csdn.net/u013127850/article/details/52160911)
typedef NS_ENUM(NSUInteger, CJDeviceComponentType) {
    CJDeviceComponentTypeCamera,    /**< 相机 */
    CJDeviceComponentTypeAlbum,     /**< 相册 */
    CJDeviceComponentTypeLocation,  /**< 定位 */
};

@interface CJValidateAuthorizationUtil : NSObject {
    
}

/**
 *  检查是否able该功能，disable的时候会弹出权限弹窗
 *
 *  @param deviceComponentType  那个弹窗是要给谁的
 *  @param viewController       在哪个视图控制器中弹那个窗
 */
+ (BOOL)checkEnableForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                         inViewController:(UIViewController *)viewController;

@end
