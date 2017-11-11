//
//  IjinbuUploadItemRequest.h
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2017/1/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

#import "CJBaseUploadItem.h"
#import <CJNetwork/CJUploadFileModel.h>

@interface IjinbuUploadItemRequest : MTLModel

//可选
@property (nonatomic, assign) NSInteger uploadItemToWhere; /** 可选：上传到哪里(一个项目中可能有好几个地方都要上传) */
@property (nonatomic, strong) NSArray *uploadFileModels;

@end
