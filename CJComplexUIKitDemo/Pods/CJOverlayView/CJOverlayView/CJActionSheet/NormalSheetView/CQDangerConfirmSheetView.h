//
//  CQDangerConfirmSheetView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//   执行某个危险操作事件(如删除图片、解绑微信、注销账号)时候，需要弹出的确认提醒视图

#import "CQBaseTwoEventSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQDangerConfirmSheetView : CQBaseTwoEventSheetView {
    
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param cancelEventText      取消操作事项的文字
 *  @param cancelBlock          取消操作事项的点击回调
 *  @param dangerEventText      危险操作事项的文字（危险操作下常见的标题有：删除）
 *  @param dangerEventBlock     危险操作事项的点击回调
 *
 *  @return  执行某个危险操作事件时候，需要弹出的确认提醒视图
 */
- (instancetype)initWithDangerPromptTitle:(NSString *)promptTitle
                          cancelEventText:(NSString *)cancelEventText
                         cancelEventBlock:(void(^)(void))cancelEventBlock
                          dangerEventText:(NSString *)dangerEventText
                         dangerEventBlock:(void(^)(void))dangerEventBlock NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                 item1EventIsDanger:(BOOL)item1EventIsDanger
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
