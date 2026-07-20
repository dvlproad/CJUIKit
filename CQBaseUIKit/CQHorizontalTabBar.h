//
//  CQHorizontalTabBar.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalTabBar : UIView

@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
              tabSelectedBlock:(void(^)(NSInteger index))tabSelectedBlock;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
