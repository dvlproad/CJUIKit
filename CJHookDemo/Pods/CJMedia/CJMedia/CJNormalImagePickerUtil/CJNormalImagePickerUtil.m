//
//  CJNormalImagePickerUtil.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJNormalImagePickerUtil.h"
#import <AVFoundation/AVFoundation.h>

#import "CJValidateAuthorizationUtil.h"
#import "MySingleImagePickerController.h"
#import "CJImagePickerViewController.h"

@implementation CJNormalImagePickerUtil

#pragma mark - 照片选择
/**< 拍照 */
+ (void)takePhotoInViewController:(UIViewController *)viewController
         withPickImageFinishBlock:(void (^)(UIImage *image))pickImageFinishBlock
                  pickCancelBlock:(void(^)(void))pickCancelBlock
{
    BOOL isCameraEnable = [CJValidateAuthorizationUtil checkEnableForDeviceComponentType:CJDeviceComponentTypeCamera inViewController:viewController];
    if (!isCameraEnable) {
        return;
    }
    
    MySingleImagePickerController *singleImagePickerController = [[MySingleImagePickerController alloc] init];
    [singleImagePickerController setSingleMediaTypeForVideo:NO];
    singleImagePickerController.saveLocation = CJSaveLocationNone;
    [singleImagePickerController pickImageFinishBlock:pickImageFinishBlock pickVideoFinishBlock:nil pickCancelBlock:pickCancelBlock];
    
    [viewController presentViewController:singleImagePickerController animated:YES completion:nil];
}


/**< 从相册中选择照片 */
+ (void)choosePhotoInViewController:(UIViewController *)viewController
         withCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
               pickImageFinishBlock:(void (^)(NSArray<UIImage *> *image))pickImageFinishBlock
{
    BOOL isAlbumEnable = [CJValidateAuthorizationUtil checkEnableForDeviceComponentType:CJDeviceComponentTypeAlbum inViewController:viewController];
    if (!isAlbumEnable) {
        return;
    }
    
    CJImagePickerViewController *imagePickerViewController = [[CJImagePickerViewController alloc] init];
    imagePickerViewController.canMaxChooseImageCount = canMaxChooseImageCount;
    imagePickerViewController.pickCompleteBlock = ^(NSArray<AlumbImageModel *> *imageModels) {
        NSMutableArray *pickerImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < imageModels.count; i++) {
            AlumbImageModel *item = imageModels[i];
            UIImage *image = item.image;
            
            [pickerImages addObject:image];
        }
        //选择结束
        if (pickImageFinishBlock) {
            pickImageFinishBlock(pickerImages);
        }
    };
    
    [viewController presentViewController:imagePickerViewController animated:YES completion:nil];
}


@end
