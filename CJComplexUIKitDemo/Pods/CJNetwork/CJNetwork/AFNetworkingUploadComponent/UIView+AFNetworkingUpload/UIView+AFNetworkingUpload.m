//
//  UIView+AFNetworkingUpload.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/8/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+AFNetworkingUpload.h"

@implementation UIView (AFNetworkingUpload)

/* 完整的描述请参见文件头部 */
- (void)cjConfigureUploadProgressView:(CJUploadProgressView *)uploadProgressView
           withUploadRequestByManager:(AFHTTPSessionManager *)manager
                                  Url:(NSString *)Url
                               params:(id)params
                              fileKey:(NSString *)fileKey
                       fileValueOwner:(CJUploadFileModelsOwner *)fileValueOwner
          uploadMomentInfoChangeBlock:(void(^)(CJUploadFileModelsOwner *momentInfoOwner))uploadMomentInfoChangeBlock
 getUploadMomentInfoFromResopnseBlock:(CJUploadMomentInfo * (^)(id responseObject))getUploadMomentInfoFromResopnseBlock
{
    
    NSURLSessionDataTask *operation = fileValueOwner.operation;
    if (operation == nil) {
        operation =
        [manager cj_postUploadUrl:Url
                           params:params
                          fileKey:fileKey
                   fileValueOwner:fileValueOwner
      uploadMomentInfoChangeBlock:uploadMomentInfoChangeBlock
getUploadMomentInfoFromResopnseBlock:getUploadMomentInfoFromResopnseBlock];
        
        fileValueOwner.operation = operation;
    }
    
    
    //cjReUploadHandle
    __weak typeof(fileValueOwner)weakFileValueOwner = fileValueOwner;
    [uploadProgressView setCjReUploadHandle:^(UIView *uploadProgressView) {
        __strong __typeof(weakFileValueOwner)strongFileValueOwner = weakFileValueOwner;
        
        [strongFileValueOwner.operation cancel];
        
        NSURLSessionDataTask *newOperation =
        [manager cj_postUploadUrl:Url
                           params:params
                          fileKey:fileKey
                   fileValueOwner:fileValueOwner
      uploadMomentInfoChangeBlock:uploadMomentInfoChangeBlock
getUploadMomentInfoFromResopnseBlock:getUploadMomentInfoFromResopnseBlock];
        
        strongFileValueOwner.operation = newOperation;
    }];
    
    
    CJUploadMomentInfo *momentInfo = fileValueOwner.momentInfo;
    [uploadProgressView updateProgressText:momentInfo.uploadStatePromptText progressVaule:momentInfo.progressValue];//调用此方法避免reload时候显示错误
}

@end
