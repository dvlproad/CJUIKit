//
//  CJResponseModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJResponseModel : NSObject

@property(nonatomic, assign) NSInteger status;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) id result;

@property(nonatomic, assign) BOOL isCacheData;

/*
CJResponseModel *responseModel = [[CJResponseModel alloc] init];
responseModel.status = [responseObject[@"status"] integerValue];
responseModel.message = responseObject[@"message"];
responseModel.result = responseObject[@"result"];
responseModel.isCacheData = isCacheData;
*/

@end
