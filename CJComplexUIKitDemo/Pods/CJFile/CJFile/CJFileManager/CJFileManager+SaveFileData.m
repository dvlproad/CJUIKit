//
//  CJFileManager+SaveFileData.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager+SaveFileData.h"

@implementation CJFileManager (SaveData)

/** 完整的描述请参见文件头部 */
+ (BOOL)saveFileData:(NSData *)fileData
        withFileName:(NSString *)fileName
toRelativeDirectoryPath:(NSString *)relativeDirectoryPath
{
    if ([fileData length] == 0) {
        return NO;
    }
    
    NSString *absoluteFileDirectory = [NSHomeDirectory() stringByAppendingPathComponent:relativeDirectoryPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:absoluteFileDirectory]){
        [[NSFileManager defaultManager] createDirectoryAtPath:absoluteFileDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    //clock_t saveStartClock = clock(); //开始保存的时刻
    
    NSString *absoluteFilePath = [absoluteFileDirectory stringByAppendingPathComponent:fileName];
    BOOL saveSuccess = [fileData writeToFile:absoluteFilePath atomically:YES]; //方法①
    //BOOL saveSuccess = [[NSFileManager defaultManager] createFileAtPath:absoluteFilePath contents:fileData attributes:nil];//方法②
    
    //clock_t saveFinishClock = clock();  //结束保存的时刻
    //double saveDuration = (double)(saveFinishClock - saveStartClock)/CLOCKS_PER_SEC;
    //NSLog(@"%@文件写进磁盘的耗时为%f", fileName, saveDuration);
    
    return saveSuccess;
}


@end
