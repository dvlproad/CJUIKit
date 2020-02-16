//
//  CJHUDSettingManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJHUDSettingManager : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *animationNamed;       /** Json动画文件名 */

+ (CJHUDSettingManager *)sharedInstance;

#pragma mark - 全局设置(APP启动时候调用)
/**
*  设置全局ProgressHUD的json文件名
*
*  @param animationNamed animationNamed
*/
- (void)configHUDAnimationWithAnimationNamed:(NSString *)animationNamed;

@end
