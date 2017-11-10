//
//  UIView+CJPickImage.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJPickImage.h"
#import <CJMedia/MySingleImagePickerController.h>

#import <AVFoundation/AVFoundation.h>
#import <CJFile/CJFileManager+SaveFileData.h>

@implementation UIView (CJPickImage)

/* 完整的描述请参见文件头部 */
- (UIImagePickerController *)takePhotoPickerWithPickCompleteBlock:(void (^)(NSArray<CJImageUploadItem *> *pickedImageItems))pickImageCompleteBlock
{
    MySingleImagePickerController *singleImagePickerController = [[MySingleImagePickerController alloc] init];
    [singleImagePickerController setSingleMediaTypeForVideo:NO];
    singleImagePickerController.saveLocation = CJSaveLocationNone;
    [singleImagePickerController pickImageFinishBlock:^(UIImage *image)
     {
         NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
         
         //文件名
         NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
         NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
         
         NSString *imageRelativePath =
         [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                               bySubDirectoryPath:@"UploadImage"
                            inSearchPathDirectory:NSCachesDirectory
                                  createIfNoExist:YES];
         [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:imageRelativePath];
         
         NSMutableArray<CJUploadFileModel *> *uploadFileModels = [[NSMutableArray alloc] init];
         //NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
         //图片
         //NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
         //NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
         CJUploadFileModel *imageUploadItem = [[CJUploadFileModel alloc] init];
         imageUploadItem.uploadItemType = CJUploadItemTypeImage;
         imageUploadItem.uploadItemData = imageData;
         imageUploadItem.uploadItemName = imageName;
         [uploadFileModels addObject:imageUploadItem];
         
         CJImageUploadItem *imageItem =
         [[CJImageUploadItem alloc] initWithShowImage:image
                               imageLocalRelativePath:imageRelativePath
                                          uploadFileModels:uploadFileModels];
         
         if (pickImageCompleteBlock) {
             pickImageCompleteBlock(@[imageItem]);
         }
         
     } pickVideoFinishBlock:nil pickCancelBlock:^{
         
     }];
    
    return singleImagePickerController;
}


/* 完整的描述请参见文件头部 */
- (CJImagePickerViewController *)choosePhotoPickerWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount pickCompleteBlock:(void (^)(NSArray<CJImageUploadItem *> *pickedImageItems))pickImageCompleteBlock {
    /*
     UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     //NSArray<NSString *> *mediaTypes = @[(NSString *)kUTTypeImage];
     
     UIImagePickerControllerUtil *imagePickerControllerUtil = [UIImagePickerControllerUtil sharedInstance];
     imagePickerControllerUtil.saveLocation = CJSaveLocationNone;
     [imagePickerControllerUtil openImagePickerControllerWithSourceType:sourceType isVideo:NO inViewController:self.belongToViewController pickImageFinishBlock:^(UIImage *image)
     {
     NSString *imageRelativePath = [self saveImageToLocal:image];
     
     NSMutableArray<CJUploadFileModel *> *uploadModels = [[NSMutableArray alloc] init];
     NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
     //图片
     NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
     CJUploadFileModel *imageUploadModel = [[CJUploadFileModel alloc] init];
     imageUploadModel.uploadItemType = CJUploadItemTypeImage;
     imageUploadModel.uploadItemData = imageData;
     imageUploadModel.uploadItemName = imageName;
     [uploadModels addObject:imageUploadModel];
     
     CJImageUploadItem *imageItem =
     [[CJImageUploadItem alloc] initWithShowImage:image
     imageLocalRelativePath:imageRelativePath
     uploadFileModels:uploadModels];
     
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
    imagePickerViewController.pickCompleteBlock = ^(NSArray *images){
        NSMutableArray *pickerImageModels = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < images.count; i++) {
            AlumbImageModel *item = images[i];
            UIImage *image = item.image;
            
            NSString *imageRelativePath = [self saveImageToLocal:image];
            
            NSMutableArray<CJUploadFileModel *> *uploadModels = [[NSMutableArray alloc] init];
            NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
            //图片
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            NSString *imageName = [identifier stringByAppendingPathExtension:@"jpg"];
            CJUploadFileModel *imageUploadModel = [[CJUploadFileModel alloc] init];
            imageUploadModel.uploadItemType = CJUploadItemTypeImage;
            imageUploadModel.uploadItemData = imageData;
            imageUploadModel.uploadItemName = imageName;
            [uploadModels addObject:imageUploadModel];
            
            CJImageUploadItem *imageItem =
            [[CJImageUploadItem alloc] initWithShowImage:image
                                  imageLocalRelativePath:imageRelativePath
                                             uploadFileModels:uploadModels];
            
            [pickerImageModels addObject:imageItem];
        }
        //选择结束
        if (pickImageCompleteBlock) {
            pickImageCompleteBlock(pickerImageModels);
        }
    };
    
    return imagePickerViewController;
}


/**< 保存图片到本地 */
- (NSString *)saveImageToLocal:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //文件名
    NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString *fileName = [identifier stringByAppendingPathExtension:@"jpg"];
    
    NSString *fileRelativePath =
    [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                          bySubDirectoryPath:@"UploadImage"
                       inSearchPathDirectory:NSCachesDirectory
                             createIfNoExist:YES];
    [CJFileManager saveFileData:imageData withFileName:fileName toRelativeDirectoryPath:fileRelativePath];
    
    return fileRelativePath;
}

@end
