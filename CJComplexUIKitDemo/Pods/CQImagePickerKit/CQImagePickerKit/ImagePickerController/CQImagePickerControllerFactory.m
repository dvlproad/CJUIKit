//
//  CQImagePickerControllerFactory.m
//  UIKit-ImagePicker-iOS
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQImagePickerControllerFactory.h"
#import <CQDemoKit/CJUIKitToastUtil.h>

@implementation CQImagePickerControllerFactory

#pragma mark - 拍摄照片 的视图控制器
/*
 *  拍摄照片 的视图控制器
 *
 *  @param pickFinishBlock      拍照结束的回调
 *  @param pickCancelBlock      取消的回调
 *
 *  @return 系统图片选择器
 */
+ (CJSystemImagePickerController *)takePhotoVC_PickFinishBlock:(void (^)(UIImage *image))pickFinishBlock
                                               pickCancelBlock:(void(^)(void))pickCancelBlock
{
    CJSystemImagePickerController *imagePickerController = [[CJSystemImagePickerController alloc] init];
    [imagePickerController setSingleMediaTypeForVideo:NO];
    imagePickerController.saveLocation = CJSaveLocationNone;
    [imagePickerController pickImageFinishBlock:pickFinishBlock pickVideoFinishBlock:nil pickCancelBlock:pickCancelBlock];
    
    return imagePickerController;
}

#pragma mark - 选择照片 的视图控制器

/*
 *  从相册中选择照片 的照片选择器(只多选)
 *
 *  @param pickFinishBlock          选择结束的回调
 *
 *  @return 系统图片选择器
 */
+ (CJSystemImagePickerController *)pickSingleAssetVC_pickFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock {
    CJSystemImagePickerController *singleImagePickerController = [[CJSystemImagePickerController alloc] init];
    singleImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    singleImagePickerController.allowsEditing = YES;
    [singleImagePickerController setSingleMediaTypeForVideo:NO];
    singleImagePickerController.saveLocation = CJSaveLocationNone;
    [singleImagePickerController pickImageFinishBlock:pickImageFinishBlock pickVideoFinishBlock:nil pickCancelBlock:nil];
    
    return singleImagePickerController;
}

/*
 *  从相册中选择照片 的照片选择器(可多选)
 *
 *  @param canMaxChooseImageCount   最多可选择多少张的回调
 *  @param pickFinishBlock          选择结束的回调
 *
 *  @return 自定义的“图片选择器CJCustomImagePickerViewController”
 */
+ (CJCustomImagePickerViewController *)pickMultipleAssetsVC_canMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                                             pickFinishBlock:(void (^)(UIViewController *bVC, NSArray<UIImage *> *bImages))pickFinishBlock
{
    CJCustomImagePickerViewController *imagePickerViewController = [[CJCustomImagePickerViewController alloc] initWithOverLimitBlock:^(NSInteger currentCount, NSInteger maxCount) {
        
    } clickImageBlock:^(CJAlumbImageModel *imageModel) {
        
    } previewAction:^(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels) {
        
    } pickFinishBlock:^(UIViewController *bVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels) {
        NSMutableArray *pickerImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < bSelectedImageModels.count; i++) {
            CJAlumbImageModel *item = bSelectedImageModels[i];
            UIImage *image = item.image;

            [pickerImages addObject:image];
        }
        //选择结束
        if (pickFinishBlock) {
            pickFinishBlock(bVC, pickerImages);
        }
    }];
    imagePickerViewController.canMaxChooseImageCount = canMaxChooseImageCount;

    
    return imagePickerViewController;
}



/*
 *  从相册中选择照片 的照片选择器(可多选)
 *
 *  @param canMaxChooseImageCount   最多可选择多少张的回调
 *  @param pickFinishBlock          选择结束的回调
 *  @param pickCancelBlock          选择取消的回调
 *
 *  @return 包含有 自定义的“图片选择器CJCustomImagePickerViewController” 的 UINavigationController
 */
+ (UINavigationController *)pickMultipleAssetsNavVC_canMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                                           pickFinishBlock:(void (^)(UINavigationController *bNavVC, NSArray<UIImage *> *bImages))pickFinishBlock
                                                           pickCancelBlock:(void(^)(UINavigationController *bNavVC))pickCancelBlock
{
    UINavigationController *nav = [[CJCustomImagePickerController alloc] initWithOverLimitBlock:nil clickImageBlock:^(CJAlumbImageModel *imageModel) {
        [CJUIKitToastUtil showMessage:@"请后续自己补充好[本图片]的点击操作"];
    } previewAction:^(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels) {
        [CJUIKitToastUtil showMessage:@"请后续自己补充好[这些图片]的预览操作"];
    } pickFinishBlock:^(UINavigationController *bNavVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels) {
        NSMutableArray *pickerImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < bSelectedImageModels.count; i++) {
            CJAlumbImageModel *item = bSelectedImageModels[i];
            UIImage *image = item.image;

            [pickerImages addObject:image];
        }
        //选择结束
        if (pickFinishBlock) {
            pickFinishBlock(bNavVC, pickerImages);
        }
    } pickCancelBlock:pickCancelBlock changePhotoGroupBlock:^{
        
    }];
    
    return nav;
}


@end
