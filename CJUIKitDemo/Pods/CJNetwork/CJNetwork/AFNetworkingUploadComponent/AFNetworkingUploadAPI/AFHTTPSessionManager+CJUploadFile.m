//
//  AFHTTPSessionManager+CJUploadFile.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/10/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJUploadFile.h"

@implementation AFHTTPSessionManager (CJUploadFile)

#pragma mark - 上传文件请求的接口
/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)params
                                            fileKey:(nullable NSString *)fileKey
                                     fileValueOwner:(nullable CJUploadFileModelsOwner *)fileValueOwner
                        uploadMomentInfoChangeBlock:(nullable void(^)(CJUploadFileModelsOwner * _Nonnull momentInfoOwner))uploadMomentInfoChangeBlock
               getUploadMomentInfoFromResopnseBlock:(nullable CJUploadMomentInfo * _Nonnull (^)(id _Nonnull responseObject))getUploadMomentInfoFromResopnseBlock;
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
    [self cj_postUploadUrl:Url params:params fileKey:fileKey fileValue:fileValueOwner.uploadFileModels progress:uploadingBlock success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        if (getUploadMomentInfoFromResopnseBlock) {
            CJUploadMomentInfo *momentInfo = getUploadMomentInfoFromResopnseBlock(responseObject);
            uploadCompleteBlock(momentInfo);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CJUploadMomentInfo *momentInfo = [[CJUploadMomentInfo alloc] init];
        momentInfo.responseModel = nil;
        momentInfo.uploadState = CJUploadMomentStateFailure;
        momentInfo.uploadStatePromptText = NSLocalizedString(@"点击重传", nil);
        
        uploadCompleteBlock(momentInfo);
        
        NSLog(@"error: %@", [error localizedDescription]);
    }];
    
    return URLSessionDataTask;
}

/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)parameters
                                            fileKey:(nullable NSString *)fileKey
                                          fileValue:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                            success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
                                            failure:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error))failure
{
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        for (CJUploadFileModel *uploadFileModel in uploadFileModels) {
            NSData *data = uploadFileModel.uploadItemData;
            NSString *fileName = uploadFileModel.uploadItemName;
            
            switch (uploadFileModel.uploadItemType) {
                case CJUploadItemTypeImage:
                {
                    if (!data) {
                        NSLog(@"Error：上传的图片数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"image/jpeg"];
                    break;
                }
                case CJUploadItemTypeSound:
                {
                    if (!data) {
                        NSLog(@"Error：上传的语音数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"audio/mpeg3"];
                    break;
                }
                case CJUploadItemTypeAttach:
                {
                    if (!data) {
                        NSLog(@"Error：上传的附件数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:@"application/octet-stream"];
                    break;
                }
                default:
                {
                    break;
                }
            }
        }
        
    } progress:uploadProgress success:success failure:failure];
    
    return URLSessionDataTask;
}


@end
