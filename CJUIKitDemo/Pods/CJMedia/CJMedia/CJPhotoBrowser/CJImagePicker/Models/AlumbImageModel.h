//
//  AlumbImageModel.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlumbImageModel : NSObject

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) int type;

@end
