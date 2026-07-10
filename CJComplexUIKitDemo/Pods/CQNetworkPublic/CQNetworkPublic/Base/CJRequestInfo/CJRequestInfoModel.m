//
//  CJRequestInfoModel.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRequestInfoModel.h"
#import "CJRequestErrorUtil.h"


@implementation CJRequestInfoModel

- (instancetype)initWithType:(CJRequestLogType)logType
                         Url:(NSString *)Url
                      params:(id)params
                     request:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        self.Url = Url;
        self.params = params;
        
        //bodyString
        NSString *bodyString = [self getBodyStringForRequest:request];
        self.bodyString = bodyString;
        
        //logType
        self.logType = logType;
    }
    
    return self;
}

///获取最后实际传到服务器的body
- (NSString *)getBodyStringForRequest:(NSURLRequest *)request {
    NSData *bodyData = request.HTTPBody;
    if (bodyData == nil) {
        return nil;
    }
    
    NSString *bodyString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    return bodyString;
}

- (NSMutableString *)getNetworkLogString {
    NSString *Url = self.Url;
    
    //将传给服务器的参数用字符串打印出来
    id params = self.params;
    NSString *allParamsJsonString = [CJRequestInfoModel formattedStringFromObject:params];
    //NSLog(@"传给服务器的json参数:%@", allParamsJsonString);
    
    NSString *bodyString = self.bodyString;
    
    //NSString *resultString = nil;
    //if (self.success) {
    //    resultString = self.responseString;
    //} else {
    //    resultString = self.errorMessage;
    //}
    
    NSMutableString *networkLog = [NSMutableString string];
    [networkLog appendFormat:@"地址：%@ \n", Url];
    [networkLog appendFormat:@"原始参数：%@ \n", allParamsJsonString];
    if (!bodyString) {
        bodyString = @"未获取到，请以原始参数为准...";
    }
    [networkLog appendFormat:@"最终参数：%@ \n", bodyString];
    //[networkLog appendFormat:@"结果：%@ \n", resultString];
    
    return networkLog;
}

+ (void)printNetworkLogString:(NSString *)networkLogString {
    NSMutableString *consoleLog = [NSMutableString string];
    [consoleLog appendFormat:@"\n\n"];
    [consoleLog appendFormat:@"  >>>>>>>>>>>>  网络请求Start  >>>>>>>>>>>>  \n"];
    [consoleLog appendFormat:@"%@\n", networkLogString];
    [consoleLog appendFormat:@"  <<<<<<<<<<<<<  网络请求End  <<<<<<<<<<<<<  \n"];
    [consoleLog appendFormat:@"\n\n"];
    NSLog(@"%@", consoleLog);
}

#pragma mark - Private
+ (NSString *)formattedStringFromObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSDictionary class]]) {
//        NSString *indentedString = [self fullFormattedStringFromDictionary:object];
//        return indentedString;
        
        NSString *JSONString = nil;
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
        return JSONString;
        
    } else if ([object isKindOfClass:[NSArray class]]) {
//        NSString *indentedString = [CJIndentedStringUtil easyFormattedStringFromArray:object];
//        return indentedString;
        
        NSString *JSONString = nil;
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
        return JSONString;
        
    } else {
        return nil;
    }
}


