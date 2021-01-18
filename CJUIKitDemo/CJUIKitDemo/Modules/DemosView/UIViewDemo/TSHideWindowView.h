//
//  TSHideWindowView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/18.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSHideWindowView : UILabel


+ (void)popWindows:(NSInteger)count;
+ (void)hideWindowPopupViews;
+ (void)reshowWindowPopupViews;



/*
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInCenterWithHeight:(CGFloat)popupViewHeight;


/*
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInBottomWithHeight:(CGFloat)popupViewHeight;

@end

NS_ASSUME_NONNULL_END
