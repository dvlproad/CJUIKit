//
//  CJValidateAuthorizationUtil.m
//  CJPickerDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import "CJValidateAuthorizationUtil.h"

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

@interface CJValidateAuthorizationUtil ()

@end

@implementation CJValidateAuthorizationUtil

/* 完整的描述请参见文件头部 */
+ (BOOL)checkEnableForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                         inViewController:(UIViewController *)viewController
{
    if (deviceComponentType == CJDeviceComponentTypeCamera) {
        if (![CJValidateAuthorizationUtil checkDeviceSupportCamera]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:YES inViewController:viewController];
            return NO;
        }
        
        if (![CJValidateAuthorizationUtil checkUserAuthorizationStatusForCamera]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:NO inViewController:viewController];
            return NO;
        }
        
    } else if (deviceComponentType == CJDeviceComponentTypeAlbum) {
        if (![CJValidateAuthorizationUtil checkUserAuthorizationStatusForAlbum]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:NO inViewController:viewController];
            return NO;
        }
        
    } else if (deviceComponentType == CJDeviceComponentTypeLocation) {
        if (![CJValidateAuthorizationUtil checkDeviceSupportLocation]) {
            [self showAlertForDeviceComponentType:deviceComponentType andIsForWholeDevice:YES inViewController:viewController];
            return NO;
        }
        
        if (![CJValidateAuthorizationUtil checkUserAuthorizationStatusForLocation]) {
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
 *  没有权限，弹出权限弹窗
 *
 *  @param deviceComponentType  这个弹窗是要给谁的
 *  @param isForWholeDevice     这个弹窗是否是针对整个设备权限
 *  @param viewController       在哪个视图控制器中弹窗
 */
+ (void)showAlertForDeviceComponentType:(CJDeviceComponentType)deviceComponentType
                    andIsForWholeDevice:(BOOL)isForWholeDevice
                                   inViewController:(UIViewController *)viewController
{
    NSString *title = @"";
    NSString *message = @"";
    if (deviceComponentType == CJDeviceComponentTypeAlbum) {
        title = @"无法访问相册";
        message = @"请在设备的\"设置-隐私-照片\"中允许访问照片。";
    } else if (deviceComponentType == CJDeviceComponentTypeCamera) {
        title = @"无法拍照";
        message = @"请在“设置-隐私-相机”选项中允许应用访问你的相机";
    } else if (deviceComponentType == CJDeviceComponentTypeLocation) {
        title = @"无法定位";
        message = @"请在“设置-隐私-定位服务”选项中允许应用访问你的位置";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //无权限 引导去开启
        if (isForWholeDevice) {
            [self openJurisdictionForWholeDevice:deviceComponentType];
            
        } else {
            if (deviceComponentType == CJDeviceComponentTypeAlbum) {
                [self openJurisdictionForApp];
            } else if (deviceComponentType == CJDeviceComponentTypeCamera) {
                [self openJurisdictionForApp];
            } else if (deviceComponentType == CJDeviceComponentTypeLocation) {
                [self openJurisdictionForApp];
            }
        }
        
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

///跳转到"app的各个设置"页面，去设置权限
+ (void)openJurisdictionForApp {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

///跳转到"整个设备的对应隐私设置"页面
+ (void)openJurisdictionForWholeDevice:(CJDeviceComponentType)deviceComponentType {
//    NSURL *URL = nil;
//    if (deviceComponentType == CJDeviceComponentTypeLocation) {
//        URL = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//    }
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
            [[UIApplication sharedApplication] openURL:URL];
        } else {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        }
    }
}

@end

