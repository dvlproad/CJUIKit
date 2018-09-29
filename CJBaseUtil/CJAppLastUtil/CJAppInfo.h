//
//  CJAppInfo.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJRootViewControllerType) {
    CJRootViewControllerTypeNoneEverLaunch = 0, /**< 未曾启动 */
    CJRootViewControllerTypeGuide,
    CJRootViewControllerTypeLogin,
    CJRootViewControllerTypeMain,               /**< 登录成功以及游客直接跳过登录进入主页的 */
};

@interface CJAppInfo : NSObject <NSCoding> {
    
}
@property (nonatomic, copy) NSString *lastAppVersion;   /**< 上次退出app时候的version号 */
@property (nonatomic, copy) NSString *lastAppBuild;     /**< 上次退出app时候的bulid号 */
@property (nonatomic, assign) CJRootViewControllerType lastAppRootViewControllerType;
@property (nonatomic, strong) NSDictionary *otherUserInfo;

@property (nonatomic, assign, readonly) BOOL isFirstInstallApp;         /**< 是否是第一次安装app */
@property (nonatomic, assign, readonly) BOOL isFirstInstallThisVersion; /**< 是否是第一次安装这个版本 */

@end
