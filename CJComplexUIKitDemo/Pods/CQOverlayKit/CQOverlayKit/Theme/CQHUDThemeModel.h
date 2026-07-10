//
//  CQHUDThemeModel.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

// HUD 主题
@interface CQHUDThemeModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *animationNamed;       /** Json动画文件名 */
@property (nonatomic, copy, readonly) NSBundle *animationBundle;    /** Json动画文件所在的bundle(如果是在MainBundle中，则可直接设为nil) */

/*
*  设置HUD加载动画对应的json文件名
*
*  @param animationNamed    动画对应的json文件名
*  @param animationBundle   动画对应的json文件所在的bundle(如果是在MainBundle中，则可直接设为nil)
*/
- (void)updateAnimationNamed:(NSString *)animationNamed animationBundle:(NSBundle *)animationBundle;

#pragma mark - Public
/// 库中加载动画的json文件所在的bundle
+ (NSBundle *)currentHUDBundle;

@end



