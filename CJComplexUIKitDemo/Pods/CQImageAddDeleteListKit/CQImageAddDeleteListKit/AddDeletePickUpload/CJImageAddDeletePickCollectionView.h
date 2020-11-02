//
//  CJImageAddDeletePickCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

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
                               pickVideoHandle:(void(^)(void))pickVideoHandle;



@end
