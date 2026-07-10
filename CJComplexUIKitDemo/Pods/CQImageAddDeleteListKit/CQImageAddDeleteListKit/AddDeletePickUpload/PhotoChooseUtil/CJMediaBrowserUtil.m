//
//  CJMediaBrowserUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/6.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJMediaBrowserUtil.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@implementation CJMediaBrowserUtil

/*
*  查看视频
*
*  @param localRelativePath    视频的本地相对路径
*/
+ (void)browseVideoWithLocalRelativePath:(NSString *)localRelativePath {
    NSString *localPath = [NSHomeDirectory() stringByAppendingPathComponent:localRelativePath];
    NSURL *videoURL = [NSURL fileURLWithPath:localPath];
    MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    
    UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
    [currentShowingVC presentMoviePlayerViewControllerAnimated:moviePlayerController];
}

/*
*  查看图片
*
*  @param image     当前的图片
*  @param images    图片数组里
*/
+ (void)browseImage:(UIImage *)image inImages:(NSArray<UIImage *> *)images {
//    for (CJImageUploadFileModelsOwner *imageUploadItem in dataModels) {
//        UIImage *image = imageUploadItem.image;
//        if (image == nil) {
//            image = nil;    //试着从本地种查找
//        }
//    }
}



@end
