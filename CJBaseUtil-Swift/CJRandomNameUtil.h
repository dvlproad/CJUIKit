//
//  CJRandomNameUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  一个利用字典生成随机字符串的工具(可用于"混淆方法名"的生成)

#import <Foundation/Foundation.h>

@interface CJRandomNameUtil : NSObject

/** 随机一个实例方法名*/
+ (NSString *)randomMethodName;
/** 随机一个类方法名*/
+ (NSString *)randomClassName;


@end
