////
////  CQImagePickerControllerFactory.m
////  CJPickerDemo
////
////  Created by ciyouzen on 2017/8/30.
////  Copyright © 2017年 dvlproad. All rights reserved.
////
//
//#import "CQImagePickerControllerFactory.h"
//
//@implementation CQImagePickerControllerFactory
//
//#pragma mark - 拍摄照片 的视图控制器
//
///*
// *  从相册中选择照片 的照片选择器(可多选)
// *
// *  @param canMaxChooseImageCount   最多可选择多少张的回调
// *  @param pickFinishBlock          选择结束的回调
// */
//+ (CJImagePickerViewController *)pickMultipleAssetsVC_canMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
//                                                             pickFinishBlock:(void (^)(NSArray<UIImage *> *image))pickFinishBlock
//{
//    CJImagePickerViewController *imagePickerViewController = [CQImagePickerControllerFactory pickMultipleAssetsVC_canMaxChooseImageCount:9 pickFinishBlock:^(NSArray<UIImage *> *image) {
//        [imagePickerViewController dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    return imagePickerViewController;
//    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
//    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imagePickerViewController];
//    nav.navigationBar.barTintColor = [UIColor whiteColor];
//    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:blueTextColor}];
//    nav.navigationBar.tintColor = blueTextColor;
////
////    [self presentViewController:imagePickerViewController animated:YES completion:NULL];
////}
//
//
//@end
