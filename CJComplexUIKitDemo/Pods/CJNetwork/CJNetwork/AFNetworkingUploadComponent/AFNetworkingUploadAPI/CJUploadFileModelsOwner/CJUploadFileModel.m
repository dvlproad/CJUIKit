//
//  CJUploadFileModel.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUploadFileModel.h"

@interface CJUploadFileModel ()

@end



@implementation CJUploadFileModel

- (instancetype)initWithItemType:(CJUploadItemType)uploadItemType
                        itemName:(NSString *)fileName
                        itemData:(NSData *)data
{
    self = [super init];
    if (self) {
        _uploadItemType = uploadItemType;
        _uploadItemData = data;
        _uploadItemName = fileName;
    }
    return self;
}

+ (CJUploadFileModel *)createFromLocalRelativePath:(NSString *)localRelativePath
                                          itemType:(CJUploadItemType)uploadItemType
{
    NSAssert(localRelativePath != nil, @"本地相对路径错误");
    
    NSString *localAbsolutePath = [[NSHomeDirectory() stringByAppendingPathComponent:localRelativePath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localAbsolutePath];
    if (fileExists == NO) {
        NSAssert(NO, @"Error：要上传的文件不存在");
        
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:localAbsolutePath];
    NSAssert(data != nil, @"Error：路径存在，但是获取数据为空");
    
    NSString *fileName = localAbsolutePath.lastPathComponent;
    
    CJUploadFileModel *uploadFileModel = [[CJUploadFileModel alloc] initWithItemType:uploadItemType itemName:fileName itemData:data];
    
    return uploadFileModel;
}

@end
