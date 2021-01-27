//
//  TSHideWindowView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/18.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSHideWindowView.h"
#import "UIView+CJPopupInView.h"
#import "UIView+CJPopupSuperviewSubview.h"

@implementation TSHideWindowView

+ (void)popWindows:(NSInteger)count {
    NSInteger windowCount = count;
    for (NSInteger i = 0; i < windowCount; i++) {
        TSHideWindowView *label = [[TSHideWindowView alloc] init];
        label.backgroundColor = CJColorRandom;
        label.text = [NSString stringWithFormat:@"%zd", i];
        
        CGFloat height = 100+random()%200;
        if (i%2 == 0) {
            [label popupInCenterWithHeight:height];
        } else {
            [label popupInBottomWithHeight:height];
        }
    }
}

+ (void)hideWindowPopupViews {
    [UIView hideWindowPopupViews];
}

+ (void)reshowWindowPopupViews {
    [UIView reshowWindowPopupViews];
}



/*
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInCenterWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    //CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat popupViewWidth = screenWidth-2*15;
    CGFloat popupViewWidth = 260;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    
    // 执行显示弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    [self cj_popupInCenterWindow:CJAnimationTypeNormal withSize:popupViewSize centerOffset:CGPointZero blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [weakPopupView cj_hidePopupView];
    }];
}


/*
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)popupInBottomWithHeight:(CGFloat)popupViewHeight {
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    
    // 执行显示弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [weakPopupView cj_hidePopupView];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
