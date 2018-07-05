//
//  CJUploadFileModelsOwner.h
//  FileChooseViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

#import "CJUploadFileModel.h"   //要上传的数据模型
#import "CJUploadMomentInfo.h"  //上传请求的时刻信息（已包括 CJUploadMomentState 和 responseModel(已转换成对象后的model)）

/**
 *  包含有以下三种消息的上传模型
 *  ①上传的上传模型组、
 *  ②上传时候生成的请求、
 *  ③整个上传过程中(上传中、上传成功、上传失败)各时刻的信息(进度以及上传结果)
 */
@interface CJUploadFileModelsOwner : NSObject

@property (nonatomic, assign) BOOL isNetworkItem;   /**< (新增)是否是网络文件，如果是则不用进行上传 */

//开始请求前,就有的数据
@property (nonatomic, strong, readonly) NSMutableArray<CJUploadFileModel *> *uploadFileModels; //必填参数


//开始请求后,才有的数据
@property (nonatomic, strong) NSURLSessionDataTask *operation;  /**< 开始请求后，生成的请求任务 */
@property (nonatomic, strong) CJUploadMomentInfo *momentInfo; /**< 开始请求后，整个上传过程中(上传中、上传成功、上传失败)各时刻的信息(进度以及上传结果) */


/**
 *  初始化方法
 *
 *  @param uploadFileModels uploadFileModels
 *
 *  @return uploadFileModels的拥有者
 */
- (instancetype)initWithUploadFileModels:(NSArray<CJUploadFileModel *> *)uploadFileModels;

@end
