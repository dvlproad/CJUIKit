//
//  CJCustomImagePickerViewController.h
//  UIKit-ImagePicker-iOS
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "CJAlumbImageModel.h"

#import "CJAlumbSectionDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CJDealSelectedImageModelsBlock)(NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels);

/**
 *  自定义的“图片选择器CJCustomImagePickerViewController”
 */
@interface CJCustomImagePickerViewController : UIViewController {
    
}
@property (nonatomic, assign) NSInteger canMaxChooseImageCount;     /**< 可一次性选取的最大数目 */
@property (nonatomic, copy) void (^pickCompleteBlock)(NSArray<CJAlumbImageModel *> *imageModels);    /**< 照片选取完毕后 */



@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *assets;


/*
 *  初始化
 *
 *  @param overLimitBlock       超过最大选择图片数量的限制回调(为nil时候，会自动使用默认的提示)
 *  @param clickImageBlock      点击图片执行的事件
 *  @param previewAction        点击底部左侧"预览"执行的事件
 *  @param pickFinishBlock      点击底部右侧"完成"执行的事件
 *
 *  @return 照片选择器
 */
- (instancetype)initWithOverLimitBlock:(void(^)(NSInteger currentCount, NSInteger maxCount))overLimitBlock
                       clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock
                         previewAction:(void(^)(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels))previewAction
                       pickFinishBlock:(void(^)(UIViewController *bVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels))pickFinishBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)hcRefreshViewDidDataUpdated;



@end
NS_ASSUME_NONNULL_END
