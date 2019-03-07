//
//  CJNetworkInfoModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJNetworkLogType) {
    CJNetworkLogTypeNone = 0,
    CJNetworkLogTypeClean,
    CJNetworkLogTypeConsoleLog,
    CJNetworkLogTypeSuppendWindow,
};


@interface CJNetworkInfoModel : NSObject

@property (nonatomic, copy) NSString *Url;              /**< 请求的地址 */
@property (nonatomic, strong) id params;                /**< 请求的原始参数 */
@property (nonatomic, copy) NSString *bodyString;       /**< 请求的最终参数 */

@property (nonatomic, assign) CJNetworkLogType logType;
@property (nonatomic, copy) NSString *networkLogString;

@end



@interface CJSuccessNetworkInfo : CJNetworkInfoModel {
    
}
//请求成功的结果
@property (nonatomic, strong) id responseObject;
@property (nonatomic, copy) NSString *responseString;

///初始化方法
+ (id)successNetworkLogWithType:(CJNetworkLogType)logType
                            Url:(NSString *)Url
                         params:(id)params
                        request:(NSURLRequest *)request
                 responseObject:(id)responseObject;

@end


@interface CJFailureNetworkInfo : CJNetworkInfoModel {
    
}
//请求失败的结果
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSString *errorMessage;

+ (id)errorNetworkLogWithType:(CJNetworkLogType)logType
                          Url:(NSString *)Url
                       params:(id)params
                      request:(NSURLRequest *)request
                        error:(NSError *)error
                  URLResponse:(NSURLResponse *)URLResponse;

@end

