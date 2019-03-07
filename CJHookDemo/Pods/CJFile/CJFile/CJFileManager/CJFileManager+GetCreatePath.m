//
//  CJFileManager+GetCreatePath.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager+GetCreatePath.h"

@implementation CJFileManager (GetCreatePath)

/** 完整的描述请参见文件头部 */
+ (NSString *)getLocalDirectoryPathType:(CJLocalPathType)localPathType
                     bySubDirectoryPath:(NSString *)subDirectoryPath
                  inSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory
                        createIfNoExist:(BOOL)createIfNoExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES);
    NSString *pathDocuments = [paths objectAtIndex:0];
    
    NSString *absoluteDirectory = nil; //absoluteDirectory、relativeDirectory
    if (subDirectoryPath == nil || [subDirectoryPath length] == 0) {
        absoluteDirectory = pathDocuments;
    } else {
        absoluteDirectory = [NSString stringWithFormat:@"%@/%@", pathDocuments, subDirectoryPath];
    }
    
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDirectoryExists = [[NSFileManager defaultManager] fileExistsAtPath:absoluteDirectory];
    if (isDirectoryExists == NO) {      //文件夹不存在
        if (createIfNoExist == NO) {    //文件夹不存在时也不创建该文件夹
            return nil;                 //此时绝对路径、相对路径都是nil
        } else {
            BOOL createDirectorySuccess = [fileManager createDirectoryAtPath:absoluteDirectory
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:nil];
            if (!createDirectorySuccess) {
                NSLog(@"Failure: 文件夹存在时创建该文件夹失败");
                return nil;
            }
        }
    }
    
    
    if (localPathType == CJLocalPathTypeAbsolute) {
        return absoluteDirectory;
        
    } else {
        NSString *home = NSHomeDirectory();
        NSString *relativeDirectory = [absoluteDirectory substringFromIndex:home.length];
        
        return relativeDirectory;
    }
}

@end
