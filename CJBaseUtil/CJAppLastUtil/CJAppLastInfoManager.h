//
//  CJAppLastInfoManager.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJAppLastInfo.h"

/**
 *  上一次退出前的APP信息
 */
@interface CJAppLastInfoManager : NSObject {
    
}
///获取App信息（之前已默认保存了 appVersion 和 appBuild）
+ (CJAppLastInfo *)getLastAppInfo;

///保存App信息（已默认保存了 appVersion 和 appBuild）
+ (void)updateLastAppInfoWithOtherUserInfo:(NSDictionary *)otherUserInfo;


@end
