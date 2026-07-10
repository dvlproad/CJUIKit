//
//  MySingleImagePickerController.m
//  CJPickerDemo
//
//  Created by ciyouzen on 14-02-16.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import "MySingleImagePickerController.h"

@interface MySingleImagePickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) void (^pickImageFinishBlock)(UIImage *image);
@property (nonatomic, copy) void (^pickVideoFinishBlock)(UIImage *firstImage);
@property (nonatomic, copy) void (^pickCancelBlock)(void);


@end

@implementation MySingleImagePickerController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}

- (void)setSingleMediaTypeForVideo:(BOOL)isVideo {
    //NSArray<NSString *> *mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
    if (isVideo) {
        self.mediaTypes = @[(NSString *)kUTTypeMovie];
        self.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
        self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
    } else {
        self.mediaTypes = @[(NSString *)kUTTypeImage];//默认
    }
}

- (void)pickImageFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock
        pickVideoFinishBlock:(void(^)(UIImage *firstImage))pickVideoFinishBlock
             pickCancelBlock:(void(^)(void))pickCancelBlock
{
    self.pickImageFinishBlock = pickImageFinishBlock;
    self.pickVideoFinishBlock = pickVideoFinishBlock;
    self.pickCancelBlock = pickCancelBlock;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
    
    if (self.pickCancelBlock) {
        self.pickCancelBlock();
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image = nil;
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        
        //保存
        if (self.saveLocation & CJSaveLocationPhotoLibrary) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        }
        
        if (self.pickImageFinishBlock) {
            self.pickImageFinishBlock(image);
        }
        
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        NSURL *URL = [info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *url = [URL path];
        
        //保存
        if (self.saveLocation & CJSaveLocationPhotoLibrary) {
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url)) {
                //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
                UISaveVideoAtPathToSavedPhotosAlbum(url, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
            }
        }
        
        if (self.pickVideoFinishBlock) {
            self.pickVideoFinishBlock(nil);
        }
    }
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        //录制完之后自动播放
        //        NSURL *url=[NSURL fileURLWithPath:videoPath];
        //        _player=[AVPlayer playerWithURL:url];
        //        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        //        playerLayer.frame=self.photo.frame;
        //        [self.photo.layer addSublayer:playerLayer];
        //        [_player play];
        
    }
}


@end

