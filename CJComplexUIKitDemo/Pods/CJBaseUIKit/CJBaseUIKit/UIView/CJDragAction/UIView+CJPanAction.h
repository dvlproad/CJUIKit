//
//  UIView+CJPanAction.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/05/10.
//  Copyright © 2019年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPanAction) {
    
}
@property (nonatomic, assign, readonly) CGRect cjPanStartFrame;   /**< 拖动开始时候视图的frame位置(用于复原等操作) */


/*
 *  添加pan手势：设置视图拖动结束且应该消失时候，应该执行的操作
 *  ps: ①已自动实现拖动过程中，视图frame的变化
 *      ②已自动实现拖动结束，当未拖动到视图初始位置一半的时候，自动恢复视图到初始frame
 *
 *  @param panCompleteDismissBlock      视图拖动结束且应该消失时候，应该执行的操作
 */
- (void)cj_addPanWithPanCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock;

/*
 *  添加pan手势
 *  ps:①已自动实现拖动过程中，视图frame的变化
 *
 *  @param panCompleteBlock             拖动结束的回调(isFast:是类似轻扫的那种)
 */
- (void)cj_addPanWithPanCompleteBlock:(void(^ _Nullable)(BOOL isFast))panCompleteBlock;

/*
 *  添加pan手势
 *
 *  @param paningOffsetBlockpan         拖动进行中的回调(isDown:是否是向下，offset:偏移量)
 *  @param panCompleteBlock             拖动结束的回调(isFast:是类似轻扫的那种)
 */
- (void)cj_addPanWithPaningOffsetBlock:(void(^)(BOOL isDown, CGPoint offset))paningOffsetBlock
                      panCompleteBlock:(void(^ _Nullable)(BOOL isFast))panCompleteBlock;

@end

NS_ASSUME_NONNULL_END
