//
//  UIImage+Save.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15-3-13.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Save)

- (NSString *)getImageCachePath;

- (NSString *)saveToCachesByName:(NSString *)name;

@end
