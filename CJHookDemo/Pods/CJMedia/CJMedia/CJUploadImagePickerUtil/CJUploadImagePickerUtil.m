//
//  CJUploadImagePickerUtil.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadImagePickerUtil.h"

#import <AVFoundation/AVFoundation.h>
#import <CJFile/CJFileManager+GetCreatePath.h>
#import <CJFile/CJFileManager+SaveFileData.h>

@implementation CJUploadImagePickerUtil

/* 完整的描述请参见文件头部 */
+ (MySingleImagePickerController *)takePhotoPickerWithPickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock
{
    MySingleImagePickerController *singleImagePickerController = [[MySingleImagePickerController alloc] init];
    [singleImagePickerController setSingleMediaTypeForVideo:NO];
    singleImagePickerController.saveLocation = CJSaveLocationNone;
    [singleImagePickerController pickImageFinishBlock:^(UIImage *image)
     {
         CJImageUploadFileModelsOwner *imageItem = [self saveImageToSandbox:image];  //保存图片到APP沙盒中
         if (pickImageCompleteBlock) {
             pickImageCompleteBlock(@[imageItem]);
         }
         
     } pickVideoFinishBlock:nil pickCancelBlock:^{
         
     }];
    
    return singleImagePickerController;
}


/* 完整的描述请参见文件头部 */
+ (CJImagePickerViewController *)choosePhotoPickerWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount pickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock
{
    /*
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //NSArray<NSString *> *mediaTypes = @[(NSString *)kUTTypeImage];
    
    UIImagePickerControllerUtil *imagePickerControllerUtil = [UIImagePickerControllerUtil sharedInstance];
    imagePickerControllerUtil.saveLocation = CJSaveLocationNone;
    [imagePickerControllerUtil openImagePickerControllerWithSourceType:sourceType isVideo:NO inViewController:self.belongToViewController pickImageFinishBlock:^(UIImage *image)
     {
         CJImageUploadFileModelsOwner *imageItem = [self saveImageToSandbox:image];  //保存图片到APP沙盒中
         
         [self.dataModels addObject:imageItem];
         
         [self reloadData];
         if (self.pickImageCompleteBlock) {
             self.pickImageCompleteBlock();
         }
         
     } pickVideoFinishBlock:nil pickCancelBlock:^{
         
     }];
    return;
    */
    
    CJImagePickerViewController *imagePickerViewController = [[CJImagePickerViewController alloc] init];
    imagePickerViewController.canMaxChooseImageCount = canMaxChooseImageCount;
    imagePickerViewController.pickCompleteBlock = ^(NSArray<AlumbImageModel *> *imageModels) {
        NSMutableArray *pickerImageModels = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < imageModels.count; i++) {
            AlumbImageModel *item = imageModels[i];
            UIImage *image = item.image;
            
            CJImageUploadFileModelsOwner *imageItem = [self saveImageToSandbox:image];   //保存图片到APP沙盒中
            [pickerImageModels addObject:imageItem];
        }
        //选择结束
        if (pickImageCompleteBlock) {
            pickImageCompleteBlock(pickerImageModels);
        }
    };
    
    return imagePickerViewController;
}


/**< 保存图片到APP沙盒中 */
+ (CJImageUploadFileModelsOwner *)saveImageToSandbox:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //文件名
    NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
    
    NSString *fileRelativePath =
    [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                          bySubDirectoryPath:@"CJUploadImage"
                       inSearchPathDirectory:NSCachesDirectory
                             createIfNoExist:YES];
    [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:fileRelativePath];
    
    
    //图片
    CJUploadFileModel *imageUploadModel = [[CJUploadFileModel alloc] initWithItemType:CJUploadItemTypeImage itemName:imageName itemData:imageData];
    
    
    CJImageUploadFileModelsOwner *imageItem =
    [[CJImageUploadFileModelsOwner alloc] initWithShowImage:image
                          imageLocalRelativePath:fileRelativePath
                                uploadFileModels:@[imageUploadModel]];
    
    return imageItem;
}

@end
