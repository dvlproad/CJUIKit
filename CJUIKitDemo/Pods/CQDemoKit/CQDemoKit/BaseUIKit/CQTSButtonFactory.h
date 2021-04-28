//
//  CQTSButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQTSBorderStateButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSButtonFactory : NSObject

#pragma mark - themeBGButton
/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton;
+ (UIButton *)themeBGButtonWithTitle:(NSString *)title
                         actionBlock:(void(^)(UIButton *bButton))actionBlock;

#pragma mark - themeBorderButton
///以主题色为边框的按钮
+ (UIButton *)themeBorderButton;
+ (UIButton *)themeBorderButtonWithTitle:(NSString *)title
                             actionBlock:(void(^)(UIButton *bButton))actionBlock;

#pragma mark - submitButton
/*
 *  "重现bug"/"重现bug"的状态选择按钮(默认是bug已重现待修复的状态)
 *  @param fixBugHandle             修复bug要执行的操作
 *  @param reproduceBugHandle       重现bug要执行的操作
 */
+ (UIButton *)bugButtonWithFixBugHandle:(void(^)(void))fixBugHandle reproduceBugHandle:(void(^)(void))reproduceBugHandle;

/*
 *  "提交"/"修改"状态选择按钮(if you want to show editTitle, you should make selected == YES)
 *
 *  @param submitTitle              submitTitle(current selected should be YES)
 *  @param editTitle                editTitle(current selected should be NO)
 *  @param showEditTitle            showEditTitle(if you want to show editTitle, you should make selected == YES)
 *  @param clickSubmitTitleHandle   click submitTitle action
 *  @param clickEditTitleHandle     click editTitle action
 */
+ (UIButton *)submitButtonWithSubmitTitle:(NSString *)submitTitle
                                editTitle:(NSString *)editTitle
                            showEditTitle:(BOOL)showEditTitle
                   clickSubmitTitleHandle:(void(^)(UIButton *button))clickSubmitTitleHandle
                     clickEditTitleHandle:(void(^)(UIButton *button))clickEditTitleHandle;

@end

NS_ASSUME_NONNULL_END
