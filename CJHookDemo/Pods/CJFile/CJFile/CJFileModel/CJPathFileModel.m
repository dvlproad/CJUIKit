//
//  CJPathFileModel.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJPathFileModel.h"

@interface CJPathFileModel ()

@end



@implementation CJPathFileModel

#pragma mark - 文件的网络路径更新方法
- (void)updateNetworkAbsoluteUrl:(NSString *)networkAbsoluteUrl
{
    _networkAbsoluteUrl = networkAbsoluteUrl;
}

#pragma mark - 文件的本地路径更新方法(两种)
- (void)updateLocalRelativePath:(NSString *)localRelativePath
                localSourceType:(CJFileLocalSourceType)localSourceType
{
    NSAssert(localSourceType == CJFileSourceTypeLocalSandbox ||
             localSourceType == CJFileSourceTypeLocalBundle, @"避免这边值设错");
    _localRelativePath = localRelativePath;
    _localSourceType = localSourceType;
}


- (void)updateLocalRelativePathWithLocalAbsolutePath:(NSString *)localAbsolutePath
                                     localSourceType:(CJFileLocalSourceType)localSourceType
{
    NSString *localRelativePath = nil;
    switch (localSourceType) {
        case CJFileSourceTypeLocalSandbox:
        {
            NSString *homeDirectory = NSHomeDirectory();
            if ([localAbsolutePath hasPrefix:homeDirectory]) {
                localRelativePath = [localAbsolutePath substringFromIndex:homeDirectory.length+1];
            }
            break;
        }
        case CJFileSourceTypeLocalBundle:
        {
            NSString *homeDirectory = [[NSBundle mainBundle] bundlePath];
            if ([localAbsolutePath hasPrefix:homeDirectory]) {
                localRelativePath = [localAbsolutePath substringFromIndex:homeDirectory.length+1];
            }
            break;
        }
        default:
        {
            break;
        }
    }
    
    _localRelativePath = localRelativePath;
    _localSourceType = localSourceType;
}


#pragma mark - Getter
/** 完整的描述请参见文件头部 */
- (NSURL *)absoluteURL {
    NSURL *absoluteURL = nil;
    
    //先从本地取，如果没有再从网络取
    if (self.localRelativePath.length > 0) {
        if (self.localSourceType == CJFileSourceTypeLocalSandbox) {
            NSString *homeDirectory = NSHomeDirectory();
            NSString *localAbsolutePath = [homeDirectory stringByAppendingPathComponent:self.localRelativePath];
            
            localAbsolutePath = [localAbsolutePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            absoluteURL = [NSURL fileURLWithPath:localAbsolutePath];   //fileURLWithPath
            
        } else if (self.localSourceType == CJFileSourceTypeLocalBundle) {
            NSString *homeDirectory = [[NSBundle mainBundle] bundlePath];
            NSString *localAbsolutePath = [homeDirectory stringByAppendingPathComponent:self.localRelativePath];
            
            //localAbsolutePath = [localAbsolutePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //错误，不能执行此句，否则中文名字图片会错误
            absoluteURL = [NSURL fileURLWithPath:localAbsolutePath];   //fileURLWithPath
        }
        
    } else { //本地取不到的时候，从网络上取
        NSString *networkAbsoluteUrl = [self.networkAbsoluteUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        absoluteURL = [NSURL URLWithString:networkAbsoluteUrl];   //URLWithString
    }
    
    
    return absoluteURL;
}

/* 完整的描述请参见文件头部 */
- (void)getFileDataWithCompleteBlock:(void(^)(NSData *fileData))completeBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *fileData = [NSData dataWithContentsOfURL:self.absoluteURL];//如果图片尚未加载完成不会执行程序的下一步
        if (fileData == nil) {
            NSLog(@"Error:CJPathFileModel的absoluteURL获取到的数据为空");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                //UIImage *image = [UIImage imageWithData:imageData];
                completeBlock(fileData);
            }
        });
    });
}


@end
