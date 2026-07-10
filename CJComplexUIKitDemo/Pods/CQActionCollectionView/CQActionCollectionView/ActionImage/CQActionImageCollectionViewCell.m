//
//  CQActionImageCollectionViewCell.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQActionImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "CQBaseAddDeleteContainerView.h"
#import "CQActionImageCellContentContainerView.h"
#import <CQImageKit/UIView+CQOverlayImageBanned.h>

@interface CQActionImageCollectionViewCell () {
    
}
@property (nonatomic, strong, readonly) CQBaseAddDeleteContainerView *addDeleteContainerView;

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
    
    
    UIImageView *addContainerView = [[UIImageView alloc] init];
    addContainerView.image = [UIImage imageNamed:@"CQActionCollectionView_ActionImageBundle.bundle/icon_cell_image_add"];
    addContainerView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImage *deleteIconImage = [UIImage imageNamed:@"CQActionCollectionView_ActionImageBundle.bundle/icon_cell_image_delete"];
    
    CQActionImageCellContentContainerView *contentContainerView = [[CQActionImageCellContentContainerView alloc] initWithFrame:CGRectZero];
    CQBaseAddDeleteContainerView *addDeleteContainerView = [[CQBaseAddDeleteContainerView alloc] initWithAddContainerView:addContainerView deleteIconImage:deleteIconImage containerMarginToTopRight:0 contentContainerView:contentContainerView];
    contentContainerView.layer.masksToBounds = YES;
    contentContainerView.layer.cornerRadius = 16;
    [self.contentView addSubview:addDeleteContainerView];
    [addDeleteContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [addDeleteContainerView configAddHandle:^{
        
    } deleteHandle:^{
        !self.deleteHandle ?: self.deleteHandle(self);
        
    } browseHandle:^{
        
    }];
    
    _addDeleteContainerView = addDeleteContainerView;
}

/// 只调用一次暂时不放在初始化方法里
- (void)configUIWithBannedSize:(CQBannedSize)bannedSize {
    [self.contentContainerView.cjImageView cq_configUIWithBannedSize:bannedSize];
}


- (void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
    if (isAdd) {
        [self.addDeleteContainerView showNoDataUI:YES];
        
    } else {
        [self.addDeleteContainerView showNoDataUI:NO];
    }
}

- (CQActionImageCellContentContainerView *)contentContainerView {
    CQActionImageCellContentContainerView *contentContainerView = (CQActionImageCellContentContainerView *)self.addDeleteContainerView.contentContainerView;
    return contentContainerView;
}

- (UIImageView *)cjImageView {
    return self.contentContainerView.cjImageView;
}

- (void)setFlagType:(int)flagType {
    self.contentContainerView.flagType = flagType;
}


- (void)updateImage:(UIImage *)image {
    [self.contentContainerView.cjImageView setImage:image];
}



@end
