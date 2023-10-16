//
//  CJResponseModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJResponseModel : NSObject {
    
}
// 必用
@property (nonatomic, assign) NSInteger statusCode;
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, strong) id result;

// 基本不用
@property (nullable, nonatomic, copy) NSString *version;
@property (nullable, nonatomic, copy) NSString *statusString;

// 额外自己增加
@property (nonatomic, strong) NSDictionary *responseDictionary; /**< 返回的总信息(请自己完善该属性的赋值) */
@property (nonatomic, copy) NSString *cjNetworkLog;
@property (nonatomic, assign) BOOL isCacheData;

/*
CJResponseModel *responseModel = [[CJResponseModel alloc] init];
responseModel.statusCode = [responseDictionary[@"status"] integerValue];
responseModel.message = responseDictionary[@"message"];
responseModel.result = responseDictionary[@"result"];
responseModel.isCacheData = isCacheData;
*/
- (BOOL)isNoNullForObject:(id)object;

@end

NS_ASSUME_NONNULL_END
