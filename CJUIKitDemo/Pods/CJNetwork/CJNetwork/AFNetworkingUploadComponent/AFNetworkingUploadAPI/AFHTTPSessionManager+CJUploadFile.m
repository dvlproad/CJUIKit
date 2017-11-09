//
//  AFHTTPSessionManager+CJUploadFile.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/10/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AFHTTPSessionManager+CJUploadFile.h"

@implementation AFHTTPSessionManager (CJUploadFile)

- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                         parameters:(nullable id)parameters
                                        uploadItems:(nullable NSArray<CJUploadItemModel *> *)uploadItems
                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                            success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success
                                            failure:(nullable void (^)(NSURLSessionDataTask *_Nonnull, NSError *_Nonnull))failure
{
    NSURLSessionDataTask *URLSessionDataTask =
    [self POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        for (CJUploadItemModel *uploadItemModel in uploadItems) {
            NSData *data = uploadItemModel.uploadItemData;
            NSString *fileName = uploadItemModel.uploadItemName;
            
            switch (uploadItemModel.uploadItemType) {
                case CJUploadItemTypeImage:
                {
                    if (!data) {
                        NSLog(@"Error：上传的图片数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                    break;
                }
                case CJUploadItemTypeSound:
                {
                    if (!data) {
                        NSLog(@"Error：上传的语音数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"audio/mpeg3"];
                    break;
                }
                case CJUploadItemTypeAttach:
                {
                    if (!data) {
                        NSLog(@"Error：上传的附件数据不能为空");
                    }
                    [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"application/octet-stream"];
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
