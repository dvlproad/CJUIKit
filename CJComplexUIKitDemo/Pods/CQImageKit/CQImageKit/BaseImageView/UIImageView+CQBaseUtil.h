//
//  UIImageView+CQBaseUtil.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQImageEnum.h"
#import "CQImageBusinessEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CQBaseUtil)
#pragma mark - 设置图片的基础接口
#pragma mark 设置图片：设置网络图片
/*
 *  为UIImageView设置网络图片
 *
 *  @param imageUrl             该网络图片的地址
 *  @param imageStatus          该网络图片的违规状态
 *  @param imageUseType         图片的使用场景（不同场景会有不同的占位图和失败图）
 *  @param dealType             要处理(缩放或裁剪等）的方式
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
- (void)cq_setImageWithUrl:(NSString *)imageUrl
               imageStatus:(CQImageStatus)imageStatus
              imageUseType:(CQImageUseType)imageUseType
                  dealType:(CQImageViewDealType)dealType
                 completed:(void(^ _Nullable)(UIImage * _Nullable bDealImage, NSURL * _Nullable imageURL))completedBlock;

@end

NS_ASSUME_NONNULL_END
