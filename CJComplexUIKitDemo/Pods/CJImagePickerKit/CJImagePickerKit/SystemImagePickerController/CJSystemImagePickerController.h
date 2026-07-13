//
//  CJSystemImagePickerController.h
//  UIKit-ImagePicker-iOS
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>   //UIImagePickerController需要使用
#import <AssetsLibrary/AssetsLibrary.h> //系统相册需要使用

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, CJSaveLocation) {
    CJSaveLocationNone = 1 << 0,
    CJSaveLocationPhotoLibrary = 1 << 1,
};

@interface CJSystemImagePickerController : UIImagePickerController {
    
}
@property (nonatomic, assign) CJSaveLocation saveLocation;

/*
 *  是否是选择视频，否:则为默认的图像
 *
 *  @param isVideo   是否是选择视频(YES:视频, NO:图像)
 */
- (void)setSingleMediaTypeForVideo:(BOOL)isVideo;

- (void)pickImageFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock
        pickVideoFinishBlock:(void(^)(UIImage *firstImage))pickVideoFinishBlock
             pickCancelBlock:(void(^)(void))pickCancelBlock;


@end
NS_ASSUME_NONNULL_END
