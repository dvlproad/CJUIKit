//
//  CJUIKitBaseViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitBaseViewController : UIViewController {
    
}

#pragma mark - 测试进入其他视图的情况（从导航栏右键）
/// 测试进入其他视图的情况（从导航栏右键）
- (void)tsGoOtherViewControllerByRightBarButtonItem;

#pragma mark - 测试切换不同操作（从导航栏右键）
/// 测试切换不同操作（从导航栏右键）：当前显示的是 editTitle
- (void)tsChangeByRightBarButtonItemWithSubmitTitle:(NSString *)submitTitle
                                          editTitle:(NSString *)editTitle
                              clickSubmitTitleBlock:(void(^)(void))clickSubmitTitleBlock
                                clickEditTitleBlock:(void(^)(void))clickEditTitleBlock;

@end

NS_ASSUME_NONNULL_END
