//
//  CQTSLocImageDataModel.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSLocImageDataModel : NSObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
