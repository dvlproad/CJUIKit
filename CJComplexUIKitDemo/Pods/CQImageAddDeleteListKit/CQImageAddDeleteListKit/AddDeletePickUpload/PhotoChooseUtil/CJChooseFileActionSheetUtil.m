//
//  CJChooseFileActionSheetUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/6.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJChooseFileActionSheetUtil.h"
#import <CQOverlayKit/CQActionSheetUtil.h>
#import <CQImagePickerKit/CQImagePickerControllerFactory.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@implementation CJChooseFileActionSheetUtil

/*
*  弹出图片选择并进行选择
*
*  @param canMaxChooseImageCount    在允许批量添加的情况下，当前还允许添加的最大值。(默认填1)
*  @param pickCompleteBlock         选择完图片后执行的操作
*/
+ (void)defaultImageChooseWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                   pickCompleteBlock:(void (^)(NSArray<UIImage *> *bImages))pickCompleteBlock
{
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    {
        CJActionSheetModel *takPhotoSheetModel = [[CJActionSheetModel alloc] init];
        takPhotoSheetModel.title = NSLocalizedString(@"拍摄", nil);
        [sheetModels addObject:takPhotoSheetModel];
    }
    {
        CJActionSheetModel *pickImageSheetModel = [[CJActionSheetModel alloc] init];
        pickImageSheetModel.title = NSLocalizedString(@"从手机相册选择", nil);
        [sheetModels addObject:pickImageSheetModel];
    }
    
    [CQActionSheetUtil showWithSheetTitle:nil sheetModels:sheetModels showCancel:YES shouldAddPanAction:YES itemClickBlock:^(NSInteger selectIndex) {
        NSLog(@"当前选择的是%zd", selectIndex);
        if (selectIndex == 0) {   //拍照
            UIImagePickerController *imagePickerController = [CQImagePickerControllerFactory takePhotoVC_PickFinishBlock:^(UIImage *image) {
                if (pickCompleteBlock) {
                    pickCompleteBlock(@[image]);
                }
            } pickCancelBlock:^{
                
            }];
            
            UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
            [currentShowingVC presentViewController:imagePickerController animated:YES completion:nil];
            
        } else {
            UINavigationController *nav =
            [CQImagePickerControllerFactory pickMultipleAssetsNavVC_canMaxChooseImageCount:canMaxChooseImageCount pickFinishBlock:^(UINavigationController *bNavVC, NSArray<UIImage *> *images) {
                [bNavVC dismissViewControllerAnimated:YES completion:nil];
                if (pickCompleteBlock) {
                    pickCompleteBlock(images);
                }
            } pickCancelBlock:^(UINavigationController *bNavVC) {
                
            }];
           
            UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
            [currentShowingVC presentViewController:nav animated:YES completion:NULL];
        }
    }];
}


@end
