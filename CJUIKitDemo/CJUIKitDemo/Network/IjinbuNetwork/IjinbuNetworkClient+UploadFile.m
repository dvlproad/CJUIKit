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
#import "AFNetworkingUploadUtil.h"
#else
#import <CJNetwork/AFNetworkingUploadUtil.h>
#endif

#import "IjinbuUploadItemResult.h"

@implementation IjinbuNetworkClient (UploadFile)

/** 多个文件上传 */
- (NSURLSessionDataTask *)requestUploadItems:(NSArray<CJUploadFileModel *> *)uploadFileModels
                                     toWhere:(NSInteger)uploadItemToWhere
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock
{
    IjinbuUploadItemRequest *uploadItemRequest = [[IjinbuUploadItemRequest alloc] init];
    uploadItemRequest.uploadItemToWhere = uploadItemToWhere;
    uploadItemRequest.uploadFileModels = uploadFileModels;
    
    NSURLSessionDataTask *requestOperation =
    [self requestUploadFile:uploadItemRequest progress:uploadProgress completeBlock:completeBlock];
    
    return requestOperation;
}

/** 单个文件上传1 */
- (NSURLSessionDataTask *)requestUploadLocalItem:(NSString *)localRelativePath
                                        itemType:(CJUploadItemType)uploadItemType
                                         toWhere:(NSInteger)uploadItemToWhere
                                         completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock {
    NSAssert(localRelativePath != nil, @"本地相对路径错误");
    
    NSString *localAbsolutePath = [[NSHomeDirectory() stringByAppendingPathComponent:localRelativePath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localAbsolutePath];
    if (fileExists == NO) {
        NSAssert(NO, @"Error：要上传的文件不存在");
        
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:localAbsolutePath];
    NSAssert(data != nil, @"Error：路径存在，但是获取数据为空");
    
    NSString *fileName = localAbsolutePath.lastPathComponent;
    
    NSURLSessionDataTask *requestOperation =
    [self requestUploadItemData:data itemName:fileName itemType:uploadItemType toWhere:uploadItemToWhere completeBlock:completeBlock];
    
    return requestOperation;
}

/** 单个文件上传2 */
- (NSURLSessionDataTask *)requestUploadItemData:(NSData *)data
                                       itemName:(NSString *)fileName
                                       itemType:(CJUploadItemType)uploadItemType
                                        toWhere:(NSInteger)uploadItemToWhere
                                        completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock
{
    NSAssert(data != nil, @"Error：路径存在，但是获取数据为空");
    
    CJUploadFileModel *uploadFileModel = [[CJUploadFileModel alloc] init];
    uploadFileModel.uploadItemType = uploadItemType;
    uploadFileModel.uploadItemData = data;
    uploadFileModel.uploadItemName = fileName;
    NSArray<CJUploadFileModel *> *uploadFileModels = @[uploadFileModel];
    
    IjinbuUploadItemRequest *uploadItemRequest = [[IjinbuUploadItemRequest alloc] init];
    uploadItemRequest.uploadItemToWhere = uploadItemToWhere;
    uploadItemRequest.uploadFileModels = uploadFileModels;
    
    NSURLSessionDataTask *requestOperation =
    [self ijinbu_uploadFile:uploadItemRequest progress:nil completeBlock:completeBlock];
    
    return requestOperation;
    
}


/** 上传文件 */
- (NSURLSessionDataTask *)requestUploadFile:(IjinbuUploadItemRequest *)request
                                   progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                              completeBlock:(void (^)(IjinbuResponseModel *responseModel))completeBlock
{
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *Url = API_BASE_Url_ijinbu(@"ijinbu/app/public/batchUpload");
    NSDictionary *parameters = @{@"uploadType": @(request.uploadItemToWhere)};
    NSArray<CJUploadFileModel *> *uploadFileModels = request.uploadFileModels;
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", parameters);
    
    return [manager cj_postUploadUrl:Url parameters:parameters uploadFileModels:uploadFileModels progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
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
                             andsaveUploadInfoToItem:(CJBaseUploadItem *)saveUploadInfoToItem
                               uploadInfoChangeBlock:(void(^)(CJBaseUploadItem *item))uploadInfoChangeBlock {
    
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *Url = API_BASE_Url_ijinbu(@"ijinbu/app/public/batchUpload");
    NSDictionary *parameters = @{@"uploadType": @(toWhere)};
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", parameters);
    
    /* 从请求结果response中获取uploadInfo的代码块 */
    CJUploadInfo *(^dealResopnseForUploadInfoBlock)(id responseObject) = ^CJUploadInfo *(id responseObject)
    {
        IjinbuResponseModel *responseModel = [[IjinbuResponseModel alloc] init];
        responseModel.status = [responseObject[@"status"] integerValue];
        responseModel.message = responseObject[@"msg"];
        responseModel.result = responseObject[@"result"];
        
        CJUploadInfo *uploadInfo = [[CJUploadInfo alloc] init];
        uploadInfo.responseModel = responseModel;
        if (responseModel.status == 1) {
            NSArray *operationUploadResult = [MTLJSONAdapter modelsOfClass:[IjinbuUploadItemResult class] fromJSONArray:responseModel.result error:nil];
            
            if (operationUploadResult == nil || operationUploadResult.count == 0) {
                uploadInfo.uploadState = CJUploadStateFailure;
                uploadInfo.uploadStatePromptText = @"点击重传";
                
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
                    uploadInfo.uploadState = CJUploadStateFailure;
                    uploadInfo.uploadStatePromptText = @"点击重传";
                    
                } else {
                    uploadInfo.uploadState = CJUploadStateSuccess;
                    uploadInfo.uploadStatePromptText = @"上传成功";
                }
            }
            
        } else if (responseModel.status == 2) {
            uploadInfo.uploadState = CJUploadStateFailure;
            uploadInfo.uploadStatePromptText = responseModel.message;
            
        } else {
            uploadInfo.uploadState = CJUploadStateFailure;
            uploadInfo.uploadStatePromptText = @"点击重传";
        }
        
        return uploadInfo;
    };
    
    
    NSURLSessionDataTask *operation =
    [AFNetworkingUploadUtil cj_UseManager:manager
                            postUploadUrl:Url
                               parameters:parameters
                         uploadFileModels:uploadFileModels
                     uploadInfoSaveInItem:saveUploadInfoToItem
                    uploadInfoChangeBlock:uploadInfoChangeBlock
           dealResopnseForUploadInfoBlock:dealResopnseForUploadInfoBlock];
    
    return operation;
}

@end
