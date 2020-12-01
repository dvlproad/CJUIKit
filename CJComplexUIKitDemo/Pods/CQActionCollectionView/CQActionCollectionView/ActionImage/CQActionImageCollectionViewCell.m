//
//  CQActionImageCollectionViewCell.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQActionImageCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface CQActionImageCollectionViewCell () {
    
}
@property (nonatomic, strong) UIImageView *cjImageView;
@property (nonatomic, strong) UIButton *cjDeleteButton;

@end

@implementation CQActionImageCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

- (void)commonInit {
    UIView *parentView = self.contentView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"CQActionCollectionView_ActionImageBundle.bundle/icon_cell_image_add"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    self.cjImageView = imageView;
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"CQActionCollectionView_ActionImageBundle.bundle/icon_cell_image_delete"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(__deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parentView).offset(0);
        make.right.equalTo(parentView).offset(-0);
        make.width.height.equalTo(@25);
    }];
    self.cjDeleteButton = deleteButton;
    
    [parentView bringSubviewToFront:self.cjDeleteButton]; //把cjDeleteButton移动最前
}

#pragma mark - Setter
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.cjImageView.image = image;
}

- (void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
//
//    if (isAdd) {
//        self.cjImageView.image = [UIImage imageNamed:@"CQImageAddDeleteListKit_ActionImageBundle.bundle/icon_cell_image_add"];
//    }
}

- (void)setHiddenDelete:(BOOL)hiddenDelete {
    _hiddenDelete = hiddenDelete;
    
    self.cjDeleteButton.hidden = hiddenDelete;
}


#pragma mark - Private Method
- (void)__deleteButtonAction:(UIButton *)sender {
    if (self.deleteHandle) {
        self.deleteHandle(self);
    }
}


@end
