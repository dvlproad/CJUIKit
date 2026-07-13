//
//  CJUploadImagePickerUtil.h
//  UIKit-List-ImageAddDelete-iOS
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
// 直接依赖底层，不依赖 #import <CQImagePickerKit/CQImagePickerControllerFactory.h>
#import <CJImagePickerKit/CJSystemImagePickerController.h>
#import <CJImagePickerKit/CJCustomImagePickerViewController.h>


#import "CJImageUploadFileModelsOwner.h"
#import "CJVideoUploadFileModelsOwner.h"

NS_ASSUME_NONNULL_BEGIN

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
+ (CJSystemImagePickerController *)takePhotoPickerWithPickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock;


/**
 *  从相册中选择照片：创建从相册中选择照片的picker视图控制器
 *
 *  @param canMaxChooseImageCount   当前控制器可一次性选择的最大图片数目
 *  @param pickImageCompleteBlock   选择完图片后执行的操作
 *
 *  @return 从相册中选择照片的picker视图控制器
 */
+ (CJCustomImagePickerViewController *)choosePhotoPickerWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount pickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock;

@end
NS_ASSUME_NONNULL_END
