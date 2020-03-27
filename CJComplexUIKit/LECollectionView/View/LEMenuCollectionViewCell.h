//
//  LEMenuCollectionViewCell.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/21.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEMenuCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

- (void)displayMessageWithCount:(NSInteger)messageCount;

@end

NS_ASSUME_NONNULL_END
