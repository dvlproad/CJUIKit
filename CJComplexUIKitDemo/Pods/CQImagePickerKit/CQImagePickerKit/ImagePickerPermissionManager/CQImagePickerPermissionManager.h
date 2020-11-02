//
//  CQImagePickerPermissionManager.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  相册 和 相机 权限检查

#import <UIKit/UIKit.h>

@interface CQImagePickerPermissionManager : NSObject {
    
}
@property (nonatomic, copy) void(^noPermissionBlock)(NSString *title, NSString *message);   /**< 没有权限时候h执行的方法 */

+ (CQImagePickerPermissionManager *)sharedInstance;

#pragma mark - 相册权限检查

/*
*  检查是否具备访问相册权限
*
*  @return 权限判断
*/
- (BOOL)checkEnableForAlbum;

#pragma mark - 相机权限检查

/*
*  检查是否具备访问相机权限
*
*  @return 权限判断
*/
- (BOOL)checkEnableForCamera;


@end
