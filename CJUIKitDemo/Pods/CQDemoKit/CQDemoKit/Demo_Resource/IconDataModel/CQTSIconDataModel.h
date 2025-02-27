//
//  CQTSIconDataModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSIconDataModel : NSObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, strong) UIImage *imagePlaceholderImage;
@property (nonatomic, assign) NSInteger badgeCount;

@property (nonatomic, assign) BOOL selected;    /**< 是否选中状态 */

@end

NS_ASSUME_NONNULL_END
