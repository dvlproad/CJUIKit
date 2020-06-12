//
//  CQTSSwitchViewFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSSwitchViewFactory.h"
#import <Masonry/Masonry.h>
#import "UISwitch+CQTSMoreProperty.h"

@interface CQTSSwitchViewFactory () {
    
}

@end

@implementation CQTSSwitchViewFactory


#pragma mark - 含开关的视图
+ (UIView *)switchViewWithTitle:(NSString *)title
                       switchOn:(BOOL)switchOn
        switchValueChangedBlock:(void(^)(UISwitch *bSwitch))switchValueChangedBlock
{
    UIView *switchView = [[UIView alloc] init];
        
        
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    //mySwitch.on = YES;
    //mySwitch.tintColor = [UIColor redColor];    //设置按钮处于关闭状态时边框的颜色
    //mySwitch.onTintColor = [UIColor yellowColor];//设置开关处于开启时的状态
    //mySwitch.thumbTintColor = [UIColor blueColor];  //设置开关的状态钮颜色
    //[mySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    mySwitch.cqtsValueChangedBlock = switchValueChangedBlock;
    [switchView addSubview:mySwitch];
    [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(switchView).mas_offset(-4);
        make.centerY.mas_equalTo(switchView);
        make.size.mas_equalTo(CGSizeMake(49, 31));
    }];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentRight;
    [switchView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(switchView).mas_offset(4);
        make.right.mas_equalTo(mySwitch.mas_left).mas_offset(-4);
        make.top.bottom.mas_equalTo(switchView);
    }];
    
    
    mySwitch.on = switchOn;
    label.text = title;
    
    return switchView;
}

#pragma mark - Private Method


@end
