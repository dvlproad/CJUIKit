//
//  IjinbuNetworkClient+UploadFile.m
//  CommonAFNUtilDemo
//
//  Created by ciyouzen on 2017/4/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient+UploadFile.h"
#import "IjinbuHTTPSessionManager.h"
//#import "CJImageUploadItem.h"

#import <CJNetwork/AFNetworkingUploadUtil.h>
#import "IjinbuUploadItemResult.h"

@implementation IjinbuNetworkClient (UploadFile)

/** 多个文件上传 */
- (NSURLSessionDataTask *)requestUploadItems:(NSArray<CJUploadFileModel *> *)uploadFileModels
                                     toWhere:(NSInteger)uploadItemToWhere
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     success:(HPSuccess)success
                                     failure:(HPFailure)failure
{
    IjinbuUploadItemRequest *uploadItemRequest = [[IjinbuUploadItemRequest alloc] init];
    uploadItemRequest.uploadItemToWhere = uploadItemToWhere;
    uploadItemRequest.uploadFileModels = uploadFileModels;
    
    NSURLSessionDataTask *requestOperation =
    [self requestUploadFile:uploadItemRequest progress:uploadProgress success:success failure:failure];
    
    return requestOperation;
}

/** 单个文件上传1 */
- (NSURLSessionDataTask *)requestUploadLocalItem:(NSString *)localRelativePath
                                        itemType:(CJUploadItemType)uploadItemType
                                         toWhere:(NSInteger)uploadItemToWhere
                                         success:(HPSuccess)success
                                         failure:(HPFailure)failure {
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
    [self requestUploadItemData:data itemName:fileName itemType:uploadItemType toWhere:uploadItemToWhere success:success failure:failure];
    
    return requestOperation;
}

/** 单个文件上传2 */
- (NSURLSessionDataTask *)requestUploadItemData:(NSData *)data
                                       itemName:(NSString *)fileName
                                       itemType:(CJUploadItemType)uploadItemType
                                        toWhere:(NSInteger)uploadItemToWhere
                                        success:(HPSuccess)success
                                        failure:(HPFailure)failure
{
    NSAssert(data != nil, @"Error：路径存在，但是获取数据为空");
    
    CJUploadFileModel *uploadItemModel = [[CJUploadFileModel alloc] init];
    uploadItemModel.uploadItemType = uploadItemType;
    uploadItemModel.uploadItemData = data;
    uploadItemModel.uploadItemName = fileName;
    NSArray<CJUploadFileModel *> *uploadFileModels = @[uploadItemModel];
    
    IjinbuUploadItemRequest *uploadItemRequest = [[IjinbuUploadItemRequest alloc] init];
    uploadItemRequest.uploadItemToWhere = uploadItemToWhere;
    uploadItemRequest.uploadFileModels = uploadFileModels;
    
    NSURLSessionDataTask *requestOperation =
    [self requestUploadFile:uploadItemRequest progress:nil success:success failure:failure];
    
    return requestOperation;
    
}

/** 上传文件 */
- (NSURLSessionDataTask *)requestUploadFile:(IjinbuUploadItemRequest *)request
                                   progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                    success:(HPSuccess)success
                                    failure:(HPFailure)failure
{
    AFHTTPSessionManager *manager = [IjinbuHTTPSessionManager sharedInstance];
    
    NSString *Url = API_BASE_Url_ijinbu(@"ijinbu/app/public/batchUpload");
    NSDictionary *parameters = @{@"uploadType": @(request.uploadItemToWhere)};
    NSArray<CJUploadFileModel *> *uploadFileModels = request.uploadFileModels;
    NSLog(@"Url = %@", Url);
    NSLog(@"params = %@", parameters);
    
    return [manager cj_postUploadUrl:Url parameters:parameters uploadFileModels:uploadFileModels progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        IjinbuResponseModel *responseModel = [MTLJSONAdapter modelOfClass:[IjinbuResponseModel class] fromJSONDictionary:responseObject error:nil];
        if (success) {
            success(responseModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



/*
- (CJImageUploadItem *)cjUploadImage:(UIImage *)image
                             toWhere:(NSInteger)uploadItemToWhere
                      andSaveToLocal:(BOOL)saveToLocal
                             success:(void(^)(CJImageUploadItem *uploadItem))success
                             failure:(void(^)(void))failure
{
    NSLog(@"dealWithPickPhotoCompleteImage");
    CJImageUploadItem *imageUploadItem = [[CJImageUploadItem alloc] init];
    imageUploadItem.image = [UIImage adjustImageWithImage:image];
    NSData *imageData = UIImageJPEGRepresentation(imageUploadItem.image, 0.8);
    
    //文件名
    NSString *identifier = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString *fileName = [identifier stringByAppendingPathExtension:@"jpg"];
    
    if (saveToLocal) {
        NSString *localRelativePath = [CJFileManager saveFileData:imageData
                                                     withFileName:fileName
                                               inSubDirectoryPath:@"UploadImage"
                                              searchPathDirectory:NSCachesDirectory];
        
        //上传图片
        imageUploadItem.localRelativePath = localRelativePath;
    }
    
    imageUploadItem.operation =
    [self requestUploadItemData:imageData itemName:fileName itemType:CJUploadItemTypeImage toWhere:uploadItemToWhere success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        CJResponseModel *responseModel = nil;
        
        imageUploadItem.responseModel = responseModel;
        
        if (!responseModel.result && [responseModel.result isKindOfClass:[NSArray class]])
        {
            NSArray *array = responseModel.result;
            if (array.count > 0) {
                if (success) {
                    success(imageUploadItem);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        //        [UIGlobal showMessage:error.localizedDescription];
        
        if (failure) {
            failure();
        }
    }];
    
    
    return imageUploadItem;
}
*/

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
        IjinbuResponseModel *responseModel = [MTLJSONAdapter modelOfClass:[IjinbuResponseModel class] fromJSONDictionary:responseObject error:nil];
        
        CJUploadInfo *uploadInfo = [[CJUploadInfo alloc] init];
        uploadInfo.responseModel = responseModel;
        if ([responseModel.status integerValue] == 1) {
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
            
        } else if ([responseModel.status integerValue] == 2) {
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
