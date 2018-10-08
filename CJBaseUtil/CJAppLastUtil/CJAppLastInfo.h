//
//  CJAppLastInfo.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAppLastInfo : NSObject <NSCoding> {
    
}
@property (nonatomic, copy) NSString *lastAppVersion;       /**< 上次退出app时候的version号 */
@property (nonatomic, copy) NSString *lastAppBuild;         /**< 上次退出app时候的bulid号 */
@property (nonatomic, strong) NSDictionary *otherUserInfo;  /**< 上次退出app时候的其他信息(如是否点完了引导页) */

@property (nonatomic, assign, readonly) BOOL isFirstInstallApp;         /**< 是否是第一次安装app */
@property (nonatomic, assign, readonly) BOOL isFirstInstallThisVersion; /**< 是否是第一次安装这个版本 */

@end
