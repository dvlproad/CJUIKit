//
//  UIView+AFNetworkingUpload.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/8/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager+CJUploadFile.h"
#import "CJUploadProgressView.h"

@interface UIView (AFNetworkingUpload)

#pragma mark - TODO:有上传操作的那个视图要重写的方法
/**
 *  创建上传请求，并利用请求过程中的各个时刻数据同步更新uploadProgressView视图
 *
 *  @param uploadProgressView   上传请求的各个时刻信息(正在上传、上传完成)要用来设置的视图
 *  @param manager              manager
 *  @param Url                  Url
 *  @param params               除fileKey之外的参数
 *  @param fileKey              fileKey
 *  @param fileValueOwner       要操作的上传模型组uploadFileModels的拥有者，fileValueOwner的uploadFileModels有值，而uploadFileModels中的operation和momentInfo是在请求过程中生成的（在执行过程中上传请求的各个时刻信息(正在上传、上传完成)的保存位置会被保存到此拥有者下）
 *  @param uploadMomentInfoChangeBlock          请求成功(上传成功、上传失败)、请求失败以及请求执行过程中的回调，即整个上传过程中各个时刻信息变化的回调(回调中momentInfoOwner其实就是传进来的fileValueOwner，请求成功、请求失败的返回信息都放在其responseModel属性里，且responseModel值在请求成功时候为在getUploadMomentInfoFromResopnseBlock中设置的，而请求失败的responseModel值为nil)
 *  @param getUploadMomentInfoFromResopnseBlock 上传成功后从response中获取该时刻信息的方法(正在上传、以及上传失败的以用默认方法)
 */
- (void)cjConfigureUploadProgressView:(CJUploadProgressView *)uploadProgressView
           withUploadRequestByManager:(AFHTTPSessionManager *)manager
                                  Url:(NSString *)Url
                               params:(id)params
                              fileKey:(NSString *)fileKey
                       fileValueOwner:(CJUploadFileModelsOwner *)fileValueOwner
          uploadMomentInfoChangeBlock:(void(^)(CJUploadFileModelsOwner *momentInfoOwner))uploadMomentInfoChangeBlock
 getUploadMomentInfoFromResopnseBlock:(CJUploadMomentInfo * (^)(id responseObject))getUploadMomentInfoFromResopnseBlock;

@end
