//
//  CQTSIconDataModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CQTSIconDataModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imagePlaceholderImage;
@property (nonatomic, assign) NSInteger badgeCount;

//+ (void)setupImageView:(UIImageView *)imageView withImageUrl:(NSString *)imageUrl;

@end
