//
//  DemoFileUploadPanel.m
//  CJHookDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "DemoFileUploadPanel.h"
#import "CJFileUploadPanel.h"
#import "DemoCacheUtil.h"

@implementation DemoFileUploadPanel

+ (void)startHook {
    __weak typeof(self)weakSelf = self;
    [CJFileUploadPanel startHookWithAbsoluteFilePathHandle:^NSString *(UIImage *originImage) {
        NSData *newImageData = [weakSelf dealImage:originImage];
        
        // 保存图片到本地
        NSString *absoluteFilePath = [DemoCacheUtil saveImageData:newImageData forModuleType:DemoModuleTypeIot];
        
        sleep(5); //用来测试是否主线程是否会被阻塞(请在选择图片后，选择返回，看是否卡住)
        
        return absoluteFilePath;
    }];
}

+ (void)stopHook {
    [CJFileUploadPanel stopHook];
}


+ (NSData *)dealImage:(UIImage *)image {
    UIImage *newImage = [UIImage imageNamed:@"饮品2.jpg"];
    NSData *newImageData = UIImagePNGRepresentation(newImage);
    return newImageData;
}


@end
