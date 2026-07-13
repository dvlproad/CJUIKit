//
//  CJAlumbImageModel.h
//  UIKit-ImagePicker-iOS
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAlumbImageModel : NSObject

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) int type;

@end
NS_ASSUME_NONNULL_END
