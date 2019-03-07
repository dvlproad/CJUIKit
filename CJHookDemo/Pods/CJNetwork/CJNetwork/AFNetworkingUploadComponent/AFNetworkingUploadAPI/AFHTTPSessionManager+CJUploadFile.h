//
//  AFHTTPSessionManager+CJUploadFile.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/10/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "CJUploadFileModelsOwner.h"    //上传请求的时刻信息要保存到的位置


@interface AFHTTPSessionManager (CJUploadFile)

/**
 *  上传文件的请求方法：除了上传文件，还对上传过程中的各个时刻信息的进行保存(momentInfo：上传请求的各个时刻信息）
 *  @brief 回调中momentInfoOwner其实就是传进来的fileValueOwner
 *
 *  @param Url              Url
 *  @param params           除fileKey之外的参数
 *  @param fileKey          fileKey
 *  @param fileValueOwner   要操作的上传模型组uploadFileModels的拥有者，fileValueOwner的uploadFileModels有值，而uploadFileModels中的operation和momentInfo是在请求过程中生成的（在执行过程中上传请求的各个时刻信息(正在上传、上传完成)的保存位置会被保存到此拥有者下）
 *  @param uploadMomentInfoChangeBlock          请求成功(上传成功、上传失败)、请求失败以及请求执行过程中的回调，即整个上传过程中各个时刻信息变化的回调(回调中momentInfoOwner其实就是传进来的fileValueOwner，请求成功、请求失败的返回信息都放在其responseModel属性里，且responseModel值在请求成功时候为在getUploadMomentInfoFromResopnseBlock中设置的，而请求失败的responseModel值为nil)
 *  @param getUploadMomentInfoFromResopnseBlock 上传成功后从response中获取该时刻信息的方法(正在上传、以及上传失败的以用默认方法)
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)params
                                            fileKey:(nullable NSString *)fileKey
                                     fileValueOwner:(nullable CJUploadFileModelsOwner *)fileValueOwner
                        uploadMomentInfoChangeBlock:(nullable void(^)(CJUploadFileModelsOwner * _Nonnull momentInfoOwner))uploadMomentInfoChangeBlock
               getUploadMomentInfoFromResopnseBlock:(nullable CJUploadMomentInfo * _Nonnull (^)(id _Nonnull responseObject))getUploadMomentInfoFromResopnseBlock;

/**
 *  上传文件的请求方法：只是上传文件，不对上传过程中的各个时刻信息的进行保存
 *
 *  @param Url              Url
 *  @param parameters       parameters
 *  @param fileKey          文件参数：有些人会用file,有些人用upfile
 *  @param uploadFileModels 文件数据：要上传的数据组uploadFileModels
 *  @param uploadProgress   uploadProgress
 *  @param success          上传成功执行的回调
 *  @param failure          上传失败执行的回调
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)parameters
                                            fileKey:(nullable NSString *)fileKey
                                          fileValue:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                            success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
                                            failure:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error))failure;

@end
