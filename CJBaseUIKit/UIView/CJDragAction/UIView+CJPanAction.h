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
 *  添加pan手势
 *
 *  @param panCompleteDismissBlock      拖动结束需要执行dimiss的回调(其他部分已自动内部设置frame)
 */
- (void)cj_addPanWithPanCompleteDismissBlock:(void(^)(void))panCompleteDismissBlock;

/*
 *  添加pan手势
 *
 *  @param paningOffsetBlockpan         拖动进行中的回调(isDown:是否是向下，offset:偏移量)
 *  @param cjPanCompleteBlock           拖动结束的回调(isFast:是类似轻扫的那种)
 */
- (void)cj_addPanWithPaningOffsetBlock:(void(^)(BOOL isDown, CGPoint offset))paningOffsetBlock
                      panCompleteBlock:(void(^)(BOOL isFast))panCompleteBlock;

@end

NS_ASSUME_NONNULL_END
