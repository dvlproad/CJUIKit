//
//  DataEmptyViewFactory.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "CJDataEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataEmptyViewFactory : NSObject

/**
 *  网络空视图
 *
 *  @param successReloadBlock 网络有效时候的reload操作
 *
 *  @return 空视图
 */
+ (CJDataEmptyView *)networkEmptyViewWithSuccess:(void(^)(void))successReloadBlock;

@end

NS_ASSUME_NONNULL_END
