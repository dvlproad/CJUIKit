//
//  CJHomeMenuDataModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJHomeMenuDataModel : NSObject

@property (nonatomic, copy, nonnull) NSString *code;         /**< 菜单编码 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imagePlaceholderImage;
@property (nonatomic, assign) NSInteger badgeCount;

@end
