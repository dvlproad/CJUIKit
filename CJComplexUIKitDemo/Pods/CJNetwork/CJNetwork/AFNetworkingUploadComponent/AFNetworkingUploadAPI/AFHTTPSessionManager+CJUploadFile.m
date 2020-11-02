//
//  AFHTTPSessionManager+CJUploadFile.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/10/5.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJUploadFile.h"

@implementation AFHTTPSessionManager (CJUploadFile)

#pragma mark - 上传文件请求的接口
/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_uploadUrl:(NSString *)Url
                                      urlParams:(nullable id)urlParams
                                     formParams:(nullable id)formParams
                                        headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                        logType:(CJRequestLogType)logType
                                 fileValueOwner:(nullable CJUploadFileModelsOwner *)fileValueOwner
                    uploadMomentInfoChangeBlock:(nullable void(^)(CJUploadFileModelsOwner * _Nonnull momentInfoOwner))uploadMomentInfoChangeBlock
           getUploadMomentInfoFromResopnseBlock:(nullable CJUploadMomentInfo * _Nonnull (^)(id _Nonnull responseObject))getUploadMomentInfoFromResopnseBlock
{
    __weak typeof(fileValueOwner)weakFileValueOwner = fileValueOwner;
    
    /* 正在上传 */
    void (^uploadingBlock)(NSProgress *progress) = ^ (NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakFileValueOwner)strongFileValueOwner = weakFileValueOwner;
            
            CJUploadMomentInfo *momentInfo = [[CJUploadMomentInfo alloc] init];
            momentInfo.uploadState = CJUploadMomentStateUploading;
            CGFloat progressValue = progress.fractionCompleted * 100;
            momentInfo.uploadStatePromptText = [NSString stringWithFormat:@"%.0lf%%", progressValue];
            momentInfo.progressValue = progressValue;
            
            strongFileValueOwner.momentInfo = momentInfo;
            
            if (uploadMomentInfoChangeBlock) {
                uploadMomentInfoChangeBlock(strongFileValueOwner);
            }
        });
    };
    
    /* 上传完成 */
    void (^uploadCompleteBlock)(CJUploadMomentInfo *momentInfo) = ^ (CJUploadMomentInfo *momentInfo) {
        __strong __typeof(weakFileValueOwner)strongFileValueOwner = weakFileValueOwner;
        strongFileValueOwner.momentInfo = momentInfo;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uploadMomentInfoChangeBlock) {
                uploadMomentInfoChangeBlock(strongFileValueOwner);
            }
        });
    };
    
    
    NSURLSessionDataTask *URLSessionDataTask =
    [self cj_uploadUrl:Url urlParams:urlParams formParams:formParams headers:headers uploadFileModels:fileValueOwner.uploadFileModels cacheSettingModel:cacheSettingModel logType:logType progress:uploadingBlock success:^(CJSuccessRequestInfo * _Nullable successRequestInfo) {
        if (getUploadMomentInfoFromResopnseBlock) {
            CJUploadMomentInfo *momentInfo = getUploadMomentInfoFromResopnseBlock(successRequestInfo.responseObject);
            uploadCompleteBlock(momentInfo);
        }
        
    } failure:^(CJFailureRequestInfo * _Nullable failureRequestInfo) {
        CJUploadMomentInfo *momentInfo = [[CJUploadMomentInfo alloc] init];
        momentInfo.responseModel = nil;
        momentInfo.uploadState = CJUploadMomentStateFailure;
        momentInfo.uploadStatePromptText = NSLocalizedString(@"点击重传", nil);
        
        uploadCompleteBlock(momentInfo);
        
        NSLog(@"error: %@", [failureRequestInfo.error localizedDescription]);
    }];
    
    return URLSessionDataTask;
}


/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_uploadUrl:(NSString *)Url
                                      urlParams:(nullable id)urlParams
                                     formParams:(nullable id)formParams
                                        headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               uploadFileModels:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                        logType:(CJRequestLogType)logType
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        success:(nullable void (^)(CJSuccessRequestInfo * _Nullable successRequestInfo))success
                                        failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure
{
    if (urlParams) {
        Url = [self __appendUrl:Url withParams:urlParams];
    }
    
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:formParams headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        for (CJUploadFileModel *uploadFileModel in uploadFileModels) {
            NSData *data = uploadFileModel.uploadItemData;
            NSString *fileName = uploadFileModel.uploadItemName;
            NSString *fileKey = uploadFileModel.uploadItemKey;
            
            switch (uploadFileModel.uploadItemType) {
                case CJUploadItemTypeImage:
                {
                    if (!data) {
                        NSLog(@"Error：上传的图片数据不能为空");
                    } else {
                        [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"image/jpeg"];
                    }
                    break;
                }
                case CJUploadItemTypeSound:
                {
                    if (!data) {
                        NSLog(@"Error：上传的语音数据不能为空");
                    } else {
                        [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"audio/mpeg3"];
                    }
                    break;
                }
                case CJUploadItemTypeAttach:
                {
                    if (!data) {
                        NSLog(@"Error：上传的附件数据不能为空");
                    } else {
                        [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"application/octet-stream"];
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
        }
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self __didRequestSuccessForTask:task withResponseObject:responseObject isCacheData:NO forUrl:Url params:formParams cacheSettingModel:cacheSettingModel logType:logType success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self __didRequestFailureForTask:task withResponseError:error forUrl:Url params:formParams logType:logType failure:failure];
    }];
    
    return URLSessionDataTask;
}


@end
