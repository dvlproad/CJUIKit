//
//  UIImage+Save.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15-3-13.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIImage+Save.h"

@implementation UIImage (Save)

- (NSString *)getImageCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"CJImageCache"];
    return diskCachePath;
}


//将照片保存到程序应用中的Documents目录下
- (NSString *)saveToCachesByName:(NSString *)name {
    
    UIImage *image = self;
    
    /*
    clock_t start0 = clock();
//    UIImage *image = [self fixOrientation];
    UIImage *image = self;
    clock_t finish0 = clock();
    double duration0 = (double)(finish0 - start0)/CLOCKS_PER_SEC;
    
    
    NSData *imageData = nil;
    
    clock_t start2 = clock();
    imageData = UIImagePNGRepresentation(image);
    clock_t finish2 = clock();
    double duration2 = (double)(finish2 - start2)/CLOCKS_PER_SEC;
    
    if (imageData == nil) {                                     //判断图片是不是png格式的文件
        //返回图像
        clock_t start1 = clock();
        imageData = UIImageJPEGRepresentation(image, 1.0);
        clock_t finish1 = clock();
        double duration1 = (double)(finish1 - start1)/CLOCKS_PER_SEC;
        
        NSLog(@"图片原图处理，以及处理成①JPEG、②PNG的时间分别为 = %f, %f, %f", duration0, duration1, duration2);
    }
    */
    
//    NSString *imagePath = [QFileManager findUniquePathThatPrefix:@"Loc" suffix:nil type:@"jpg"];
    
    

    NSString *diskCachePath = [self getImageCachePath]; //得提前开个ImageCache目录，之后要补充
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
    }
    
    
    NSString *localPath = [diskCachePath stringByAppendingPathComponent:name];
    NSData *localData = UIImageJPEGRepresentation(image, 1.0f);
    
    if ([localData length] <= 1) {
        return nil;
    }
    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
//        
//    }
    
    clock_t start_save = clock();
    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:localPath contents:localData attributes:nil];
    if (!isSuccess) {
        NSLog(@"saveFail");
        return NULL;
    }
    clock_t finish_save = clock();
    double duration_save = (double)(finish_save - start_save)/CLOCKS_PER_SEC;
    NSLog(@"图片写进磁盘的时间为%f", duration_save);

    return localPath;
    
    /*
     BOOL isSuccess = [imageData writeToFile:imagePath atomically:YES];
     if (!isSuccess) {
     NSLog(@"saveFail: saveToDocuments");
     return NULL;
     }
     
     return imagePath;
     */

}




//- (NSString *)saveThumbToDocuments{
//    UIImage *image = [self fixOrientation];
//    
//    NSData *imageData = UIImagePNGRepresentation(image);
//    if (imageData == nil) {
//        imageData = UIImageJPEGRepresentation(image, 1.0);
//    }
//    
//    NSString *imagePath = [QFileManager findUniquePathThatPrefix:@"Loc" suffix:@"th" type:@"jpg"];
//    BOOL isSuccess = [imageData writeToFile:imagePath atomically:YES];
//    if (!isSuccess) {
//        NSLog(@"saveFail: saveThumbToDocuments");
//        return NULL;
//    }
//    
//    return imagePath;
//}




@end
