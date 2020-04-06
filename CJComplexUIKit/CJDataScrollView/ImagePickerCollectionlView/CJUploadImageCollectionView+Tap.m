//
//  CJUploadImageCollectionView+Tap.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/8/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadImageCollectionView+Tap.h"
#import <JGActionSheet/JGActionSheet.h>

#import <MediaPlayer/MediaPlayer.h>

#import "CJChooseFileActionSheetUtil.h"
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@implementation CJUploadImageCollectionView (Tap)

- (void)didSelectMediaUploadItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
    
    if (self.mediaType == CJMediaTypeVideo) {
        CJImageUploadFileModelsOwner *imageUploadItem = [self.dataModels objectAtIndex:indexPath.row];
        NSString *localPath = [NSHomeDirectory() stringByAppendingPathComponent:imageUploadItem.localRelativePath];
        NSURL *videoURL = [NSURL fileURLWithPath:localPath];
        MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
        [moviePlayerController.moviePlayer prepareToPlay];
        moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [currentShowingVC presentMoviePlayerViewControllerAnimated:moviePlayerController];
        
    } else {
        for (CJImageUploadFileModelsOwner *imageUploadItem in self.dataModels) {
            UIImage *image = imageUploadItem.image;
            if (image == nil) {
                image = nil;    //试着从本地种查找
            }
            
        }
    }
}

- (void)didTapToAddMediaUploadItemAction {
    NSInteger maxDataModelShowCount = self.equalCellSizeCollectionViewDataSource.equalCellSizeSetting.maxDataModelShowCount;
    if (self.dataModels.count >= maxDataModelShowCount) {
        //[UIGlobal showMessage:@"图片数量已达上限"];
        NSLog(@"所选媒体数量已达上限");
        return;
    }
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    
    __weak typeof(self)weakSelf = self;
    NSInteger canMaxChooseImageCount = maxDataModelShowCount - self.dataModels.count;
    if (self.mediaType == CJMediaTypeVideo) { //视频选择
        if (self.pickVideoHandle) {
            self.pickVideoHandle();
        } else {
            NSLog(@"未操作视频选择");
        }
        
    } else { // 图片选择
        [CJChooseFileActionSheetUtil defaultImageChooseWithCanMaxChooseImageCount:canMaxChooseImageCount pickCompleteBlock:^(NSArray<CJImageUploadFileModelsOwner *> * _Nonnull pickedImageItems) {
            [weakSelf.dataModels addObjectsFromArray:pickedImageItems];
            [weakSelf reloadData];
            if (weakSelf.pickImageCompleteBlock) {
                weakSelf.pickImageCompleteBlock();
            }
        }];
    }
}


@end
