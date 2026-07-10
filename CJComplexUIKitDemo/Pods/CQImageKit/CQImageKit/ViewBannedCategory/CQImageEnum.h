//
//  CQImageEnum.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#ifndef CQImageEnum_h
#define CQImageEnum_h

/** 照片状态（后台已经约定） */
typedef NS_ENUM(NSUInteger, CQPhotoStatus) {
    CQPhotoStatusVerify = 0,    /** 审核中 */
    CQPhotoStatusPass = 10,     /** 审核通过 */
//    CQPhotoStatusBanned,        /** 审核结果为违规的照片 */ // 暂时没有把 CQPhotoStatus 和 CQImageStatus 统一到一个
};

/** 图片违规状态（本地按照后台的bool来自己约定） */
typedef NS_ENUM(NSUInteger, CQImageStatus) {
    CQImageStatusActive = 0,        /** 正常状态 */
    CQImageStatusBanned = 1,        /** 封禁照片 */
};

/** 图片违规是否的违规标记大小 */
typedef NS_ENUM(NSUInteger, CQBannedSize) {
    CQBannedSizeNone = 0,   /**< 默认，不需要违规标记（如头像违规的话，只使用默认的头像失败图，例外个人中心会还有违规标记） */
    CQBannedSizeBig = 1,    /**< 大 */
    CQBannedSizeMiddle,     /**< 中 */
    CQBannedSizeSmall,      /**< 小 */
};

#endif /* CQImageEnum_h */
