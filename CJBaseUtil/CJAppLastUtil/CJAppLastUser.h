//
//  CJAppLastUser.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAppLastUser : NSObject {
    
}
@property (nonatomic, copy) NSString *lastLoginUserName;    /**< 上次退出app时候登录userName */
@property (nonatomic, copy) NSString *lastLoginAccessToken; /**< 上次退出app时候登录的accessToken */

@end

NS_ASSUME_NONNULL_END
