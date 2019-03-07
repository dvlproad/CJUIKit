//
//  CJUploadImagePickerUtil.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySingleImagePickerController.h"
#import "CJImagePickerViewController.h"

#import "CJImageUploadFileModelsOwner.h"
#import "CJVideoUploadFileModelsOwner.h"

/**
 *  获取图片选择器，所选择/拍摄的图片会被保存到沙盒中
 */
@interface CJUploadImagePickerUtil : NSObject

/**
 *  拍照：创建拍照的picker视图控制器
 *
 *  @param pickImageCompleteBlock 选择完图片后执行的操作
 *
 *  @return 拍照的picker视图控制器
 */
+ (MySingleImagePickerController *)takePhotoPickerWithPickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock;


/**
 *  从相册中选择照片：创建从相册中选择照片的picker视图控制器
 *
 *  @param canMaxChooseImageCount   当前控制器可一次性选择的最大图片数目
 *  @param pickImageCompleteBlock   选择完图片后执行的操作
 *
 *  @return 从相册中选择照片的picker视图控制器
 */
+ (CJImagePickerViewController *)choosePhotoPickerWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount pickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock;

@end
