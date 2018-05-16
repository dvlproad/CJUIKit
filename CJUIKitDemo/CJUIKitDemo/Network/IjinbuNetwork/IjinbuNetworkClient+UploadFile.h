//
//  IjinbuNetworkClient+UploadFile.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient.h"
#import "AFHTTPSessionManager+CJUploadFile.h"
#import "IjinbuUploadItemRequest.h"

@interface IjinbuNetworkClient (UploadFile)

/** 多个文件上传 */
- (nullable NSURLSessionDataTask *)requestUploadItems:(NSArray<CJUploadFileModel *> * _Nullable)uploadFileModels
                                              toWhere:(NSInteger)uploadItemToWhere
                                             progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

/** 单个文件上传1 */
- (nullable NSURLSessionDataTask *)requestUploadLocalItem:(NSString * _Nullable)localRelativePath
                                                 itemType:(CJUploadItemType)uploadItemType
                                                  toWhere:(NSInteger)uploadItemToWhere
                                            completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

/** 单个文件上传2 */
- (nullable NSURLSessionDataTask *)requestUploadItemData:(NSData * _Nullable)data
                                                itemName:(NSString *_Nullable)fileName
                                                itemType:(CJUploadItemType)uploadItemType
                                                 toWhere:(NSInteger)uploadItemToWhere
                                           completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

/** 上传文件 */
- (nullable NSURLSessionDataTask *)requestUploadFile:(IjinbuUploadItemRequest *_Nullable)request
                                            progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                       completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

/**
 *  创建上传文件到服务器的请求任务：给item设置上传请求，并将上传请求的各个时刻信息uploadInfo①保存到该item上，②同时利用这些uploadInfo设置uploadProgressView
 *
 *  @param saveUploadInfoToItem     上传请求的各个时刻信息(正在上传、上传完成)的保存位置
 *  @param uploadFileModels         要上传的数据组uploadFileModels
 *  @param toWhere                  上传请求需要的参数
 *  @param uploadInfoChangeBlock    上传请求的时刻信息变化后(正在上传、上传完成都会导致其变化)要执行的操作
 *
 *  @return 返回上传文件到服务器的请求任务
 */
+ (NSURLSessionDataTask *_Nullable)detailedRequestUploadItems:(NSArray<CJUploadFileModel *> *_Nullable)uploadFileModels
                                                      toWhere:(NSInteger)toWhere
                                      andsaveUploadInfoToItem:(CJBaseUploadItem *_Nullable)saveUploadInfoToItem
                                        uploadInfoChangeBlock:(void(^_Nullable)(CJBaseUploadItem * _Nullable item))uploadInfoChangeBlock;




@end
