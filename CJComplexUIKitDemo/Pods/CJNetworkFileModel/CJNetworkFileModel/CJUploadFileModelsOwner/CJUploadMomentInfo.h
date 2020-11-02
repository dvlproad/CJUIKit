//
//  CJUploadMomentInfo.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/8/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJUploadMomentState.h"

/**
 *  上传请求的时刻信息（已包括 CJUploadMomentState 和 responseModel(已转换成对象后的model)）
 */
@interface CJUploadMomentInfo : NSObject {
    
}

@property (nonatomic, assign) CJUploadMomentState uploadState;
@property (nonatomic, copy) NSString *uploadStatePromptText;

//过程中参数
@property (nonatomic, assign) NSInteger progressValue;  /**< 当前加载进度[0,100] */

//返回结果
@property (nonatomic, strong) id responseModel;  /**< 上传成功后后台返回的结果，并且是转换成对象后的 */



@end
