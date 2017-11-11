//
//  CJNetworkDefine.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#ifndef CJNetworkDefine_h
#define CJNetworkDefine_h

typedef void (^AFRequestSuccess)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject);
typedef void (^AFRequestFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error);
typedef void (^AFUploadProgressBlock)(NSProgress * _Nullable progress);


#endif /* CJNetwork_h */
