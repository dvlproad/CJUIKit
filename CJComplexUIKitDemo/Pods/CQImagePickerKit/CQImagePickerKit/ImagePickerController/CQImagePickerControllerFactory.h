//
//  CQImagePickerControllerFactory.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
// "拍摄照片"和"选择照片"的视图控制器

#import <UIKit/UIKit.h>

#import "CJSystemImagePickerController.h"
#import "CJImagePickerViewController.h"
#import "CJImagePickerNavigatorController.h"


@interface CQImagePickerControllerFactory : NSObject

#pragma mark - 拍摄照片 的视图控制器
/*
 *  拍摄照片 的视图控制器
 *
 *  @param pickFinishBlock      拍照结束的回调
 *  @param pickCancelBlock      取消的回调
 */
+ (CJSystemImagePickerController *)takePhotoVC_PickFinishBlock:(void (^)(UIImage *image))pickFinishBlock
                                               pickCancelBlock:(void(^)(void))pickCancelBlock;

#pragma mark - 选择照片 的视图控制器

/*
*  从相册中选择照片 的照片选择器(只多选)
*
*  @param pickFinishBlock          选择结束的回调
*/
+ (CJSystemImagePickerController *)pickSingleAssetVC_pickFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock;

/*
 *  从相册中选择照片 的照片选择器(可多选)
 *
 *  @param canMaxChooseImageCount   最多可选择多少张的回调
 *  @param pickFinishBlock          选择结束的回调
 */
+ (UIViewController *)pickMultipleAssetsVC_canMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                                  pickFinishBlock:(void (^)(UIViewController *bVC, NSArray<UIImage *> *image))pickFinishBlock;

/*
 *  从相册中选择照片 的照片选择器(可多选)
 *
 *  @param canMaxChooseImageCount   最多可选择多少张的回调
 *  @param pickFinishBlock          选择结束的回调
 *  @param pickCancelBlock          选择取消的回调
 */
+ (UINavigationController *)pickMultipleAssetsNavVC_canMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                                           pickFinishBlock:(void (^)(UINavigationController *bNavVC, NSArray<UIImage *> *image))pickFinishBlock
                                                           pickCancelBlock:(void(^)(UINavigationController *bNavVC))pickCancelBlock;

@end
