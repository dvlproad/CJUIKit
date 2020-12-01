//
//  CQActionImageCollectionViewCell.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQActionImageCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, copy) void(^deleteHandle)(CQActionImageCollectionViewCell * bCell);

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, assign) BOOL hiddenDelete;


@end
