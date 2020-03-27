//
//  CJCollectionDecoration.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/23.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJCollectionDecoration.h"
#import <Masonry/Masonry.h>
#import "CJCollectionViewLayoutAttributes.h"

@interface CJCollectionDecoration ()

@property (nonatomic, strong, readonly) UIView *bottomView;

@end

@implementation CJCollectionDecoration

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[CJCollectionViewLayoutAttributes class]]) {
        CJCollectionViewLayoutAttributes *attr = (CJCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
        if (!self.bottomView) {
            _bottomView = [[UIView alloc] init];
            _bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]; //#f4f4f4
            [self addSubview:_bottomView];
            [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self);
                make.height.mas_equalTo(10);
            }];
        }
    }
}

@end
