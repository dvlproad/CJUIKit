//
//  CJDemoImagesChooseTableViewCell1.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoImagesChooseTableViewCell1.h"
#import "UIImage+CJBundleImage.h"

@implementation CJDemoImagesChooseTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *parentView = self.contentView;
    
    //UIImage *buttonImage = [UIImage imageNamed:@"two_icon_photo"];
    UIImage *buttonImage = [UIImage commonPickerImageNamed:@"two_icon_photo"];
    
    CJDemoImageChooseView1 *imageChooseView1 = [[CJDemoImageChooseView1 alloc] initWithDefaultPhotoImage:buttonImage];//高192
    [parentView addSubview:imageChooseView1];
    [imageChooseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(parentView).mas_offset(0);
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.height.mas_equalTo([CJDemoImageChooseView1 cellHeightWithContainTitle:YES]);
    }];
    self.imageChooseView1 = imageChooseView1;
    
    
    CJDemoImageChooseView1 *imageChooseView2 = [[CJDemoImageChooseView1 alloc] initWithDefaultPhotoImage:buttonImage];
    [parentView addSubview:imageChooseView2];
    [imageChooseView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageChooseView1.mas_top);
        make.left.mas_equalTo(imageChooseView1.mas_right).mas_offset(17);
        make.height.mas_equalTo(imageChooseView1.mas_height);
        make.width.mas_equalTo(imageChooseView1.mas_width);
        make.right.mas_equalTo(parentView).mas_offset(-20);
    }];
    self.imageChooseView2 = imageChooseView2;
}

#pragma mark - Class Method
+ (CGFloat)cellHeight {
    CGFloat imageChooseHeight = [CJDemoImageChooseView1 cellHeightWithContainTitle:YES];
    CGFloat cellHeight = imageChooseHeight;
    return cellHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
