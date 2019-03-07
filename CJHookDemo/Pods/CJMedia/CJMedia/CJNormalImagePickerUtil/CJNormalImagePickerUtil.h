//
//  CJNormalImagePickerUtil.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  执行从相册中选择照片或者拍照操作（所选择/拍摄的图片不会被保存到沙盒中）
 */
@interface CJNormalImagePickerUtil : NSObject

/**
 *  拍照
 *
 *  @param viewController           在哪个视图控制器中执行从相册中选择照片
 *  @param pickImageFinishBlock     选择完图片后执行的操作
 *  @param pickCancelBlock          取消选择图片后执行的操作
 */
+ (void)takePhotoInViewController:(UIViewController *)viewController
         withPickImageFinishBlock:(void (^)(UIImage *image))pickImageFinishBlock
                  pickCancelBlock:(void(^)(void))pickCancelBlock;


/**
 *  从相册中选择照片
 *
 *  @param viewController           在哪个视图控制器中执行从相册中选择照片
 *  @param canMaxChooseImageCount   当前控制器可一次性选择的最大图片数目
 *  @param pickImageFinishBlock     选择完图片后执行的操作
 *
 */
+ (void)choosePhotoInViewController:(UIViewController *)viewController
         withCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
               pickImageFinishBlock:(void (^)(NSArray<UIImage *> *image))pickImageFinishBlock;

@end
