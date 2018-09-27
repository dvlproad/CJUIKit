//
//  CJUploadMomentState.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#ifndef CJUploadMomentState_h
#define CJUploadMomentState_h

typedef NS_ENUM(NSUInteger, CJUploadMomentState) {
    CJUploadMomentStateReady,     /**< 准备上传（默认状态） */
    CJUploadMomentStateUploading, /**< 正上传中 */
    CJUploadMomentStateSuccess,   /**< 成功 */
    CJUploadMomentStateFailure,   /**< 失败 */
};


#endif /* CJUploadMomentState_h */
