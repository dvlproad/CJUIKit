//
//  NSOperationQueueUtil.h
//  MultithreadingDemo
//
//  Created by lichq on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueueUtil : NSObject

/**
 *  创建队列
 *
 *  @param operations    队列的操作数组
 *  @param lastOperation 队列的最后一条(最后一条，会等到前面都结束后才会结束)
 *
 *  return 队列
 */
+ (NSOperationQueue *)createOperationQueueWithOperations:(NSArray<NSOperation *> *)operations lastOperation:(NSOperation *)lastOperation;

@end
