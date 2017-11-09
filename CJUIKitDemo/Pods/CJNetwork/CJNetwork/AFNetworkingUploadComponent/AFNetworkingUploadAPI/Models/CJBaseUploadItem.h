//
//  CJBaseUploadItem.h
//  FileChooseViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

#import "CJUploadItemModel.h"
#import "CJUploadInfo.h"

@interface CJBaseUploadItem : NSObject

@property (nonatomic, assign) BOOL isNetworkItem;   /**< (新增)是否是网络文件，如果是则不用进行上传 */

//必填参数
@property (nonatomic, strong) NSMutableArray<CJUploadItemModel *> *uploadItems;

@property (nonatomic, strong) NSURLSessionDataTask *operation;

@property (nonatomic, strong) CJUploadInfo *uploadInfo; /**< 上传的信息(包括进度以及上传结果) */

@end
