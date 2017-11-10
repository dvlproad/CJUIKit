//
//  MySingleImagePickerController.h
//  CJPickerDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>   //UIImagePickerController需要使用
#import <AssetsLibrary/AssetsLibrary.h> //系统相册需要使用


typedef NS_OPTIONS(NSUInteger, CJSaveLocation) {
    CJSaveLocationNone = 1 << 0,
    CJSaveLocationPhotoLibrary = 1 << 1,
};

@interface MySingleImagePickerController : UIImagePickerController {
    
}
@property (nonatomic, assign) CJSaveLocation saveLocation;

- (void)setSingleMediaTypeForVideo:(BOOL)isVideo;

- (void)pickImageFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock
        pickVideoFinishBlock:(void(^)(UIImage *firstImage))pickVideoFinishBlock
             pickCancelBlock:(void(^)(void))pickCancelBlock;


@end
