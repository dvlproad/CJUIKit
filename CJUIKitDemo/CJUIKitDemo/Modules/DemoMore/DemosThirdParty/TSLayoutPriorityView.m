//
//  TSLayoutPriorityView.m
//  CJUIKitDemo
//
//  Created by qian on 2021/4/7.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSLayoutPriorityView.h"
#import <Masonry/Masonry.h>

@interface TSLayoutPriorityView () {
    
}
@property (nonatomic, strong) UILabel *nameLabel;                   /**< 昵称 */
@property (nonatomic, strong) UIImageView *recognizePassImageView;  /**< 真人认证通过的标志 */

@end




@implementation TSLayoutPriorityView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.recognizePassImageView.hidden = YES;
    }
    return self;
}


- (void)updateName:(NSString *)name withRecognizePass:(BOOL)isRecognizePass {
    self.nameLabel.text = name;
    
    if (isRecognizePass) {
        self.recognizePassImageView.hidden = NO;
        self.recognizePassImageView.image = [UIImage imageNamed:@"recognize_icon_pass"];
        [self.recognizePassImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(6);
            make.width.mas_equalTo(72);
        }];
    } else {
        self.recognizePassImageView.hidden = YES;
        self.recognizePassImageView.image = nil;
        [self.recognizePassImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(0);
            make.width.mas_equalTo(0);
        }];
    }
}


- (void)setupViews {
    self.backgroundColor = [UIColor lightGrayColor];
    //self.nameLabel.backgroundColor = [UIColor redColor];
    //self.recognizePassImageView.backgroundColor = [UIColor greenColor];
    self.clipsToBounds = YES;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.recognizePassImageView];
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self.recognizePassImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(6);
        make.right.mas_equalTo(self).mas_offset(0).priority(250);
        make.centerY.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(72);
    }];
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:28];
    }
    return _nameLabel;
}

- (UIImageView *)recognizePassImageView {
    if (_recognizePassImageView == nil) {
        _recognizePassImageView = [[UIImageView alloc] init];
        _recognizePassImageView.image = [UIImage imageNamed:@"recognize_icon_pass"];
    }
    return _recognizePassImageView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
