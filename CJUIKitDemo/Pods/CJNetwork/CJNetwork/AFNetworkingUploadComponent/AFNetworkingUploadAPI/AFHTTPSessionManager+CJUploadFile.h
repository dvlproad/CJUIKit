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
 *  @param uploadMomentInfoChangeBlock          上传请求的时刻信息变化后(正在上传、上传完成都会导致其变化)要执行的操作(回调中momentInfoOwner其实就是传进来的fileValueOwner)
 *  @param getUploadMomentInfoFromResopnseBlock 上传结束后从response中获取上传请求的该时刻信息的方法(正在上传的时刻系统可自动获取)
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
