//
//  AFHTTPSessionManager+CJUploadFile.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/10/5.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+CJRequestCommon.h"
#import <CJNetworkFileModel/CJUploadFileModelsOwner.h>    //上传请求的时刻信息要保存到的位置

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (CJUploadFile)

/*
 *  上传文件的请求方法：除了上传文件，还对上传过程中的各个时刻信息的进行保存(momentInfo：上传请求的各个时刻信息）
 *  @brief 回调中momentInfoOwner其实就是传进来的fileValueOwner
 *
 *  @param Url                  Url
 *  @param urlParams            urlParams(需要拼接到url后的参数)
 *  @param formParams           formParams(除uploadFileModels中的key之外需要作为表单提交的参数)
 *  @param headers              headers
 *  @param cacheSettingModel    cacheSettingModel
 *  @param logType              logType
 *  @param fileValueOwner       要操作的上传模型组uploadFileModels的拥有者，fileValueOwner的uploadFileModels有值，而uploadFileModels中的operation和momentInfo是在请求过程中生成的（在执行过程中上传请求的各个时刻信息(正在上传、上传完成)的保存位置会被保存到此拥有者下）
 *  @param uploadMomentInfoChangeBlock          请求成功(上传成功、上传失败)、请求失败以及请求执行过程中的回调，即整个上传过程中各个时刻信息变化的回调(回调中momentInfoOwner其实就是传进来的fileValueOwner，请求成功、请求失败的返回信息都放在其responseModel属性里，且responseModel值在请求成功时候为在getUploadMomentInfoFromResopnseBlock中设置的，而请求失败的responseModel值为nil)
 *  @param getUploadMomentInfoFromResopnseBlock 上传成功后从response中获取该时刻信息的方法(正在上传、以及上传失败的以用默认方法)
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_uploadUrl:(NSString *)Url
                                      urlParams:(nullable id)urlParams
                                     formParams:(nullable id)formParams
                                        headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                        logType:(CJRequestLogType)logType
                                 fileValueOwner:(nullable CJUploadFileModelsOwner *)fileValueOwner
                    uploadMomentInfoChangeBlock:(nullable void(^)(CJUploadFileModelsOwner * _Nonnull momentInfoOwner))uploadMomentInfoChangeBlock
           getUploadMomentInfoFromResopnseBlock:(nullable CJUploadMomentInfo * _Nonnull (^)(id _Nonnull responseObject))getUploadMomentInfoFromResopnseBlock;

/*
 *  上传文件的请求方法：只是上传文件，不对上传过程中的各个时刻信息的进行保存
 *
 *  @param Url                  Url
 *  @param urlParams            urlParams(需要拼接到url后的参数)
 *  @param formParams           formParams(除uploadFileModels中的key之外需要作为表单提交的参数)
 *  @param headers              headers
 *  @param uploadFileModels     文件数据：要上传的数据组uploadFileModels
 *  @param cacheSettingModel    cacheSettingModel
 *  @param logType              logType
 *  @param uploadProgress       uploadProgress
 *  @param success              上传成功执行的回调
 *  @param failure              上传失败执行的回调
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_uploadUrl:(NSString *)Url
                                      urlParams:(nullable id)urlParams
                                     formParams:(nullable id)formParams
                                        headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               uploadFileModels:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                              cacheSettingModel:(nullable CJRequestCacheSettingModel *)cacheSettingModel
                                        logType:(CJRequestLogType)logType
                                       progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        success:(nullable void (^)(CJSuccessRequestInfo * _Nullable successRequestInfo))success
                                        failure:(nullable void (^)(CJFailureRequestInfo * _Nullable failureRequestInfo))failure;

NS_ASSUME_NONNULL_END

@end
