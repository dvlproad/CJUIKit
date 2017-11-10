//
//  NSOperationQueueUtil.m
//  MultithreadingDemo
//
//  Created by lichq on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSOperationQueueUtil.h"

@interface NSOperationQueueUtil ()

@end


@implementation NSOperationQueueUtil

/** 完整的描述请参见文件头部 */
+ (NSOperationQueue *)createOperationQueueWithOperations:(NSArray<NSOperation *> *)operations lastOperation:(NSOperation *)lastOperation {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"this is a queue";
    
    for (NSBlockOperation *operation in operations) {
        [queue addOperation:operation];
        
        [lastOperation addDependency:operation];
    }
    
    [queue addOperation:lastOperation];
    
    return queue;
}


@end
