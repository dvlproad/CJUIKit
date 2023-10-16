//
//  CQActionSheetUtil3.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  特殊样式的SheetView的弹出方法

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQActionSheetUtil3 : NSObject {
    
}

#pragma mark - 更多操作(可以下滑)
/*
 *  弹出常用的更多事项选择弹窗(①没有取消、②标题"更多"、③可以下滑)
 *
 *  @param itemTitles           事项标题数组
 *  @param itemClickBlock       点击事件
 */
+ (void)showMoreSheetWithItemTitles:(NSArray<NSString *> *)itemTitles
                     itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock;

#pragma mark - 危险操作(不可以下滑)
#pragma mark 危险操作：二次封装的简洁接口
/// 删除取消提醒视图
+ (void)showDangerSheetForDeleteWithPromptTitle:(NSString *)promptTitle deleteEventBlock:(void(^)(void))deleteEventBlock;

#pragma mark 危险操作：完整的基本接口
/*
 *  弹出执行某个危险操作事件时候，需要弹出的确认提醒视图
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param cancelEventText      取消操作事项的文字
 *  @param cancelBlock          取消操作事项的点击回调
 *  @param dangerEventText      危险操作事项的文字
 *  @param dangerEventBlock     危险操作事项的点击回调
 */
+ (void)showDangerSheetWithPromptTitle:(NSString *)promptTitle
                       cancelEventText:(NSString *)cancelEventText
                      cancelEventBlock:(void(^ _Nullable)(void))cancelEventBlock
                       dangerEventText:(NSString *)dangerEventText
                      dangerEventBlock:(void(^)(void))dangerEventBlock;







#pragma mark - 安全操作(可以下滑)
#pragma mark 安全操作：二次封装的简洁接口
/*
 *  弹出安全操作事项的确认
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param safeEventText        操作事项的文字
 *  @param safeEventBlock       操作事项的点击回调
 */
+ (void)showSafeSheetWithPromptTitle:(NSString *)promptTitle
                       safeEventText:(NSString *)safeEventText
                      safeEventBlock:(void(^)(void))safeEventBlock;

#pragma mark 安全操作：完整的基本接口
/*
 *  弹出有两个操作事项的视图
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param item1EventText       操作事项1的文字
 *  @param item1EventBlock      操作事项1的点击回调
 *  @param item2EventText       操作事项2的文字
 *  @param item2EventBlock      操作事项2的点击回调
 */
+ (void)showTwoEventSheetWithPromptTitle:(NSString *)promptTitle
                          item1EventText:(NSString *)item1EventText
                         item1EventBlock:(void(^)(void))item1EventBlock
                          item2EventText:(NSString *)item2EventText
                         item2EventBlock:(void(^ _Nullable)(void))item2EventBlock;


/*
 *  弹出图片选择示例样图
 *
 *  @param pickImageHandle          选择"从手机相册选择"的回调
 */
+ (void)showSampleWithPickImageHandle:(void(^)(void))pickImageHandle;

@end

NS_ASSUME_NONNULL_END
