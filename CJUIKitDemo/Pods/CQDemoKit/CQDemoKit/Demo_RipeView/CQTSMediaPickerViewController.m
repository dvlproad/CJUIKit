//
//  CQTSMediaPickerViewController.m
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSMediaPickerViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <PhotosUI/PhotosUI.h>

@interface CQTSMediaPickerViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate> {
    
}
@property (nonatomic, assign) CQTSPhotoMediaOption options;
@property (nullable, nonatomic, copy) void(^imageSuccess)(UIImage *image);
@property (nullable, nonatomic, copy) void(^videoSuccess)(NSURL *videoURL);
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

@end

@implementation CQTSMediaPickerViewController

#pragma mark - Init
- (instancetype)initWithOptions:(CQTSPhotoMediaOption)options
                   imageSuccess:(nullable void (^)(UIImage *image))imageSuccess
                   videoSuccess:(nullable void (^)(NSURL *videoURL))videoSuccess
                        failure:(void (^)(NSError *))failure
{
    self = [super init];
    if (self) {
        _options = options;
        _imageSuccess = imageSuccess;
        _videoSuccess = videoSuccess;
        _failureBlock = failure;
        [self configureAudioSession];
    }
    return self;
}

/// 配置音频会话，解决从相册中选择的视频播放没有声音的问题
- (void)configureAudioSession {
    NSError *error = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    BOOL categorySet = [audioSession setCategory:AVAudioSessionCategoryPlayback
                                          mode:AVAudioSessionModeMoviePlayback
                                       options:0
                                         error:&error];
    
    if (!categorySet || error) {
        NSLog(@"配置音频会话失败: %@", error.localizedDescription);
        return;
    }
    
    BOOL activeSet = [audioSession setActive:YES error:&error];
    
    if (!activeSet || error) {
        NSLog(@"激活音频会话失败: %@", error.localizedDescription);
    }
}


