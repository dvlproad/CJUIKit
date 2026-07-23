//
//  CQHorizontalTabBar.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalTabBar : UIView {
    
}
@property (nonatomic, copy, readonly) NSArray<NSString *> *titles;
@property (nonatomic, assign) NSInteger selectedIndex;

#pragma mark - Init
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
              tabSelectedBlock:(void(^)(NSInteger index))tabSelectedBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Action
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
