//
//  CJActionSheetHeader.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetHeader : UIView {
    
}

#pragma mark - Update
/*
 *  更新标题，返回所占的高度
 *
 *  @param title        标题(可以为nil,为nil时候,高度为0)
 *  @param viewWidth    本header视图所占的宽度(常用于直接测试view显示时候使用)
 *
 *  @return 指定标题下本视图所占的高度
 */
- (CGFloat)updateTitle:(nullable NSString *)title withViewWidth:(CGFloat)viewWidth;

@end

NS_ASSUME_NONNULL_END
