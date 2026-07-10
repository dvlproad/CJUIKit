//
//  CJUploadCollectionViewCell.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJNetwork/CJUploadProgressView.h>

@interface CJUploadCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, copy) void(^deleteHandle)(CJUploadCollectionViewCell * cell);

@property (nonatomic, strong) UILabel *cjTextLabel;
@property (nonatomic, assign) NSLayoutConstraint *cjTextLabelHeightConstraint;

@property (nonatomic, strong) UIImageView *cjImageView;
@property (nonatomic, strong) UIButton *cjDeleteButton;



@property (nonatomic, strong) CJUploadProgressView *uploadProgressView;

@end
