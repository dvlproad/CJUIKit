//
//  CJRequestInfoModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CQNetworkPublic/CJRequestNetworkEnum.h>        // 网络请求中的请求方式相关设置
#import <CQNetworkPublic/CJRequestSettingEnum.h>        // 网络请求中的Log显示等相关设置

NS_ASSUME_NONNULL_BEGIN

/// 网络请求的整体信息(包括请求前的request信息和请求后的reponse信息)
@interface CJRequestInfoModel : NSObject

@property (nonatomic, copy) NSString *Url;              /**< 请求的地址 */
@property (nonatomic, strong) id params;                /**< 请求的原始参数 */
@property (nonatomic, copy) NSString *bodyString;       /**< 请求的最终参数 */
@property (nonatomic, assign) CJRequestMethod method;   /**< 网络请求方法 */

@property (nonatomic, assign) CJRequestLogType logType; /**< 网络请求结果显示方式 */
@property (nonatomic, copy) NSString *networkLogString;

@end



@interface CJSuccessRequestInfo : CJRequestInfoModel {
    
}
//请求成功的结果
@property (nonatomic, assign) BOOL isCacheData;     /**< 是否是缓存数据 */
@property (nonatomic, strong) id responseObject;
@property (nonatomic, copy) NSString *responseString;

///初始化方法
+ (id)successNetworkLogWithType:(CJRequestLogType)logType
                            Url:(NSString *)Url
                         params:(id)params
                        request:(NSURLRequest *)request
                 responseObject:(id)responseObject;

@end


@interface CJFailureRequestInfo : CJRequestInfoModel {
    
}
//请求失败的结果
@property (nonatomic, assign) BOOL isRequestFailure;    /**< 是否是网络请求返回的错误，否的话就是业务逻辑错误 */
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSString *errorMessage;

+ (id)errorNetworkLogWithType:(CJRequestLogType)logType
                          Url:(NSString *)Url
                       params:(id)params
                      request:(NSURLRequest *)request
                        error:(NSError *)error
                  URLResponse:(NSURLResponse *)URLResponse;

@end

NS_ASSUME_NONNULL_END

