//
//  CJUploadState.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#ifndef CJUploadState_h
#define CJUploadState_h

typedef NS_ENUM(NSUInteger, CJUploadState) {
    CJUploadStateReady,     /**< 准备上传（默认状态） */
    CJUploadStateUploading, /**< 正上传中 */
    CJUploadStateSuccess,   /**< 成功 */
    CJUploadStateFailure,   /**< 失败 */
};


#endif /* CJUploadState_h */
