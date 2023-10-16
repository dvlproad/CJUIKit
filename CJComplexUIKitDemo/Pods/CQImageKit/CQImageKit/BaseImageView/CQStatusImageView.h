//
//  CQStatusImageView.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  有状态的（如被禁状态的）图片

#import "CQBaseImageView.h"
#import "CQImageEnum.h"
#import "CQImageBusinessEnum.h"
#import "CQStatusImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQStatusImageView : CQBaseImageView {
    
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param bannedSize        被禁类型的大小
 *
 *  @return imageView
 */
- (instancetype)initWithBannedSize:(CQBannedSize)bannedSize NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithImage:(nullable UIImage *)image NS_UNAVAILABLE;
- (instancetype)initWithImage:(nullable UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage NS_UNAVAILABLE;

#pragma mark - Update UI
/*
 *  更新被禁时候的违规标记视图的有、无及大小等
 *
 *  @param bannedSize        被禁类型的大小
 */
- (void)updateBannedSize:(CQBannedSize)bannedSize;
- (void)cq_configUIWithBannedSize:(CQBannedSize)bannedSize NS_UNAVAILABLE;

#pragma mark - Update Data
/*
 *  更新图片视图的数据和状态信息
 *
 *  @param imageModel       图片的信息（含网络地址、违规状态）
 *  @param imageUseType     图片的使用场景类型(常见于cell中)
 */
- (void)updateImageWithNetImageModel:(CQStatusImageModel *)imageModel imageUseType:(CQImageUseType)imageUseType;

- (void)setImage:(nullable UIImage *)image NS_UNAVAILABLE;
- (void)updateImage:(nullable UIImage *)image imageStatus:(CQImageStatus)imageStatus;

#pragma mark - Private Method
/// 只更新图片，不更新状态（防止状态出错，只使用在子类中，其他方法不使用）
- (void)_onlyUpdateImage:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
