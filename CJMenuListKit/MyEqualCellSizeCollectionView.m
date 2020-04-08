//
//  MyEqualCellSizeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionView.h"
#import "UICollectionView+CJFlowLayoutScrollDirection.h"

@interface MyEqualCellSizeCollectionView () <UICollectionViewDelegateFlowLayout> {
    
}

@end



@implementation MyEqualCellSizeCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (layout == nil) {
        layout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //UICollectionViewFlowLayout *defaultFlowLayout = equalCellSizeSetting..xx..
        //[self setCollectionViewLayout:defaultFlowLayout animated:NO completion:nil];
    }
    
    return self;
}



/* 完整的描述请参见文件头部 */
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    
    self.cjScrollDirection = scrollDirection;
}


@end
