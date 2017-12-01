//
//  CJPinyinHelper.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJPinyinHelper.h"
#import <PinYin4Objc/PinYin4Objc.h>

@interface CJPinyinHelper () {
    
}
@property (nonatomic) HanyuPinyinOutputFormat *outputFormat;

@end




@implementation CJPinyinHelper

+ (CJPinyinHelper *)sharedInstance {
    static CJPinyinHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (HanyuPinyinOutputFormat *)outputFormat {
    if (_outputFormat == nil) {
        _outputFormat = [[HanyuPinyinOutputFormat alloc] init];
        [_outputFormat setToneType:ToneTypeWithoutTone];
        [_outputFormat setVCharType:VCharTypeWithV];
        [_outputFormat setCaseType:CaseTypeLowercase];
    }
    
    return _outputFormat;
}


/**
 *  将指定中文转化为地名拼音(已多音节处理完)
 *
 *  @param chineseString 要转化为地名拼音的中文
 *
 *  @return 地名拼音
 */
+ (NSString *)placePinyinFromChineseString:(NSString *)chineseString
{
    NSString *originPinyin = [CJPinyinHelper pinyinFromChineseString:chineseString];
    /*多音字处理*/
    NSMutableString *lastPinyin = [originPinyin mutableCopy];;
    NSArray *polyphoneArray = @[@{@"name":      @"厦门",
                                  @"pinyin":    @"xiamen"},
                                @{@"name":      @"沈阳",
                                  @"pinyin":    @"shenyang"},
                                @{@"name":      @"长春",
                                  @"pinyin":    @"changchun"},
                                @{@"name":      @"重庆",
                                  @"pinyin":    @"chongqing"},
                                @{@"name":      @"地",
                                  @"pinyin":    @"di"},
                                ];
    for (NSDictionary *polyphoneDictionary in polyphoneArray) {
        NSString *name = polyphoneDictionary[@"name"];
        if ([chineseString hasPrefix:name]) {
            NSString *originPinyinForName = [CJPinyinHelper pinyinFromChineseString:name];
            NSString *lastPinyinForName = polyphoneDictionary[@"pinyin"];
            [lastPinyin replaceCharactersInRange:NSMakeRange(0, originPinyinForName.length)
                                     withString:lastPinyinForName];
        }
    }
    
    return lastPinyin;
}

/**
 *  将指定中文转化为拼音
 *
 *  @param chineseString 要转化为拼音的中文
 *
 *  @return 拼音
 */
+ (NSString *)pinyinFromChineseString:(NSString *)chineseString {
    //NSString *pinyinString = [ChineseToPinyin pinyinFromChineseString:chineseString];
    
    HanyuPinyinOutputFormat *outputFormat = [CJPinyinHelper sharedInstance].outputFormat;//避免调用的时候重复创建
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    
    NSString *pinyinString = [PinyinHelper toHanyuPinyinStringWithNSString:chineseString withHanyuPinyinOutputFormat:outputFormat withNSString:@""];//@""表示不分隔
    NSLog(@"pinyinString = %@", pinyinString);
    
    return pinyinString;
}

@end