//以下方法来自：#import <CJBaseUtil/CJIndentedStringUtil.h>
///从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
- (NSMutableString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary {
    NSMutableString *indentedString = [self fullFormattedStringFromDictionary:dictionary flagPrefix:@"" textPrefix:@"\t"];
    return indentedString;
}

- (NSMutableString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary flagPrefix:(NSString *)flagPrefix textPrefix:(NSString *)textPrefix {
    NSMutableString *indentedString = [NSMutableString string];
    
    
    [indentedString appendFormat:@"%@{\n", flagPrefix]; // 开头有个{
    
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        id currentObject = [dictionary objectForKey:key];
        if ([currentObject isKindOfClass:[NSDictionary class]]) {
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@:\n", key];
            
            NSDictionary *subDictionary = currentObject;
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@\t", flagPrefix];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", textPrefix];
            NSString *formattedString = [self fullFormattedStringFromDictionary:subDictionary flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
            [indentedString appendFormat:@"%@\n", formattedString];
            
            
        } else if ([currentObject isKindOfClass:[NSArray class]]) {
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@:[\n",key];// 开头有个[
            
            
            NSInteger keyLength = key.length + 2;
            NSMutableString *appendKonggeString = [NSMutableString string];
            for (NSInteger i = 0; i < keyLength; i++) {
                [appendKonggeString appendFormat:@" "];
            }
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@%@", textPrefix, appendKonggeString];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", newFlagPrefix];
            for (id obj in currentObject) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *formattedString = [self fullFormattedStringFromDictionary:obj flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
                    [indentedString appendFormat:@"%@\n", formattedString];
                } else {
                    [indentedString appendFormat:@"%@", newTextPrefix];
                    
                    NSString *formattedString = obj;
                    [indentedString appendFormat:@"%@,\n", formattedString];
                }
                
            }
            
            [indentedString appendFormat:@"%@]\n", textPrefix];   // 结尾有个]
            
        } else {
            id vaule = currentObject;
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@", key];
            [indentedString appendString:@": "];
            [indentedString appendFormat:@"%@,\n", vaule];
        }
    }
    
    
    [indentedString appendFormat:@"%@}", flagPrefix];   // 结尾有个}
    
    return indentedString;
}

@end






@implementation CJSuccessRequestInfo

+ (CJSuccessRequestInfo *)successNetworkLogWithType:(CJRequestLogType)logType
                                                Url:(NSString *)Url
                                             params:(nullable id)params
                                            request:(NSURLRequest *)request
                                     responseObject:(id)responseObject
{
    CJSuccessRequestInfo *networkInfoModel = [[CJSuccessRequestInfo alloc] initWithType:logType Url:Url params:params request:request];
    
    //response
    NSDictionary *recognizableResponseObject = nil;
    if ([NSJSONSerialization isValidJSONObject:responseObject]) {
        recognizableResponseObject = responseObject;
    } else {
        NSError *jsonError = nil;
        recognizableResponseObject = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableContainers error:&jsonError];
    }
    networkInfoModel.responseObject = recognizableResponseObject;
    
    NSString *responseJsonString = [CJRequestInfoModel formattedStringFromObject:recognizableResponseObject];
    networkInfoModel.responseString = responseJsonString;
    
    //输出log
    if (logType == CJRequestLogTypeConsoleLog || logType == CJRequestLogTypeSuppendWindow) {
        NSString *networkLogString = [networkInfoModel getNetworkLogString];
        networkInfoModel.networkLogString = networkLogString;
        
        [CJRequestInfoModel printNetworkLogString:networkLogString];
    }
    
    return networkInfoModel;
}

- (NSMutableString *)getNetworkLogString {
    NSMutableString *networkLog = [super getNetworkLogString];
    [networkLog appendFormat:@"结果：%@ \n", self.responseString];
    
    return networkLog;
}

@end



@implementation CJFailureRequestInfo

+ (id)errorNetworkLogWithType:(CJRequestLogType)logType
                          Url:(NSString *)Url
                       params:(nullable id)params
                      request:(NSURLRequest *)request
                        error:(NSError *)error
                  URLResponse:(NSURLResponse *)URLResponse
{
    CJFailureRequestInfo *networkInfoModel = [[CJFailureRequestInfo alloc] initWithType:logType Url:Url params:params request:request];
    
    //error
    networkInfoModel.error = error;
    NSString *cjErrorMeesage = [CJRequestErrorUtil getErrorMessageFromURLResponse:URLResponse];
    networkInfoModel.errorMessage = cjErrorMeesage;
    
    //输出log
    if (logType == CJRequestLogTypeConsoleLog || logType == CJRequestLogTypeSuppendWindow) {
        NSString *networkLogString = [networkInfoModel getNetworkLogString];
        networkInfoModel.networkLogString = networkLogString;
        
        [CJRequestInfoModel printNetworkLogString:networkLogString];
    }
    
    
    return networkInfoModel;
}


- (NSMutableString *)getNetworkLogString {
    NSMutableString *networkLog = [super getNetworkLogString];
    [networkLog appendFormat:@"结果：%@ \n", self.errorMessage];
    
    return networkLog;
}



@end
