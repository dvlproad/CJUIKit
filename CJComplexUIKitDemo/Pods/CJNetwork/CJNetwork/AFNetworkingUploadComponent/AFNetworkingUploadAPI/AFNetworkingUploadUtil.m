//
//  AFNetworkingUploadUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "AFNetworkingUploadUtil.h"

@implementation AFNetworkingUploadUtil

#pragma mark - 上传文件请求的接口
/* 完整的描述请参见文件头部 */
+ (NSURLSessionDataTask *)cj_UseManager:(AFHTTPSessionManager *)manager
                          postUploadUrl:(NSString *)Url
                             parameters:(id)parameters
                       uploadFileModels:(NSArray<CJUploadFileModel *> *)uploadFileModels
                   uploadInfoSaveInItem:(CJBaseUploadItem *)saveUploadInfoToItem
                  uploadInfoChangeBlock:(void(^)(CJBaseUploadItem *saveUploadInfoToItem))uploadInfoChangeBlock
         dealResopnseForUploadInfoBlock:(CJUploadInfo * (^)(id responseObject))dealResopnseForUploadInfoBlock
{
    __weak typeof(saveUploadInfoToItem)weakItem = saveUploadInfoToItem;
    
    
    
    /* 正在上传 */
    void (^uploadingBlock)(NSProgress *progress) = ^ (NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakItem)strongItem = weakItem;
            
            CJUploadInfo *uploadInfo = [[CJUploadInfo alloc] init];
            uploadInfo.uploadState = CJUploadStateUploading;
            CGFloat progressValue = progress.fractionCompleted * 100;
            uploadInfo.uploadStatePromptText = [NSString stringWithFormat:@"%.0lf%%", progressValue];
            uploadInfo.progressValue = progressValue;
            
            strongItem.uploadInfo = uploadInfo;
            
            if (uploadInfoChangeBlock) {
                uploadInfoChangeBlock(strongItem);
            }
        });
    };
    
    /* 上传完成 */
    void (^uploadCompleteBlock)(CJUploadInfo *uploadInfo) = ^ (CJUploadInfo *uploadInfo) {
        __strong __typeof(weakItem)strongItem = weakItem;
        strongItem.uploadInfo = uploadInfo;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uploadInfoChangeBlock) {
                uploadInfoChangeBlock(strongItem);
            }
        });
    };
    
    
    return [manager cj_postUploadUrl:Url parameters:parameters uploadFileModels:uploadFileModels progress:uploadingBlock success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        if (dealResopnseForUploadInfoBlock) {
            CJUploadInfo *uploadInfo = dealResopnseForUploadInfoBlock(responseObject);
            uploadCompleteBlock(uploadInfo);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CJUploadInfo *uploadInfo = [[CJUploadInfo alloc] init];
        uploadInfo.responseModel = nil;
        uploadInfo.uploadState = CJUploadStateFailure;
        uploadInfo.uploadStatePromptText = NSLocalizedString(@"点击重传", nil);
        
        uploadCompleteBlock(uploadInfo);
        
        NSLog(@"error: %@", [error localizedDescription]);
    }];
}


@end
