//
//  CJUploadVideoItem.m
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2017/2/23.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadVideoItem.h"

#ifdef CJTESTPOD
#import "UIImage+CJTransformSize.h"
#else
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#endif

@implementation CJUploadVideoItem

/** 完整的描述请参见文件头部 */
- (instancetype)initWithShowImage:(UIImage *)showImage
           imageLocalRelativePath:(NSString *)imageLocalRelativePath
           videoLocalRelativePath:(NSString *)videoLocalRelativePath
                      uploadItems:(NSArray<CJUploadItemModel *> *)uploadItems
{
    self = [super init];
    if (self) {
        self.image = [self adjustImageWithImage:showImage];
        
        self.imageLocalRelativePath = imageLocalRelativePath;
        self.videoLocalRelativePath = videoLocalRelativePath;
        self.uploadItems = [NSMutableArray arrayWithArray:uploadItems];
    }
    
    return self;
}

- (UIImage *)adjustImageWithImage:(UIImage *)image
{
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    NSLog(@"origin --imageData : %f MB size:%@",(unsigned long)[imageData length]/(1024*1024.f),[NSValue valueWithCGSize:image.size]);
    
    if ([imageData length] > 0.5 * 1024 * 1024) {
        imageData = UIImageJPEGRepresentation(image, 0.8);
        if ([imageData length] > 0.5 * 1024 * 1024) {
            UIImage *tempImage = [UIImage imageWithData:imageData];
            image = [tempImage cj_transformImageToSize:CGSizeMake(1920, 1920) withScaleType:CJScaleTypeMinification];
        }
        
        imageData = UIImageJPEGRepresentation(image,0.8);
        NSLog(@"result has scaled -- imageData : %f MB size:%@",(unsigned long)imageData.length/(1024*1024.f),[NSValue valueWithCGSize:image.size]);
        
        image = [UIImage imageWithData:imageData];
        return image;
    }
    else
    {
        return image;
    }
}


@end
