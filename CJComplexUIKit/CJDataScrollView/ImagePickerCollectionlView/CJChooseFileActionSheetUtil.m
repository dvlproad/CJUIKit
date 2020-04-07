//
//  CJChooseFileActionSheetUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/6.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJChooseFileActionSheetUtil.h"
#import "TSActionSheetUtil.h"
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@implementation CJChooseFileActionSheetUtil

/*
*  弹出图片选择并进行选择
*
*  @param canMaxChooseImageCount    在允许批量添加的情况下，当前还允许添加的最大值。(默认填1)
*  @param itemClickBlock            选择完图片后执行的操作
*/
+ (void)defaultImageChooseWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                   pickCompleteBlock:(void (^)(NSArray<CJImageUploadFileModelsOwner *> *pickedImageItems))pickImageCompleteBlock
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
    
    [TSActionSheetUtil showWithSheetModels:sheetModels itemClickBlock:^(NSInteger selectIndex) {
        NSLog(@"当前选择的是%zd", selectIndex);
        if (selectIndex == 0) {   //拍照
            UIImagePickerController *imagePickerController = [CJUploadImagePickerUtil takePhotoPickerWithPickCompleteBlock:pickImageCompleteBlock];
            
            if (imagePickerController) {
                UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
                [currentShowingVC presentViewController:imagePickerController animated:YES completion:nil];
            }
            
        } else {
            CJImagePickerViewController *imagePickerController =
            [CJUploadImagePickerUtil choosePhotoPickerWithCanMaxChooseImageCount:canMaxChooseImageCount pickCompleteBlock:pickImageCompleteBlock];
            
            UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imagePickerController];
            nav.navigationBar.barTintColor = [UIColor whiteColor];
            [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:blueTextColor}];
            nav.navigationBar.tintColor = blueTextColor;
            
            UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
            [currentShowingVC presentViewController:nav animated:YES completion:NULL];
        }
    }];
}

@end
