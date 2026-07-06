//
//  CQTSMediaPickerViewController.h
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  从相册中选择视频
//  Privacy - Photo Library Usage Description             我们需要访问您的相册来保存图片或视频
//  Privacy - Photo Library Additions Usage Description   应用需要访问您的照片库以保存和读取视频

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, CQTSPhotoMediaOption) {
    CQTSPhotoMediaOptionImage       = 1 << 0,  // image
    CQTSPhotoMediaOptionVideo       = 1 << 1,  // video
};


@interface CQTSMediaPickerViewController : NSObject {
    
}
#pragma mark - Init
- (instancetype)initWithOptions:(CQTSPhotoMediaOption)options
                   imageSuccess:(nullable void (^)(UIImage *image))imageSuccess
                   videoSuccess:(nullable void (^)(NSURL *videoURL))videoSuccess
                        failure:(void (^)(NSError *))failure;

#pragma mark - 从相册中选择视频
// 从相册中选择视频
- (void)chooseVideoFromSystem:(UIViewController *)viewController;

@end
