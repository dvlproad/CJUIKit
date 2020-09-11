//
//  CJImageAddDeletePickCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CJMedia/CJImageUploadFileModelsOwner.h>
#import <CJMedia/CJVideoUploadFileModelsOwner.h>

#import "CJImageAddDeleteCollectionView.h"

typedef NS_ENUM(NSUInteger, CJMediaType) {
    CJMediaTypeImage = 0,
    CJMediaTypeVideo
};


@interface CJImageAddDeletePickCollectionView : CJImageAddDeleteCollectionView <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
}



@property (nonatomic, assign) CJMediaType mediaType;

/*
 *  初始化方法
 *
 *  @param pickImageCompleteBlock       选择完图片后的操作
 *  @param pickVideoHandle              开始操作视频的操作
 *  @param otherItemCellConfigBlock    itemCell的其他属性如上传进度的设置方法(一般为nil)
 *  @param otherItemCellDeleteBlock  itemCell的其他属性如删除照片后，还要执行取消之前没结束的上传请求方法(一般为nil)
 *
 *  @return 返回
 */
- (instancetype)initWithPickImageCompleteBlock:(void(^)(void))pickImageCompleteBlock
                               pickVideoHandle:(void(^)(void))pickVideoHandle
                      otherItemCellConfigBlock:(void (^)(CJUploadCollectionViewCell *bItemCell, CJImageUploadFileModelsOwner *bDataModel))otherItemCellConfigBlock
                      otherItemCellDeleteBlock:(void(^)(CJImageUploadFileModelsOwner *bDataModel))otherItemCellDeleteBlock;



@end
