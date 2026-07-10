//
//  CQAvatarImageView.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  头像违规需求：表头像存在违规的可能，里头像都是后台提供的选择
//  他人头像违规：只使用默认的头像失败图，自己的头像根据情况使用头像失败图+可能还会有的违规标记
//  自己头像违规：除个人中心首页、个人资料编辑页、个人资料详情页，使用头像失败图+违规标记；其他情况，如在发现模块，消息部分，全部只使用默认的头像失败图

#import "CQStatusImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQAvatarImageView : CQStatusImageView {
    
}
@property (nullable, nonatomic, copy) void(^clickHandle)(void);     /**< 头像的点击（有需要才设置） */

#pragma mark - Init
/*
 *  初始化【有圆角的】头像视图
 *
 *  @param size         头像的大小，用于设置圆角(宽高1:1)
 *  @param borderWidth  头像的边框(可以为0)
 *  @param bannedSize   头像违规时候的违规标记大小（规则详看.h顶部描述）
 *
 *  @return 【有圆角的】头像视图
 */
- (instancetype)initWithSize:(CGFloat)size borderWidth:(CGFloat)borderWidth bannedSize:(CQBannedSize)bannedSize;
/*
 *  初始化【无圆角的】头像视图：场景：该视图常为其他视图的背景
 *
 *  @param frame        frame
 *  @param bannedSize   头像违规时候的违规标记大小（规则详看.h顶部描述）
 *
 *  @return 【无圆角的】头像视图
 */
- (instancetype)initWithFrame:(CGRect)frame bannedSize:(CQBannedSize)bannedSize NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithBannedSize:(CQBannedSize)bannedSize NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


#pragma mark - Update
- (void)updateImageWithNetImageModel:(CQStatusImageModel *)imageModel;
- (void)updateImageWithNetImageModel:(CQStatusImageModel *)imageModel imageUseType:(CQImageUseType)imageUseType NS_UNAVAILABLE;
- (void)updateImage:(nullable UIImage *)image imageStatus:(CQImageStatus)imageStatus NS_UNAVAILABLE; // 头像都是网络图

@end

NS_ASSUME_NONNULL_END
