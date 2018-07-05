//
//  CJNetworkLogUtil.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJNetworkLogUtil : NSObject


+ (NSMutableString *)networkLogWithUrl:(NSString *)Url
                          paramsString:(NSString *)paramsString
                        responseString:(NSString *)responseString;

+ (void)printNetworkLog:(NSString *)networkLog;


+ (NSString *)formattedStringFromObject:(id)object;
@end
