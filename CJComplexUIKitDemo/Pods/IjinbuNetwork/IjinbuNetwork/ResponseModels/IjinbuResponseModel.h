//
//  IjinbuResponseModel.h
//  IjinbuNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IjinbuResponseModel : NSObject

@property(nonatomic, assign) NSInteger status;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) id result;
@property(nonatomic, copy) NSString *cjNetworkLog;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary;

@end
