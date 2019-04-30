//
//  CJAppLastLaunchInfo.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAppLastLaunchInfo : NSObject <NSCoding> {
    
}
@property (nonatomic, copy) NSString *lastAppVersion;       /**< 上次退出app时候的version号 */
@property (nonatomic, copy) NSString *lastAppBuild;         /**< 上次退出app时候的bulid号 */

@property (nonatomic, assign, readonly) BOOL isFirstLaunchApp;          /**< 是否是第一次安装app */
@property (nonatomic, assign, readonly) BOOL isFirstLaunchThisVersion;  /**< 是否是第一次安装这个版本 */

@end
