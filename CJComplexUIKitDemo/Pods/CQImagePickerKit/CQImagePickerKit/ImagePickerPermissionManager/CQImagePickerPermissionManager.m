//
//  CQImagePickerPermissionManager.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQImagePickerPermissionManager.h"
#import <AVFoundation/AVFoundation.h>

/*
 Authorized:   //已授权，可使用
 NotDetermined://未进行授权选择:系统还未知是否访问，第一次开启时
 Restricted:   //未授权，且用户无法更新，如家长控制情况下
 Denied:       //用户拒绝App使用
 //*/
//相册权限判断
#import <Photos/Photos.h>               //(iOS8之后)

@interface CQImagePickerPermissionManager () {
    
}

@end


@implementation CQImagePickerPermissionManager


/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CQImagePickerPermissionManager *)sharedInstance {
    static CQImagePickerPermissionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


#pragma mark - 相册权限检查

/*
*  检查是否具备访问相册权限
*
*  @return 权限判断
*/
- (BOOL *)checkEnableForAlbum {
    BOOL permissionEnable = [self __checkUserAuthorizationStatusForAlbum];
    return permissionEnable;
}

/**
 *  用户授权判断 AuthorizationStatus：检查授权之"相册PhotoLibrary"
 *  @brief: 在info.plist里面设置NSPhotoLibraryUsageDescription
 *                            Privacy - Photo Library Usage Description App需要您的同意,才能访问相册
 *
 *  return 是否授权
 */
- (BOOL *)__checkUserAuthorizationStatusForAlbum {
    BOOL isAuthorization = NO;
    NSString *title;
    NSString *message;
    
    //iOS 8 之后推荐用 #import <Photos/Photos.h> 中的判断
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted ||
        authStatus == PHAuthorizationStatusDenied) {
        isAuthorization = NO;
        title = NSLocalizedString(@"无法访问相册", nil);
        message = NSLocalizedString(@"请在设备的\"设置-隐私-照片\"中允许访问照片。", nil);
        NSLog(@"功能权限信息提示:\n%@\n%@", title, message);
        
        if (self.noPermissionBlock) {
            self.noPermissionBlock(title, message);
        }
    } else {
        isAuthorization = YES;
    }
    
    return isAuthorization;
}



#pragma mark - 相机权限检查

/*
*  检查是否具备访问相机权限
*
*  @return 权限判断
*/
- (BOOL)checkEnableForCamera {
    BOOL permissionEnable = [self __checkDeviceSupportCamera];
    if (!permissionEnable) {
        return permissionEnable;
    }
    
    permissionEnable = [self __checkUserAuthorizationStatusForCamera];
    return permissionEnable;
}


/**
 *  设备支持判断--设备支持校验之是否支持“拍照”
 *
 *  return 是否支持
 */
- (BOOL)__checkDeviceSupportCamera {
    BOOL isSupportCamera = NO;
    NSString *title;
    NSString *message;
#if TARGET_IPHONE_SIMULATOR
    isSupportCamera = NO;
    title = NSLocalizedString(@"无法拍照", nil);
    message = NSLocalizedString(@"模拟器无法拍照", nil);
    NSLog(@"功能权限信息提示:\n%@\n%@", title, message);
    if (self.noPermissionBlock) {
        self.noPermissionBlock(title, message);
    }
#else
    isSupportCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
#endif
    
    return isSupportCamera;
}



/**
 *  用户授权判断 AuthorizationStatus--检查授权之"相机Camera"
 *  @brief: 在info.plist里面设置NSCameraUsageDescription
 *                            Privacy - Camera Usage Description      App需要您的同意,才能访问相机
 *
 *  return 是否授权
 */
- (BOOL)__checkUserAuthorizationStatusForCamera {
    BOOL isAuthorization = NO;
    NSString *title;
    NSString *message;
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus == AVAuthorizationStatusDenied) {
        isAuthorization = NO;
        title = NSLocalizedString(@"无法拍照", nil);
        message = NSLocalizedString(@"请在“设置-隐私-相机”选项中允许应用访问你的相机", nil);
        NSLog(@"功能权限信息提示:\n%@\n%@", title, message);
        if (self.noPermissionBlock) {
            self.noPermissionBlock(title, message);
        }
    } else {
        isAuthorization = YES;
    }
    
    return isAuthorization;
}



@end
