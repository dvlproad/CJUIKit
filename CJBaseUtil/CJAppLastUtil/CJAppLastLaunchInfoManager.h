//
//  CJAppLastLaunchInfoManager.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJAppLastLaunchInfo.h"

/**
 *  上一次启动的APP信息
 */
@interface CJAppLastLaunchInfoManager : NSObject {
    
}
///获取上次启动后的App信息（之前已默认保存了 appVersion 和 appBuild）
+ (CJAppLastLaunchInfo *)getLastLaunchInfo;

///更新本次启动后的App信息（已默认保存了 appVersion 和 appBuild）
+ (void)updateLastLaunchInfo;


@end
