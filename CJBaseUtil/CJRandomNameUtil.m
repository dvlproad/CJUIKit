//
//  CJRandomNameUtil.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/9/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJRandomNameUtil.h"

typedef NS_ENUM(NSUInteger, DJNameType) {
    DJClassName,
    DJMethodName,
};


@interface CJRandomNameUtil () {
    
}
@property (nonatomic, strong) NSMutableArray *memoryArray;  /**< 内存中缓存数组 */
@property (nonatomic, strong) NSMutableArray *namesArray;   /**< 随机生成的名字组成的数组 */

@end


static dispatch_once_t dj_predicate;
static CJRandomNameUtil * manager = nil;


@implementation CJRandomNameUtil

#pragma mark - singleShare
+ (CJRandomNameUtil *)share
{
    dispatch_once(&dj_predicate, ^{
        manager = [super allocWithZone:NULL];
        
        NSArray *stringArray = [manager getWordFromFile:[manager getFilePath]];
        if (stringArray.count == 0) {
            NSLog(@"Error:请先完善memoryArray");
        } else {
            manager.memoryArray = [[NSMutableArray alloc]initWithArray:stringArray];
        }
        
        manager.namesArray = [NSMutableArray array];
    });
    return manager;
}
- (id)copy
{
    return [CJRandomNameUtil share];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [CJRandomNameUtil share];
}

#pragma mark - Methods
- (NSString *)getFilePath
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CJRandomNameUtil" ofType:@"txt"];
    return filePath;
}
- (NSArray *)getWordFromFile:(NSString *)file
{
    NSError *error = nil;
    NSString *articleText = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    } else {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" \n"];
        NSArray *wordsArray = [articleText componentsSeparatedByCharactersInSet:set];
        return wordsArray;
    }
}

/** 用来随机生成一个合规字符串*/
- (NSString *)randomNameWithWordsMin:(NSInteger)min Max:(NSInteger)max WithType:(DJNameType)type
{
    NSMutableString *methodName = [[NSMutableString alloc]initWithString:@""];
    NSInteger wordCount = rand()%max + min;
    switch (type) {
        case DJClassName:
            for (int i = 0; i < wordCount; i++) {
                int wordIndex = arc4random() % self.memoryArray.count;
                [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] capitalizedString]];
            }
            break;
        case DJMethodName:
            for (int i = 0; i < wordCount; i++) {
                int wordIndex = arc4random() % self.memoryArray.count;
                if (i == 0) {
                    [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] lowercaseString]];
                }else
                {
                    [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] capitalizedString]];
                }
            }
            break;
        default:
            break;
    }
    return methodName;
}

+ (NSString *)randomMethodName
{
    CJRandomNameUtil *myDj = [CJRandomNameUtil share];
    NSString *name;
    do {
        name = [myDj randomNameWithWordsMin:2 Max:4 WithType:DJMethodName];
        if (![myDj.namesArray containsObject:name]) {
            break;
        }
    } while (1);
    return name;
}

+ (NSString *)randomClassName
{
    CJRandomNameUtil *myDj = [CJRandomNameUtil share];
    NSString *name;
    do {
        name = [myDj randomNameWithWordsMin:1 Max:3 WithType:DJClassName];
        if (![myDj.namesArray containsObject:name]) {
            break;
        }
    } while (1);
    return name;
}


@end
