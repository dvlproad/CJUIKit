//
//  CQHomeMenuCollectionViewCell.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/21.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHomeMenuCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) NSInteger badgeCount;

@end

NS_ASSUME_NONNULL_END
