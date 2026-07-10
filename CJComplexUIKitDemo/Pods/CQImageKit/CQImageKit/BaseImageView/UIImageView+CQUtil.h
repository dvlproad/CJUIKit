//
//  UIImageView+CQUtil.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQImageEnum.h"
#import "CQImageBusinessEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CQUtil)

#pragma mark - 设置图片：设置网络图片
/// 为UIImageView设置网络图片
- (void)cq_setImageWithUrl:(NSString *)imageUrl;

/// 为头像视图设置头像图片（独立接口，因为头像的占位图和失败图有别于其他类型）：有些cell可能有时候是头像图片，有时候不是，如发现页顶部的collectionViewCell
- (void)cq_setAvatarImageWithUrl:(NSString *)imageUrl;

#pragma mark - 卡片详情列表
/// 为卡片详情列表的cell设置网络图片（如果最终得到的图片是空，则还需要将该区域的高度设置为0）
- (void)cq_setImageForCardWithUrl:(NSString *)imageUrl completed:(void(^ _Nonnull)(BOOL isRealExistImage))completedBlock;

#pragma mark - 卡片背景
/// 为卡片背景UIImageView设置网络图片
- (void)cq_setGradientImageWithUrl:(NSString *)imageUrl;


@end

NS_ASSUME_NONNULL_END
