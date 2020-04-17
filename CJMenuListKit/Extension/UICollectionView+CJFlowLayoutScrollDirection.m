//
//  UICollectionView+CJFlowLayoutScrollDirection.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/4/8.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UICollectionView+CJFlowLayoutScrollDirection.h"
#import <objc/runtime.h>

@implementation UICollectionView (CJFlowLayoutScrollDirection)

//cjScrollDirection
- (UICollectionViewScrollDirection)cjScrollDirection {
    return [objc_getAssociatedObject(self, @selector(cjScrollDirection)) integerValue];
}

- (void)setCjScrollDirection:(UICollectionViewScrollDirection)cjScrollDirection {
    objc_setAssociatedObject(self, @selector(cjScrollDirection), @(cjScrollDirection), OBJC_ASSOCIATION_ASSIGN);
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;//通过这种方式去获取layout，避免使用xib初始化的时候得不到
    flowLayout.scrollDirection = cjScrollDirection;
}

@end
