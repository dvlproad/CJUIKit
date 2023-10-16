//
//  CQHorizontalLabelLabelView.m
//  BiaoliApp
//
//  Created by qian on 2020/12/25.
//

#import "CQHorizontalLabelLabelView.h"

@implementation CQHorizontalLabelLabelView

- (instancetype)initWithLeftViewSize:(CGSize)leftViewSize
                    iconTitleSpacing:(CGFloat)iconTitleSpacing
          contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    return [super initWithLeftViewCreateBlock:^UIView * _Nonnull{
        UILabel *emojiLabel = [[UILabel alloc] init];
        emojiLabel.backgroundColor = [UIColor clearColor];
        return emojiLabel;
    
    } rightViewCreateBlock:^UIView * _Nonnull{
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        return textLabel;
        
    } leftViewSize:leftViewSize twoViewSpacing:iconTitleSpacing contentHorizontalAlignment:contentHorizontalAlignment];
}

#pragma mark - Get Method
- (UILabel * _Nonnull)flagTitleLabel {
    return self.leftView;
}

- (UILabel * _Nonnull)formatTitleLabel {
    return self.rightView;
}

#pragma mark - Update
- (void)updateLeftText:(nullable NSString *)leftText rightText:(nullable NSString *)rightText {
    self.flagTitleLabel.text = leftText;
    self.formatTitleLabel.text = rightText;
    
    [super reconstraintWithShowLeftView:leftText.length>0 showRightView:rightText.length>0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
