//
//  CJUploadResponseModel.h
//  CommonAFNUtilDemo
//
//  Created by lichq on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CJUploadState.h"

@interface CJUploadResponseModel : NSObject

@property (nonatomic, strong) id responseModel;  /**< 上传成功后后台返回的结果 */
@property (nonatomic, assign) CJUploadState uploadState;
@property (nonatomic, copy) NSString *uploadStatePromptText;
@property (nonatomic, assign) CGFloat progressValue;  /**< 当前加载进度[0,100] */

@end
