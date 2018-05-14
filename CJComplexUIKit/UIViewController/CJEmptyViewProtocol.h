//
//  CJEmptyViewProtocol.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/14.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CJEmptyViewProtocol <NSObject>

@optional
- (void)setupShowEmptyViewBlock:(void (^)(NSString *message))showEmptyViewBlock hideEmptyViewBlock:(void (^)(void))hideEmptyViewBlock;

@end


