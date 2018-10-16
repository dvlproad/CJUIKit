//
//  CJPopoverListView.h
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDrawRectUtil.h"

@interface CJPopoverListView : UIView {
    
}
- (instancetype)initWithPoint:(CGPoint)point titles:(NSArray<NSString *> *)titles images:(NSArray<UIImage *> *)images;
- (void)showPopoverView;
- (void)dismissPopoverView:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end
