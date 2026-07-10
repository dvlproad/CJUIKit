//
//  CQStatusImageModel.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  网络图片的基础模型（必含imageUrl,根据情况可能还会有图片的违规状态imageStatus，有时候还会有imageId，有时候不需要imageId，而是直接通过imageUrl来判断是否是同一张图片）

#import <Foundation/Foundation.h>
#import "CQImageEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQStatusImageModel : NSObject {
    
}
@property (nullable, nonatomic, copy) NSString *imageUrl;     /** 图片的网络地址 */ //TODO:添加readonly后，获取用户详情的相片地址会取不到
@property (nonatomic, assign) CQImageStatus imageStatus;      /**< 图片的违规状态 */

#pragma mark - Init
- (instancetype)initWithImageUrl:(NSString *)imageUrl imageStatus:(CQImageStatus)imageStatus;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Update
/*
 *  更新图片状态（使用于：有些图片在上传到阿里云oss后，得到的地址并不一定能立马知道是否违规，而是只有在使用该地址，进行其他业务的时候，才发现该图片是违规状态）
 *
 *  @param imageStatus  图片的违规状态
 */
- (void)updateImageStatus:(CQImageStatus)imageStatus;

#pragma mark - Simulation模拟数据
/// 测试图片被banned
- (void)testBanned;

@end

NS_ASSUME_NONNULL_END
