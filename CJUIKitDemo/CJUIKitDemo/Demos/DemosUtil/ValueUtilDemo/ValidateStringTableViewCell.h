//
//  ValidateStringTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface ValidateStringTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, copy) void (^validateHandle)(ValidateStringTableViewCell *mcell);


@end
