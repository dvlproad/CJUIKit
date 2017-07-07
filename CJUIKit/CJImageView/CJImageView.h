//
//  CJImageView.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJImageView : UIImageView { //直接继承自UIImageView是为了是使用SDWebImage

    
}

@property (nonatomic, assign) CGFloat imageCornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, assign) BOOL showBadge;
@property (nonatomic, assign) CGFloat badgeSize UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIFont *badgeFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *badgeBackgroudColor UI_APPEARANCE_SELECTOR;

/**
 *  设置CJImageView的点击事件
 *
 *  @param tapCompleteBlock    点击结束后执行的操作
 */
- (void)setTapCompleteBlock:(void(^)(CJImageView *imageView))tapCompleteBlock;

@end
