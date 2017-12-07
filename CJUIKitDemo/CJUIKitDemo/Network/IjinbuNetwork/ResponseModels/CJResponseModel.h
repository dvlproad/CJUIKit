//
//  CJResponseModel.h
//  CommonAFNUtilDemo
//
//  Created by ciyouzen on 2016/12/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CJResponseModel : MTLModel <MTLJSONSerializing> //不要忘了<MTLJSONSerializing>

@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) id result;

@end
