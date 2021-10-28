//
//  UIImageView+CQTSBaseUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CQTSBaseUtil)
#pragma mark - 设置图片的基础接口
#pragma mark 设置图片：设置网络图片
/*
 *  为UIImageView设置网络图片
 *
 *  @param imageUrl             该网络图片的地址
 *  @param completed            设置完成的回调(返回的图片是将imageUrl得到的图片根据指定的方式处理后的图)
 */
- (void)cqdm_setImageWithUrl:(NSString *)imageUrl
                   completed:(void(^ _Nullable)(UIImage * _Nullable bDealImage, NSURL * _Nullable imageURL))completedBlock;

@end

NS_ASSUME_NONNULL_END
