//
//  CQTwoEventSheetView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//   执行某个危险操作事件(如删除图片、解绑微信、注销账号)时候，需要弹出的确认提醒视图

#import "CQBaseTwoEventSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTwoEventSheetView : CQBaseTwoEventSheetView {
    
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param item1EventText       操作事项1的文字
 *  @param item1EventBlock      操作事项1的点击回调
 *  @param item2EventText       操作事项2的文字
 *  @param item2EventBlock      操作事项2的点击回调
 *
 *  @return  有两个操作事项的视图
 */
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                 item1EventIsDanger:(BOOL)item1EventIsDanger
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
