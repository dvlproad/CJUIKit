//
//  CJBadgeButton.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJBadgeButton : UIButton { //需要能够使用SDWebImage

    
}
@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, assign) BOOL showBadge;
@property (nonatomic, assign) CGFloat badgeSize UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIFont *badgeFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *badgeBackgroudColor UI_APPEARANCE_SELECTOR;

@end
