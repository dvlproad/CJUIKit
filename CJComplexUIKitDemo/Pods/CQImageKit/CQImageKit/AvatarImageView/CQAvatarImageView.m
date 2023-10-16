//
//  CQAvatarImageView.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQAvatarImageView.h"
#import "UIImageView+CQUtil.h"
#import "UIView+CQOverlayImageBanned.h"

@implementation CQAvatarImageView

#pragma mark - Init
/*
 *  初始化【有圆角的】头像视图
 *
 *  @param size         头像的大小，用于设置圆角(宽高1:1)
 *  @param borderWidth  头像的边框(可以为0)
 *  @param bannedSize   头像违规时候的违规标记大小（规则详看.h顶部描述）
 *
 *  @return 【有圆角的】头像视图
 */
- (instancetype)initWithSize:(CGFloat)size borderWidth:(CGFloat)borderWidth bannedSize:(CQBannedSize)bannedSize {
    self = [self initWithFrame:CGRectZero bannedSize:bannedSize];
    if (self) {
        self.layer.cornerRadius = size/2;
        
        if (borderWidth > 0) {
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.layer.borderWidth = borderWidth;
        }
        
        self.userInteractionEnabled = YES; // UIImageView的userInteractionEnabled默认是NO
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__clickAction:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)__clickAction:(UITapGestureRecognizer *)tapGR {
    !self.clickHandle ?: self.clickHandle();
}

/*
 *  初始化【无圆角的】头像视图：场景：该视图常为其他视图的背景
 *
 *  @param frame        frame
 *  @param bannedSize   头像违规时候的违规标记大小（规则详看.h顶部描述）
 *
 *  @return 【无圆角的】头像视图
 */
- (instancetype)initWithFrame:(CGRect)frame bannedSize:(CQBannedSize)bannedSize {
    self = [super initWithBannedSize:bannedSize];
    if (self) {
        self.layer.masksToBounds = YES;
        
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

#pragma mark - Overwrite
- (void)updateImageWithNetImageModel:(CQStatusImageModel *)imageModel {
    [super updateImageWithNetImageModel:imageModel imageUseType:CQImageUseTypeAvatar];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
