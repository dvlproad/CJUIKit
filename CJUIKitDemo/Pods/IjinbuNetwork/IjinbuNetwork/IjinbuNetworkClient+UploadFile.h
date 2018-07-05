//
//  IjinbuNetworkClient+UploadFile.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient.h"
#import "AFHTTPSessionManager+CJUploadFile.h"

#import <UIKit/UIKit.h>

#ifdef CJTESTPOD
#import "CJUploadFileModelsOwner.h"
#import "CJUploadFileModel.h"
#else
#import <CJNetwork/CJUploadFileModelsOwner.h>
#import <CJNetwork/CJUploadFileModel.h>
#endif


@interface IjinbuNetworkClient (UploadFile)


/** 上传多个文件(支持单个文件上传，单个文件最终也是走这个方法) */
- (nullable NSURLSessionDataTask *)ijinbu_multiUploadFileWithParams:(nullable id)params
                                                   uploadFileModels:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                                      completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

/**
 *  创建上传文件到服务器的请求任务：给item设置上传请求，并将上传请求的各个时刻信息momentInfo①保存到该item上，②同时利用这些momentInfo设置uploadProgressView
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
                                      andsaveUploadInfoToItem:(CJUploadFileModelsOwner *_Nullable)saveUploadInfoToItem
                                        uploadInfoChangeBlock:(void(^_Nullable)(CJUploadFileModelsOwner * _Nullable item))uploadInfoChangeBlock;




@end
