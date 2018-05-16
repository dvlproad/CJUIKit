//
//  IjinbuUploadItemRequest.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/1/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

#ifdef CJTESTPOD
#import "CJBaseUploadItem.h"
#import "CJUploadFileModel.h"
#else
#import <CJNetwork/CJBaseUploadItem.h>
#import <CJNetwork/CJUploadFileModel.h>
#endif

@interface IjinbuUploadItemRequest : MTLModel

//可选
@property (nonatomic, assign) NSInteger uploadItemToWhere; /** 可选：上传到哪里(一个项目中可能有好几个地方都要上传) */
@property (nonatomic, strong) NSArray *uploadFileModels;

@end
