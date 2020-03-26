//
//  LEADPosModel.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/23.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface LEADPosModelList : NSObject

@property (nonatomic , strong)NSMutableArray *contentList;

@end

@interface LEADPosModel : NSObject

@property (nonatomic ,copy) NSString *title;
@property (nonatomic, copy) NSString *clickUrl;

@end

NS_ASSUME_NONNULL_END
