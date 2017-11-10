//
//  CJPhotoGroupTableViewCell.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJPhotoGroupTableViewCell.h"

@implementation CJPhotoGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit]; //cell页面布局
    }
    return self;
}


- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    self.headView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(1);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(79);
    }];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.headView.mas_right).mas_offset(10);
    }];
    
    self.num = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.num];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        
        make.left.mas_equalTo(self.name.mas_right).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-40);
    }];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
