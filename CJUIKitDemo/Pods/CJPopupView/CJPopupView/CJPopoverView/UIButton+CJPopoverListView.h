//
//  UIButton+CJPopoverListView.h
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJPopoverListView)

/**
 *  在本View下面显示一个带箭头的列表视图
 *
 *  @param titles           列表视图上的titles
 *  @param selectRowBlock   列表视图选择某行完后的方法
 */
- (void)cj_showDownPopoverListViewWithTitles:(NSArray<NSString *> *)titles
                              selectRowBlock:(void (^)(NSInteger selectedIndex))selectRowBlock;

@end
