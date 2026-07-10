//
//  UIView+CQOverlayImageBanned.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  视图中的图片违规的时候，为该视图添加的提示视图（常用于：①直接在图片上；②在包含图片的cell上的等）

#import <UIKit/UIKit.h>
#import "CQImageEnum.h"
#import <CJContainer/CQVerticalImageLabelView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQOverlayImageBanned) {
    
}
@property (nullable, nonatomic, strong) CQVerticalImageLabelView *cqOverlayImageBanned;

/// 只调用一次暂时不放在初始化方法里
- (void)cq_configUIWithBannedSize:(CQBannedSize)bannedSize;

#pragma mark - Update
/// 要显示什么标记，已经初始化的时候就设置cq_configUIWithBannedSize了，所以不用imageUseType
- (void)cq_updateImageStatus:(CQImageStatus)imageStatus;

@end

NS_ASSUME_NONNULL_END
