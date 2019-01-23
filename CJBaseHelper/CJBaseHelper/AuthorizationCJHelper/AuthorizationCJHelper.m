//
//  AuthorizationCJHelper.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import "AuthorizationCJHelper.h"

/*
 Authorized:   //已授权，可使用
 NotDetermined://未进行授权选择:系统还未知是否访问，第一次开启时
 Restricted:   //未授权，且用户无法更新，如家长控制情况下
 Denied:       //用户拒绝App使用
 //*/
//相册权限判断
#import <Photos/Photos.h>               //(iOS8之后)

//相机权限判断
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>



//定位权限判断
#import <CoreLocation/CoreLocation.h>

@interface AuthorizationCJHelper ()

@end

@implementation AuthorizationCJHelper

/* 完整的描述请参见文件头部 */
+ (BOOL)checkEnableForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                         inViewController:(UIViewController *)viewController
{
    if (deviceComponentType == CJDeviceComponentTypeCamera) {
        if (![AuthorizationCJHelper checkDeviceSupportCamera]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:YES inViewController:viewController];
            return NO;
        }
        
        if (![AuthorizationCJHelper checkUserAuthorizationStatusForCamera]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:NO inViewController:viewController];
            return NO;
        }
        
    } else if (deviceComponentType == CJDeviceComponentTypeAlbum) {
        if (![AuthorizationCJHelper checkUserAuthorizationStatusForAlbum]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:NO inViewController:viewController];
            return NO;
        }
        
    } else if (deviceComponentType == CJDeviceComponentTypeLocation) {
        if (![AuthorizationCJHelper checkDeviceSupportLocation]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:YES inViewController:viewController];
            return NO;
        }
        
        if (![AuthorizationCJHelper checkUserAuthorizationStatusForLocation]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:NO inViewController:viewController];
            return NO;
        }
        
    } else {
        
    }
    
    
    return YES;
}

#pragma mark - 1、设备支持判断
/**
 *  设备支持校验之是否支持“拍照”
 *
 *  return 是否支持
 */
+ (BOOL)checkDeviceSupportCamera {
    BOOL isSupportCamera = NO;
#if TARGET_IPHONE_SIMULATOR
    isSupportCamera = NO;
#else
    isSupportCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
#endif
    
    return isSupportCamera;
}

/**
 *  设备支持校验之是否支持“定位”
 *
 *  return 是否支持
 */
+ (BOOL)checkDeviceSupportLocation {
    //判断定位是否开启是判断的整个手机系统的定位是否打开,并不是针对这一应用
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    return locationServicesEnabled;
}


#pragma mark - 2、用户授权判断 AuthorizationStatus
/**
 *  检查授权之"相册PhotoLibrary"
 *  @brief: 在info.plist里面设置NSPhotoLibraryUsageDescription
 *                            Privacy - Photo Library Usage Description App需要您的同意,才能访问相册
 *
 *  return 是否授权
 */
+ (BOOL)checkUserAuthorizationStatusForAlbum {
    BOOL isAuthorization = NO;
    
    //iOS 8 之后推荐用 #import <Photos/Photos.h> 中的判断
     PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
     if (authStatus == PHAuthorizationStatusRestricted ||
         authStatus == PHAuthorizationStatusDenied) {
         isAuthorization = NO;
     } else {
         isAuthorization = YES;
     }
         

    return isAuthorization;
}


/**
 *  检查授权之"相机Camera"
 *  @brief: 在info.plist里面设置NSCameraUsageDescription
 *                            Privacy - Camera Usage Description      App需要您的同意,才能访问相机
 *
 *  return 是否授权
 */
+ (BOOL)checkUserAuthorizationStatusForCamera {
    BOOL isAuthorization = NO;
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus == AVAuthorizationStatusDenied) {
        isAuthorization = NO;
    } else {
        isAuthorization = YES;
    }
    
    return isAuthorization;
}

/**
 *  检查授权之"定位Location"
 *  @brief: 在info.plist里面设置NSLocationWhenInUseUsageDescription
 *                            Privacy - Location When In Use Usage Description  App需要使用定位功能
 *                            NSLocationAlwaysUsageDescription
 *                            Privacy - Location Always Usage Description     App需要使用定位功能
 *
 *  return 是否授权
 */
+ (BOOL)checkUserAuthorizationStatusForLocation {
    BOOL isAuthorization = NO;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusDenied) {
        isAuthorization = NO;
    } else {
        isAuthorization = YES;
    }
    
    return isAuthorization;
}


#pragma mark - 不支持/无权限问题
/**
 *  权限信息的显示或权限弹窗(如果viewController不为空，会在该viewController中弹出权限弹窗)
 *
 *  @param deviceComponentType  这个弹窗是要给谁的
 *  @param isForWholeDevice     这个弹窗是否是针对整个设备权限
 *  @param viewController       在哪个视图控制器中弹窗(可以为nil,为nil不会不会有弹窗)
 */
+ (void)showAlertForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                    andIsForWholeDevice:(BOOL)isForWholeDevice
                       inViewController:(UIViewController *)viewController
{
    NSString *title = @"";
    NSString *message = @"";
    if (deviceComponentType == CJDeviceComponentTypeAlbum) {
        title = NSLocalizedString(@"无法访问相册", nil);
        message = NSLocalizedString(@"请在设备的\"设置-隐私-照片\"中允许访问照片。", nil);
    } else if (deviceComponentType == CJDeviceComponentTypeCamera) {
        title = NSLocalizedString(@"无法拍照", nil);
        message = NSLocalizedString(@"请在“设置-隐私-相机”选项中允许应用访问你的相机", nil);
    } else if (deviceComponentType == CJDeviceComponentTypeLocation) {
        title = NSLocalizedString(@"无法定位", nil);
        message = NSLocalizedString(@"请在“设置-隐私-定位服务”选项中允许应用访问你的位置", nil);
    }
    
    if (viewController == nil) {
        NSLog(@"功能权限信息提示:\n%@\n%@", title, message);
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //无权限 引导去开启
        openSettingCJHelper(nil);
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

/// 跳转到偏好设置页面(C函数)
void openSettingCJHelper(void(^completionHandler)(BOOL success)) {
    [AuthorizationCJHelper openSettingWithCompletionHandler:completionHandler];
}

/// 跳转到偏好设置页面(OC方法)
+ (void)openSettingWithCompletionHandler:(void(^)(BOOL success))completionHandler {
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
            BOOL openSuccess = [[UIApplication sharedApplication] openURL:URL];
            if (completionHandler) {
                completionHandler(openSuccess);
            }
            
        } else {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:completionHandler];
        }
    } else {
        if (completionHandler) {
            completionHandler(NO);
        }
    }
}


@end

