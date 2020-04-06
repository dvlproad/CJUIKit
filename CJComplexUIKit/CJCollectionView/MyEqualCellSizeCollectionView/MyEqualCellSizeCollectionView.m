//
//  MyEqualCellSizeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionView.h"
#import "MyEqualCellSizeCollectionViewDelegate.h"

@interface MyEqualCellSizeCollectionView () <UICollectionViewDelegateFlowLayout> {
    
}
@property (nonatomic, strong) MyEqualCellSizeCollectionViewDelegate *equalCellSizeCollectionViewDelegate;

@end



@implementation MyEqualCellSizeCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}


- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (layout == nil) {
        layout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
//    self.allowsMultipleSelection = YES;
    
    //self.backgroundColor = [UIColor clearColor];
    //为了解决MyEqualCellSizeCollectionView在某个自定义类里面使用，而不是在viewController中使用，而导致的无法实时准确的获取到CGRectGetWidth(self.frame)，从而来计算出准确的宽，所以我们应该采用实现协议的方法，而不是下面的这一行代码
    //放在这里设置flowLayout,会由于CGRectGetWidth(self.frame);初始太大而导致计算错误，所以请在调用此类的外面再设置
    //UICollectionViewFlowLayout *defaultFlowLayout = equalCellSizeSetting..xx..
    //[self setCollectionViewLayout:defaultFlowLayout animated:NO completion:nil];
}


/* 完整的描述请参见文件头部 */
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;//通过这种方式去获取layout，避免使用xib初始化的时候得不到
    flowLayout.scrollDirection = scrollDirection;
}


@end
