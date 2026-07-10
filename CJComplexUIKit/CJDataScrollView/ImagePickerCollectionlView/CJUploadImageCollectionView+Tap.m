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

#import <CJMedia/CJUploadImagePickerUtil.h>

@implementation CJUploadImageCollectionView (Tap)

- (void)didSelectMediaUploadItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.mediaType == CJMediaTypeVideo) {
        CJImageUploadFileModelsOwner *imageUploadItem = [self.dataModels objectAtIndex:indexPath.row];
        NSString *localPath = [NSHomeDirectory() stringByAppendingPathComponent:imageUploadItem.localRelativePath];
        NSURL *videoURL = [NSURL fileURLWithPath:localPath];
        MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
        [moviePlayerController.moviePlayer prepareToPlay];
        moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self.belongToViewController presentMoviePlayerViewControllerAnimated:moviePlayerController];
        
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
    NSAssert(self.belongToViewController != nil, @"未设置CJUploadCollectionView的belongToViewController");
    
    if (self.dataModels.count >= self.equalCellSizeSetting.maxDataModelShowCount) {
        //[UIGlobal showMessage:@"图片数量已达上限"];
        NSLog(@"所选媒体数量已达上限");
        return;
    }
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (self.mediaType == CJMediaTypeVideo) {
        [self addVideoUploadItemAction];
        
    } else {
        [self addImageUploadItemAction];
    }
}

#pragma mark - 视频选择
- (void)addVideoUploadItemAction {
    if (self.pickVideoHandle) {
        self.pickVideoHandle();
    } else {
        NSLog(@"未操作视频选择");
    }
}



#pragma mark - 图片选择
- (void)addImageUploadItemAction {
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"拍照", @"从手机相册选择"] buttonStyle:JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section1, cancelSection];
    
    __weak typeof(self)weakSelf = self;
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0) {   //拍照
                UIImagePickerController *imagePickerController = [CJUploadImagePickerUtil takePhotoPickerWithPickCompleteBlock:^(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems) {
                    [weakSelf.dataModels addObjectsFromArray:pickedImageItems];
                    [weakSelf reloadData];
                    if (weakSelf.pickImageCompleteBlock) {
                        weakSelf.pickImageCompleteBlock();
                    }
                }];
                
                if (imagePickerController) {
                    [weakSelf.belongToViewController presentViewController:imagePickerController animated:YES completion:nil];
                }
                
            } else {
                NSInteger canMaxChooseImageCount = weakSelf.equalCellSizeSetting.maxDataModelShowCount - weakSelf.dataModels.count;
                
                CJImagePickerViewController *imagePickerController =
                [CJUploadImagePickerUtil choosePhotoPickerWithCanMaxChooseImageCount:canMaxChooseImageCount pickCompleteBlock:^(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems) {
                    [weakSelf.dataModels addObjectsFromArray:pickedImageItems];
                    [weakSelf reloadData];
                    if (weakSelf.pickImageCompleteBlock) {
                        weakSelf.pickImageCompleteBlock();
                    }
                }];
                
                UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
                
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imagePickerController];
                nav.navigationBar.barTintColor = [UIColor whiteColor];
                [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:blueTextColor}];
                nav.navigationBar.tintColor = blueTextColor;
                
                [weakSelf.belongToViewController presentViewController:nav animated:YES completion:NULL];
            }
        }
        [sheet dismissAnimated:YES];
    }];
    [sheet setOutsidePressBlock:^(JGActionSheet *sheet){
        [sheet dismissAnimated:YES];
    }];
    
    NSAssert(self.belongToViewController != nil, @"所属控制器不能为空，请先设置");
    [sheet showInView:self.belongToViewController.view animated:YES];
}


@end
