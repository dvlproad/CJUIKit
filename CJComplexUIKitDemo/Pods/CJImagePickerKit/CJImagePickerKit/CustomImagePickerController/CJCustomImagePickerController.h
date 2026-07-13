//
//  CJCustomImagePickerController.h
//  UIKit-ImagePicker-iOS
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  自定义的“图片选择器 CJCustomImagePickerController" (和  UIImagePickerController 一样都是继承于 UINavigationController <NSCoding> )

#import <UIKit/UIKit.h>
#import "CJAlumbImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJCustomImagePickerController : UINavigationController {
    
}
/*
 *  初始化
 *
 *  @param overLimitBlock           超过最大选择图片数量的限制回调(为nil时候，会自动使用默认的提示)
 *  @param clickImageBlock          点击图片执行的事件
 *  @param previewAction            点击底部左侧"预览"执行的事件
 *  @param pickFinishBlock          点击底部右侧"完成"执行的事件
 *  @param pickCancelBlock          点击顶部右侧"取消"执行的事件
 *  @param changePhotoGroupBlock    点击顶部左侧"相册"执行的事件
 *
 *  @return 照片选择器
 */
- (instancetype)initWithOverLimitBlock:(void(^ _Nullable)(NSInteger currentCount, NSInteger maxCount))overLimitBlock
                       clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock
                         previewAction:(void(^)(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels))previewAction
                       pickFinishBlock:(void(^)(UINavigationController *bNavVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels))pickFinishBlock
                       pickCancelBlock:(void(^)(UINavigationController *bNavVC))pickCancelBlock
                 changePhotoGroupBlock:(void(^)(void))changePhotoGroupBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_UNAVAILABLE;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


@end
NS_ASSUME_NONNULL_END
