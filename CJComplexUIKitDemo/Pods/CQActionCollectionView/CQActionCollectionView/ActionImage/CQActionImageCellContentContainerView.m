//
//  CQActionImageCellContentContainerView.m
//  TSImageAddDeleteListDemo
//
//  Created by ciyouzen on 2020/9/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQActionImageCellContentContainerView.h"
#import <Masonry/Masonry.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CQImageKit/UIView+CQOverlayImageBanned.h>

@implementation CQActionImageCellContentContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *addContainerView = [[UIImageView alloc] init];
        addContainerView.image = [UIImage imageNamed:@"CQActionCollectionView_ActionImageBundle.bundle/icon_cell_image_add"];
        addContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:addContainerView];
        [addContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.cjImageView = addContainerView;
        
        UILabel *flagLabel = [[UILabel alloc] init];
        flagLabel.textAlignment = NSTextAlignmentCenter;
        flagLabel.layer.masksToBounds = YES;
        flagLabel.layer.cornerRadius = 7;
        flagLabel.backgroundColor = CJColorFromHexString(@"#0C101B");
        flagLabel.text = NSLocalizedString(@"封面和头像", nil);
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
        [self addSubview:flagLabel];
        [flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(8);
            make.right.equalTo(self).mas_offset(-8);
            make.width.mas_equalTo(58);
            make.height.mas_equalTo(16);
        }];
        self.flagLabel = flagLabel;
    }
    return self;
}

///// 只调用一次暂时不放在初始化方法里
//- (void)configUIWithBannedSize:(CQBannedSize)bannedSize {
//    [self.cjImageView cq_configUIWithBannedSize:bannedSize];
//}

- (void)setFlagType:(CQActionImageFlagType)flagType {
    _flagType = flagType;

    if (flagType == CQActionImageFlagTypeNone) {
        self.flagLabel.hidden = YES;
    } else {
        self.flagLabel.hidden = NO;
        if (flagType == CQActionImageFlagTypeHighight) {
            self.flagLabel.backgroundColor = CJColorFromHexString(@"#0C101B");
        } else {
            self.flagLabel.backgroundColor = CJColorFromHexStringAndAlpha(@"#000000", 0.5);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
