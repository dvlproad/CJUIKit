//
//  CJCacheDataModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJCacheDataModel : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cacheToRelativeDirectoryPath; /**< 相对路径 */

@end
