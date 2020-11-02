//
//  CJMediaBrowserUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/6.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJMediaBrowserUtil : NSObject

/*
*  查看视频
*
*  @param localRelativePath    视频的本地相对路径
*/
+ (void)browseVideoWithLocalRelativePath:(NSString *)localRelativePath;

/*
*  查看图片
*
*  @param image     当前的图片
*  @param images    图片数组里
*/
+ (void)browseImage:(UIImage *)image inImages:(NSArray<UIImage *> *)images;

@end

NS_ASSUME_NONNULL_END
