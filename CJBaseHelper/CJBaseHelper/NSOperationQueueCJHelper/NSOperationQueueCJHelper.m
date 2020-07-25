//
//  NSOperationQueueCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSOperationQueueCJHelper.h"

@interface NSOperationQueueCJHelper ()

@end


@implementation NSOperationQueueCJHelper

/** 完整的描述请参见文件头部 */
+ (NSOperationQueue *)createOperationQueueWithOperations:(NSArray<NSOperation *> *)operations lastOperation:(NSOperation *)lastOperation {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"this is a queue";
    queue.maxConcurrentOperationCount = 9;
    
    for (NSBlockOperation *operation in operations) {
        [queue addOperation:operation];
        
        [lastOperation addDependency:operation];
    }
    
    [queue addOperation:lastOperation];
    
    return queue;
}


@end
