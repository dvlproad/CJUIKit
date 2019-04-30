//
//  NSDictionary+CJConvert.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CJConvert)

///从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
- (NSString *)convertToString_byCycle;

@end
