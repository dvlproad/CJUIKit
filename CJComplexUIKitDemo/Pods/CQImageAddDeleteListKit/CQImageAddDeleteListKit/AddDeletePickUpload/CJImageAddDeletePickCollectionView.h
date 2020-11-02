//
//  CJImageAddDeletePickCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  图片 添加+删除+选择+删除 集合视图

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
 *
 *  @return 返回列表
 */
- (instancetype)initWithPickImageCompleteBlock:(void(^)(void))pickImageCompleteBlock
                               pickVideoHandle:(void(^)(void))pickVideoHandle NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithConfigItemCellBlock:(void (^)(CJUploadCollectionViewCell *, id))configItemCellBlock clickItemHandle:(void (^)(NSArray *, NSInteger))clickItemHandle addHandle:(void (^)(CJImageAddDeleteCollectionView *))addHandle otherItemCellDeleteBlock:(void (^)(id))otherItemCellDeleteBlock NS_UNAVAILABLE;


@end
