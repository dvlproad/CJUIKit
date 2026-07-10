//
//  CQPanLineView.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQPanLineView.h"
#import <Masonry/Masonry.h>

@implementation CQPanLineView

/*
 *  初始化弹窗视图
 *
 *  @param frame       frame
 *
 *  @return 弹窗视图
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.layer.masksToBounds = YES; // 防止其他视图添加了此视图，但高度为0的情况
        
        UIView *panLineView = [UIView new];
        panLineView.layer.cornerRadius = 4;
        panLineView.layer.masksToBounds = YES;
        panLineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [self addSubview:panLineView];
        [panLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(6);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(40);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