#pragma mark - 从相册中选择视频
// 从相册中选择视频
- (void)chooseVideoFromSystem:(UIViewController *)viewController {
    if (@available(iOS 14, *)) { // （使用 PHPickerViewController）
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
            NSError *error = [NSError errorWithDomain:@"无访问相册权限" code:401 userInfo:nil];
            self.failureBlock(error);
        }
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                //NSLog(@"相册访问授权成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self chooseVideoFromSystemIOS14:viewController];
                });
            } else {
                NSError *eror = [NSError errorWithDomain:@"相册访问授权失败" code:404 userInfo:nil];
                self.failureBlock(eror);
            }
        }];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
    // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
    NSMutableArray<NSString *> *mediaTypes = [[NSMutableArray alloc] init];
    if (self.options & CQTSPhotoMediaOptionVideo) {
        [mediaTypes addObject:(NSString *)kUTTypeMovie];
    }
    if (self.options & CQTSPhotoMediaOptionImage) {
        [mediaTypes addObject:(NSString *)kUTTypeImage];
    }
    [imagePickerController setMediaTypes:mediaTypes];
    
    [imagePickerController setDelegate:self];
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh; // 视频质量
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)chooseVideoFromSystemIOS14:(UIViewController *)viewController API_AVAILABLE(ios(14)) {
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    
    if (self.options & CQTSPhotoMediaOptionVideo && self.options & CQTSPhotoMediaOptionImage) {
        
    } else {
        if (self.options & CQTSPhotoMediaOptionVideo) {
            config.filter = [PHPickerFilter videosFilter];
        }
        if (self.options & CQTSPhotoMediaOptionImage) {
            config.filter = [PHPickerFilter imagesFilter];
        }
    }
    
    config.selectionLimit = 1; // 仅允许单选
    
    PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:config];
    picker.delegate = self;
    [viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark PHPickerViewControllerDelegate
// 处理选择结果
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results API_AVAILABLE(ios(14)) {
    [picker dismissViewControllerAnimated:YES completion:nil]; // 立即关闭相册
    
    if (results.count == 0) {
        return;
    }
    
    PHPickerResult *result = results.firstObject;
    NSItemProvider *itemProvider = result.itemProvider;
    
    if ([itemProvider canLoadObjectOfClass:[UIImage class]]) {
        [itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
            if (error) {
                !self.failureBlock ?: self.failureBlock(error);
                return;
            }
            
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"成功获取图片: %@", image);
                    !self.imageSuccess ?: self.imageSuccess(image);
                });
            }
        }];
    }

    if ([result.itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeMovie]) {
        [result.itemProvider loadFileRepresentationForTypeIdentifier:(NSString *)kUTTypeMovie completionHandler:^(NSURL * _Nullable sourceURL, NSError * _Nullable error) {
            if (sourceURL) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
                NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:sourceURL.lastPathComponent];

                NSError *copyError = nil;
                if ([fileManager fileExistsAtPath:destinationURL.path]) {
                    if (![fileManager removeItemAtURL:destinationURL error:&copyError]) {
                        NSLog(@"删除旧文件失败: %@", copyError.localizedDescription);
                        return;
                    }
                }

                if (![fileManager copyItemAtURL:sourceURL toURL:destinationURL error:&copyError]) {
                    NSLog(@"复制视频文件失败: %@", copyError.localizedDescription);
                    return;
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    !self.videoSuccess ?: self.videoSuccess(destinationURL);
                });
                
            } else {
                self.failureBlock(error);
            }
        }];
        
        /* loadItemForTypeIdentifier: 会自动将文件拷贝到临时目录（通常在 file://private/var/.../）
        [result.itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeMovie options:nil completionHandler:^(NSURL * _Nullable videoURL, NSError * _Nullable error) {
            if (videoURL && !error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //iOS 14+ 使用 PHPickerViewController 选择视频时，获取的 NSURL 是沙盒临时路径，但默认没有拷贝到可访问的目录，导致 AVPlayer 无法正常播放。而 UIImagePickerController 直接提供的是一个可访问的本地文件路径，所以在 iOS 14 以下可以正常播放。
//
                    
                    BOOL accessGranted = [videoURL startAccessingSecurityScopedResource];
                    if (accessGranted) {
                        NSURL *playableURL = [self copyVideoToTemporaryDirectory:videoURL];
                        [self playVideoWithURL:playableURL];
                        [videoURL stopAccessingSecurityScopedResource]; // 释放权限
                    } else {
                        NSString *errorMessage = [NSString stringWithFormat:@"无法访问 security-scoped URL: %@", videoURL];
                        [CJUIKitToastUtil showMessage:errorMessage];
                    }
                });
            }
        }];
        */
    }
}



#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    //NSLog(@"%@", info);
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {
        // 获取原始图片
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 获取编辑后的图片（如果有编辑）
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (editedImage) {
            selectedImage = editedImage;
        }
        
        // 获取图片的 URL（适用于 iOS 11+）
        if (@available(iOS 11.0, *)) {
            NSURL *imageURL = [info objectForKey:UIImagePickerControllerImageURL];
            NSLog(@"图片URL(iOS11+): %@", imageURL);
        }
        
        // 关闭 picker
        [picker dismissViewControllerAnimated:YES completion:^{
            if (selectedImage) {
                !self.imageSuccess ?: self.imageSuccess(selectedImage);
                
            } else {
                NSError *error = [NSError errorWithDomain:@"选择图片失败" code:-1 userInfo:nil];
                !self.failureBlock ?: self.failureBlock(error);
            }
        }];
        
        
        
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:^{
            if (videoURL != nil) {
                !self.videoSuccess ?: self.videoSuccess(videoURL);
            } else {
                NSError *error = [NSError errorWithDomain:@"选择视频失败" code:-1 userInfo:nil];
                !self.failureBlock ?: self.failureBlock(error);
            }
        }];
    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
