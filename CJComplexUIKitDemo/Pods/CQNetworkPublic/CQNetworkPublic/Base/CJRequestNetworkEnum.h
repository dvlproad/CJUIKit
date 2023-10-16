//
//  CJRequestNetworkEnum.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/6/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#ifndef CJRequestNetworkEnum_h
#define CJRequestNetworkEnum_h

/// 请求方式
typedef NS_ENUM(NSUInteger, CQRequestType) {
    CQRequestTypeReal = 0,      /**< 执行网络请求 */
    CQRequestTypeSimulate,      /**< 执行模拟请求 */
    CQRequestTypeLocal,         /**< 执行本地请求 */
};


/// 网络请求方法
typedef NS_ENUM(NSUInteger, CJRequestMethod) {
    CJRequestMethodPOST = 0,
    CJRequestMethodGET,
};

/// 请求加密方式
typedef NS_ENUM(NSUInteger, CJRequestEncrypt) {
    CJRequestEncryptNone = 0,   /**< 不加密 */
    CJRequestEncryptYES,        /**< 加密 */
};

typedef NS_ENUM(NSUInteger, CJResponeFailureType) {
    CJResponeFailureTypeUncheck = 0,            /**< 未进行是否等失败判断 */
    CJResponeFailureTypeRequestFailure,         /**< 请求失败 */
    CJResponeFailureTypeCommonFailure,          /**< 通用失败 */
    CJResponeFailureTypeNeedFurtherJudgeFailure,/**< 需要进一步判断是否错误的那些(在未进行归类或者未归类进指定错误的时候，都是这个值) */
};


#endif /* CJRequestNetworkEnum_h */
