//
//  CQImageBusinessEnum.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  图片的业务场景

#ifndef CQImageBusinessEnum_h
#define CQImageBusinessEnum_h

typedef NS_ENUM(NSUInteger, CQImageViewDealType) {
    CQImageViewDealTypeDefault = 0,         /**< 默认，不做任何处理，直接拿原图 */
    CQImageViewDealTypeScaleAspectFit,      /**< 缩放方式：等比缩放并完全显示 */
    CQImageViewDealTypeScaleAspectFill,     /**< 缩放方式：等比所犯并铺满视图 */
    
    /**< 裁剪方式1：判断是否太宽(ratio>1/1.0)或太高(ratio<343/580.0)；太宽则使用1/1.0，太高也使用343/580.0，不太宽也不太高使用1/1.0（注意不是使用原比例） */
    CQImageViewDealTypeCutTypeOne,
    
    /**< 裁剪方式2：判断是否太宽(ratio>4/3.0)或太高(ratio<343/580.0)；太宽则使用4/3.0，太高则使用343/580.0，不太宽也不太高使用原比例 */
    CQImageViewDealTypeCutTypeTwo,
};

/**
 *  图片的使用场景类型
 *  （违规标记不需要加入此参数，而是在每个界面初始化时候的时候就确认自己的CQBannedSize，如不需要的时候传CQBannedSizeNone）
 */
typedef NS_ENUM(NSUInteger, CQImageUseType) {
    CQImageUseTypeDefault = 0,              /**< 默认（违规时候：只有默认图+没有标记） */
    CQImageUseTypeAvatar,                   /**< 头像（违规时候：默认图+标记） */
    CQImageUseTypePhotoInImageList,         /**< 相片：表编辑页面的头像和相片列表（非头像，加载时候和加载失败白色） */
    CQImageUseTypePhotoInDetail,            /**< 相片（非头像，加载时候和加载失败都不需要占位图） */
    CQImageUseTypeGradientBG,               /**< 渐变背景：基础卡的卡片背景 */
    CQImageUseTypeGradientBGForTextCard,    /**< 渐变背景：说说卡的卡片背景 */
    CQImageUseTypeGradientBGForVoiceCard,   /**< 渐变背景：声音卡的卡片背景 */
    CQImageUseTypeGradientBGForPhotoCard,   /**< 渐变背景：拍拍卡的卡片背景 */
};

#endif /* CQImageBusinessEnum_h */
