//
//  CJImagePickerTableView.h
//  CJPickerDemo
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


/**
 *  自定义的“图片选择器CJImagePickerViewController”
 */
@interface CJImagePickerTableView : UITableView {
    
}
@property (nonatomic, assign) NSInteger canMaxChooseImageCount;     /**< 可一次性选取的最大数目 */
@property (nonatomic, strong) NSMutableArray<CJAlumbImageModel *> *selectedArray;    /**< 当前选择的图片 */


/*
 *  初始化
 *
 *  @param selectedCountChangeBlock     选中的照片发生变化的回调
 *  @param overLimitBlock               超过最大选择图片数量的限制回调
 *  @param clickImageBlock              点击图片执行的事件
 *
 *  @return 照片列表
 */
- (instancetype)initWithSelectedCountChangeBlock:(void(^)(NSMutableArray<CJAlumbImageModel *> *bSelectedArray))selectedCountChangeBlock
                                  overLimitBlock:(void(^)(void))overLimitBlock
                                 clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


#pragma mark - Event
- (void)reloadWithData:(NSArray<CJAlumbImageModel *> *)currentGroupAssetModels;

@end
