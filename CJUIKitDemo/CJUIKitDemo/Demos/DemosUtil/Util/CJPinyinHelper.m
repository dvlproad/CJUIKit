//
//  CJPinyinHelper.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJPinyinHelper.h"
#import <PinYin4Objc/PinYin4Objc.h>

@implementation CJPinyinHelper

+ (NSString *)pinyinFromChineseString:(NSString *)chineseString {
    //NSString *pinyinString = [ChineseToPinyin pinyinFromChineseString:chineseString];
    
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    
    NSString *pinyinString = [PinyinHelper toHanyuPinyinStringWithNSString:chineseString withHanyuPinyinOutputFormat:outputFormat withNSString:@""];//@""表示不分隔
    //NSLog(@"pinyinString = %@", pinyinString);
    
    return pinyinString;
}

@end
