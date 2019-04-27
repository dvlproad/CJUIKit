//
//  UIButton+CJPopoverListView.m
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIButton+CJPopoverListView.h"
#import "CJPopoverListView.h"

@implementation UIButton (CJPopoverListView)

/* 完整的描述请参见文件头部 */
- (void)cj_showDownPopoverListViewWithTitles:(NSArray<NSString *> *)titles
                              selectRowBlock:(void (^)(NSInteger selectedIndex))selectRowBlock
{
    //UIView *convertToView = self.view;
    UIView *convertToView = self.superview;
    
    CGPoint point_origin = CGPointMake(self.center.x, self.center.y + self.frame.size.height/2);
    CGPoint point = [self.superview convertPoint:point_origin toView:convertToView];
    
    CJPopoverListView *popoverView = [[CJPopoverListView alloc] initWithPoint:point titles:titles images:nil];
    popoverView.selectRowAtIndex = ^(NSInteger index) {
        [self setTitle:titles[index] forState:UIControlStateNormal];
        if (selectRowBlock) {
            selectRowBlock(index);
        }
    };
    [popoverView showPopoverView];
}

@end
