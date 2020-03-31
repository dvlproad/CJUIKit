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
        
        //TEST:测试添加背景
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        NSIndexPath *indexPath = attr.indexPath;
        if (indexPath.section == 0) {
            imageView.image = [UIImage imageNamed:@"MemoryAD29.jpg"];
        } else if (indexPath.section == 1) {
            imageView.image = [UIImage imageNamed:@"bg.jpg"];
        } else if (indexPath.section == 2) {
            imageView.image = [UIImage imageNamed:@"bgSky.jpg"];
        } else {
            imageView.image = [UIImage imageNamed:@"bg.jpg"];
        }
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.bottom.mas_equalTo(-10);
        }];
        
        UIButton *moveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [moveButton addTarget:self action:@selector(__cjMoveDecorationAction) forControlEvents:UIControlEventTouchUpInside];
        moveButton.backgroundColor = [UIColor blueColor];
        [self addSubview:moveButton];
        [moveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(10);
            make.right.mas_equalTo(self).mas_offset(-10);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(80);
        }];
        
        UILongPressGestureRecognizer *moveGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__cjMoveDecorationAction:)];
        moveGR.minimumPressDuration = 0.3;
        [moveButton addGestureRecognizer:moveGR];
    }
}

//- (void)__cjMoveDecorationAction:(UIButton *)moveButton {
//
//}

///// 拖动过程中的监听
- (void)__cjMoveDecorationAction:(UILongPressGestureRecognizer *)moveLongPressGR {
    // 由于在collection View 中没有找到可以获取到该视图的接口，所以暂时用通知来动态改变背景图片
    // 参考资料：iOS UICollectionView 的装饰视图 https://www.jianshu.com/p/c63e3e769842
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCJMoveDecorationAction" object:moveLongPressGR];
    
//    static NSInteger fromSection = 0;    // 记录section，防止跨section移动
//    static NSInteger lastSection = 0;
//
//    //判断手势落点位置是否在row上
//    CGPoint longPressLocationPoint = [moveLongPressGR locationInView:self];
//    NSIndexPath *indexPath = [self indexPathForItemAtPoint:longPressLocationPoint];
//    switch (moveLongPressGR.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            //手势开始
//            if (indexPath == nil) {
//                //NSLog(@"手势落点位置没落在哪个indexPath位置上");
//                break;
//            }
//
//            UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
//            [self bringSubviewToFront:cell];
//            //iOS9 方法 移动cell
//            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
//            fromSection = indexPath.section;
//            lastSection = indexPath.section;
//
//            break;
//        }
//        case UIGestureRecognizerStateChanged:
//        {
//            NSInteger toSection = 0;
//            if (indexPath == nil) {
//                toSection = lastSection;
//            } else {
//                toSection = indexPath.section;
//            }
//            lastSection = toSection;
//
//            BOOL moveEnable = self.cjCheckCellMoveEnableBlock == nil || self.cjCheckCellMoveEnableBlock(fromSection, toSection);
//            if (moveEnable) {
//                //iOS9 方法 移动过程中随时更新cell位置
//                [self updateInteractiveMovementTargetPosition:longPressLocationPoint];
//            } else {
//                NSString *message = [NSString stringWithFormat:@"不能从%zd区移动到%zd区", fromSection, toSection];
//                NSLog(@"温馨提示:%@", message);
//            }
//            break;
//        }
//        case UIGestureRecognizerStateEnded:
//        {
//            //手势结束
//            //iOS9方法 移动结束后关闭cell移动
//            [self endInteractiveMovement];
//            [self __cjMoveEnd];
//            break;
//        }
//        default:
//        {
//            //取消移动
//            [self cancelInteractiveMovement];
//            [self __cjMoveEnd];
//
//            break;
//        }
//    }
}

                                  

@end
