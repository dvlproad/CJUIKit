//
//  CJAppLastUser.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CJAppLastUser : NSObject {
    
}
@property (nonatomic, copy) NSString *lastLoginUserName;    /**< 上次退出app时候登录的账号 */
@property (nonatomic, copy) NSString *lastLoginPassword;    /**< 上次退出app时候登录的账号 */

@end
