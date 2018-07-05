//
//  IjinbuSession.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IjinbuUser.h"

@interface IjinbuSession : NSObject

+ (instancetype)current;

@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, strong) IjinbuUser *user;
@property (nonatomic, readonly) BOOL establish;

- (void)invalidate;

@end
