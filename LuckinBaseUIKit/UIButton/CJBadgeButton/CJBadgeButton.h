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
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, assign) CGFloat badgeLabelTop;
@property (nonatomic, assign) CGFloat badgeLabelRight;
@property (nonatomic, assign) CGFloat badgeLabelWidth;
@property (nonatomic, assign) CGFloat badgeLabelHeight;

@property (nonatomic, assign) NSInteger badge;

@end
