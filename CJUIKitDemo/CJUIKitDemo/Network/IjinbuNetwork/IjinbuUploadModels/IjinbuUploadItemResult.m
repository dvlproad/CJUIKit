//
//  IjinbuUploadItemResult.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/1/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuUploadItemResult.h"

@implementation IjinbuUploadItemResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"networkId":      @"id",
             @"networkUrl":     @"url",
             @"networkName":    @"name",
             };
}

+ (NSString *)jsonArrayWithObjectArray:(NSArray<IjinbuUploadItemResult *> *)jsonArray
{
    NSMutableArray * temp = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (IjinbuUploadItemResult *uploadItemResult in jsonArray) {
        if (uploadItemResult.size.length == 0) {
            uploadItemResult.size = @"";
        }
        
        if (uploadItemResult.ext.length == 0) {
            uploadItemResult.ext = @"";
        }
        
        if (uploadItemResult.networkId.length == 0) {
            uploadItemResult.networkId = @"";
        }
        
        if (uploadItemResult.networkName.length == 0) {
            uploadItemResult.networkName = @"";
        }
        
        NSDictionary *dictionary = [uploadItemResult dictionaryValue];
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (!obj || ![obj isKindOfClass:[NSNull class]]) {
                [mutableDictionary setValue:obj forKey:key];
            }
        }];
        [temp addObject:mutableDictionary];
    }
    NSString *resultJsonString = [self jsonStringConvertFromObject:temp];
    return resultJsonString;
}

+ (NSString *)jsonStringConvertFromObject:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData =
        [NSJSONSerialization dataWithJSONObject:object
                                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                        error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}



@end
