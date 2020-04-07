//
//  CQFilesLookBadgeCollectionViewCell.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQFilesLookBadgeCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, strong) UILabel *cjTextLabel;
@property (nonatomic, assign) NSLayoutConstraint *cjTextLabelHeightConstraint;

@property (nonatomic, strong) UIImageView *cjImageView;
@property (nonatomic, strong) UIButton *cjBadgeButton;

@end
