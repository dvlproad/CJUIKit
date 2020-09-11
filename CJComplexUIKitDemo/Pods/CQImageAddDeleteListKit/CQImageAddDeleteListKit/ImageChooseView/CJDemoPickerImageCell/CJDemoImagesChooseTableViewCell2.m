//
//  CJDemoImagesChooseTableViewCell2.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoImagesChooseTableViewCell2.h"
#import "UIImage+CJBundleImage.h"

@interface CJDemoImagesChooseTableViewCell2 () {
    
}
@property (nonatomic, assign, readonly) BOOL showImageChooseViewTitle;    /**< 是否显示图片选择框的title */

@end

@implementation CJDemoImagesChooseTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showImageChooseViewTitle = NO;
        [self setupViews];
    }
    return self;
}

#pragma mark - Setter
- (void)setAllowPickImage:(BOOL)allowPickImage {
    _allowPickImage = allowPickImage;
    
    self.imageChooseView1.allowPickImage = allowPickImage;
    self.imageChooseView2.allowPickImage = allowPickImage;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *parentView = self.contentView;
    
    [parentView addSubview:self.promptTitleLable];
    [self.promptTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(15);
        make.centerX.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(3);
        make.height.mas_equalTo(21);
    }];
    
    //UIImage *buttonImage = [UIImage imageNamed:@"two_icon_photo"];
    UIImage *buttonImage = [UIImage commonPickerImageNamed:@"two_icon_photo"];
    
    CJDemoImageChooseView2 *imageChooseView1 = [[CJDemoImageChooseView2 alloc] initWithDefaultPhotoImage:buttonImage containTitle:self.showImageChooseViewTitle];//高192
    [parentView addSubview:imageChooseView1];
    [imageChooseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promptTitleLable.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.height.mas_equalTo([CJDemoImageChooseView2 cellHeightWithContainTitle:YES]);
    }];
    self.imageChooseView1 = imageChooseView1;
    
    
    CJDemoImageChooseView2 *imageChooseView2 = [[CJDemoImageChooseView2 alloc] initWithDefaultPhotoImage:buttonImage containTitle:self.showImageChooseViewTitle];
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




+ (CGFloat)cellHeight {
    CGFloat imageChooseHeight = [CJDemoImageChooseView2 cellHeightWithContainTitle:NO];
    CGFloat cellHeight = 3+21+12+imageChooseHeight+3;
    return cellHeight;
}

#pragma mark - Lazy
- (UILabel *)promptTitleLable {
    if (_promptTitleLable == nil) {
        _promptTitleLable = [[UILabel alloc] init];
        _promptTitleLable.textAlignment = NSTextAlignmentLeft;
        _promptTitleLable.textColor = CJColorFromHexString(@"#333333");
        _promptTitleLable.font = [UIFont systemFontOfSize:15];
        NSString *prefixText = NSLocalizedString(@"上传健康证", nil);
        NSString *suffixText = NSLocalizedString(@"（至少要一张健康证照片）", nil);
        _promptTitleLable.attributedText = cjdemo_attributedText(0, prefixText, suffixText);
    }
    return _promptTitleLable;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
