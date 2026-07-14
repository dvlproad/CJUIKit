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
    NSString *bundleName = @"CQActionCollectionView_ActionImageBundle";
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : nil;
    
    UIImage *addImage = [UIImage imageNamed:@"icon_cell_image_add" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    UIImage *deleteIconImage = [UIImage imageNamed:@"icon_cell_image_delete" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    
    UIView *parentView = self.contentView;
    
    UIImageView *addContainerView = [[UIImageView alloc] init];
    addContainerView.image = addImage;
    addContainerView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    CQActionImageCellContentContainerView *contentContainerView = [[CQActionImageCellContentContainerView alloc] initWithFrame:CGRectZero];
    CQBaseAddDeleteContainerView *addDeleteContainerView = [[CQBaseAddDeleteContainerView alloc] initWithAddContainerView:addContainerView deleteIconImage:deleteIconImage containerMarginToTopRight:0 contentContainerView:contentContainerView];
    contentContainerView.layer.masksToBounds = YES;
    contentContainerView.layer.cornerRadius = 16;
    [self.contentView addSubview:addDeleteContainerView];
    [addDeleteContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [addDeleteContainerView configDeleteHandle:^{
        !self.deleteHandle ?: self.deleteHandle(self);
    }];
    /*
    // 不设置,而是靠的是 cell 的 didSelectItemAtIndexPath
    [addDeleteContainerView configAddHandle:^{
        
    } browseHandle:^{
        
    }];
    */
    
    _addDeleteContainerView = addDeleteContainerView;
}

/// 只调用一次暂时不放在初始化方法里
- (void)configUIWithBannedSize:(CQBannedSize)bannedSize {
    [self.contentContainerView.cjImageView cq_configUIWithBannedSize:bannedSize];
}

#pragma mark - Setter
- (void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
    
    if (isAdd) {
        [self.addDeleteContainerView showContentUIWithIsAddButton:YES];
    } else {
        [self.addDeleteContainerView showContentUIWithIsAddButton:NO];
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

- (instancetype)updateImage:(UIImage *)image {
    //[self showContentUIWithHiddenDeleteButton:NO];
    
    [self.cjImageView setImage:image];
    return self;
}

- (instancetype)makeImageContentMode:(UIViewContentMode)contentMode {
    [self.cjImageView setContentMode:contentMode];
    return self;
}



@end
