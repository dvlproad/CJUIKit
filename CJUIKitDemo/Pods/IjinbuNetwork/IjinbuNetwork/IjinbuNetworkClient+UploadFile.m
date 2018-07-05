//
//  IjinbuNetworkClient+UploadFile.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient+UploadFile.h"
#import "IjinbuHTTPSessionManager.h"

#ifdef CJTESTPOD
#import "AFHTTPSessionManager+CJUploadFile.h"
#else
#import <CJNetwork/AFHTTPSessionManager+CJUploadFile.h>
#endif

#import "IjinbuUploadItemResult.h"


@implementation IjinbuNetworkClient (UploadFile)

/* 完整的描述请参见文件头部 */
- (nullable NSURLSessionDataTask *)ijinbu_multiUploadFileWithParams:(nullable id)params
                                                   uploadFileModels:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                                      completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock
{
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *Url = API_BASE_Url_ijinbu(@"ijinbu/app/public/batchUpload");
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", params);
    
    return [manager cj_postUploadUrl:Url params:params fileKey:@"file" fileValue:uploadFileModels progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = [responseObject[@"status"] integerValue];
        responseModel.message = responseObject[@"msg"];
        responseModel.result = responseObject[@"result"];
        if (completeBlock) {
            completeBlock(responseModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = -1;
        responseModel.message = NSLocalizedString(@"网络请求失败", nil);
        responseModel.result = nil;
        if (completeBlock) {
            completeBlock(responseModel);
        }
    }];
}


/* 完整的描述请参见文件头部 */
+ (NSURLSessionDataTask *)detailedRequestUploadItems:(NSArray<CJUploadFileModel *> *)uploadFileModels
                                             toWhere:(NSInteger)toWhere
                             andsaveUploadInfoToItem:(CJUploadFileModelsOwner *)saveUploadInfoToItem
                               uploadInfoChangeBlock:(void(^)(CJUploadFileModelsOwner *item))uploadInfoChangeBlock {
    
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *Url = API_BASE_Url_ijinbu(@"ijinbu/app/public/batchUpload");
    NSDictionary *parameters = @{@"uploadType": @(toWhere)};
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", parameters);
    
    /* 从请求结果response中获取momentInfo的代码块 */
    CJUploadMomentInfo *(^getUploadMomentInfoFromResopnseBlock)(id responseObject) = ^CJUploadMomentInfo *(id responseObject)
    {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = [responseObject[@"status"] integerValue];
        responseModel.message = responseObject[@"msg"];
        responseModel.result = responseObject[@"result"];
        
        CJUploadMomentInfo *momentInfo = [[CJUploadMomentInfo alloc] init];
        momentInfo.responseModel = responseModel;
        if (responseModel.status == 1) {
            NSMutableArray<NSDictionary *> *dictionarys = responseModel.result;
            
            NSMutableArray<IjinbuUploadItemResult *> *operationUploadResult = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionary in dictionarys) {
                IjinbuUploadItemResult *itemResult = [[IjinbuUploadItemResult alloc] initWithHisDictionary:dictionary];
                [operationUploadResult addObject:itemResult];
            }
        
            
            if (operationUploadResult == nil || operationUploadResult.count == 0) {
                momentInfo.uploadState = CJUploadMomentStateFailure;
                momentInfo.uploadStatePromptText = @"点击重传";
                
            } else {
                BOOL findFailure = NO;
                for (IjinbuUploadItemResult *uploadItemResult in operationUploadResult) {
                    NSString *networkUrl = uploadItemResult.networkUrl;
                    if (networkUrl == nil || [networkUrl length] == 0) {
                        NSLog(@"Failure:文件上传后返回的网络地址为空");
                        findFailure = YES;
                        
                    }
                }
                
                if (findFailure) {
                    momentInfo.uploadState = CJUploadMomentStateFailure;
                    momentInfo.uploadStatePromptText = @"点击重传";
                    
                } else {
                    momentInfo.uploadState = CJUploadMomentStateSuccess;
                    momentInfo.uploadStatePromptText = @"上传成功";
                }
            }
            
        } else if (responseModel.status == 2) {
            momentInfo.uploadState = CJUploadMomentStateFailure;
            momentInfo.uploadStatePromptText = responseModel.message;
            
        } else {
            momentInfo.uploadState = CJUploadMomentStateFailure;
            momentInfo.uploadStatePromptText = @"点击重传";
        }
        
        return momentInfo;
    };
    
    
    NSURLSessionDataTask *operation =
    [manager cj_postUploadUrl:Url
                       params:parameters
                      fileKey:@"file"
               fileValueOwner:saveUploadInfoToItem
  uploadMomentInfoChangeBlock:uploadInfoChangeBlock
getUploadMomentInfoFromResopnseBlock:getUploadMomentInfoFromResopnseBlock];
    
    return operation;
}

@end
