//
//  CQImageSheetView.m
//  CQOverlayKit
//
//  Created by qian on 2020/12/7.
//  Copyright © 2020年 dvlproad. All rights reserved.
//

#import "CQImageSheetView.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"

@interface CQImageSheetView () {
    
}
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void(^clickHandle)(CQImageSheetView *bSheetView);

@end

@implementation CQImageSheetView

/*
 *  图片选择示例样图
 *
 *  @param title                    标题
 *  @param image                    图片
 *  @param imageWithHeightRatio     图片的宽高比
 *  @param pickImageHandle          选择"从手机相册选择"的回调
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
         imageWithHeightRatio:(CGFloat)imageWithHeightRatio
                  clickHandle:(void(^)(CQImageSheetView *bSheetView))clickHandle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 30;
        self.layer.masksToBounds = YES;
        
        CJBaseOverlayThemeModel *themeModel = [CJBaseOverlayThemeManager sharedInstance].serviceThemeModel;
        UIColor *themeColor = themeModel.commonThemeModel.themeColor;
        UIColor *themeOppositeColor = themeModel.commonThemeModel.themeOppositeColor;
        
        CGFloat margin = 32;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [button setBackgroundColor:themeColor];
        [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
        [button setTitle:NSLocalizedString(@"从相册上传", nil) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self).mas_offset(-22-34);
            make.height.mas_equalTo(@50);
            make.left.mas_equalTo(self).offset(margin);
        }];
        self.button = button;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(margin);
            make.bottom.mas_equalTo(button.mas_top).mas_offset(-37);
            make.height.mas_equalTo(imageView.mas_width).multipliedBy(1.0/imageWithHeightRatio);
        }];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.textColor = themeColor;
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(40);
            make.bottom.mas_equalTo(imageView.mas_top).mas_offset(-29);
            make.height.mas_equalTo(18);
        }];
        
        
        self.imageView.image = image;
        _clickHandle = clickHandle;
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width - 2 *margin;
        CGFloat imageHeight = screenWidth * 1.0/imageWithHeightRatio;
        _totalHeight = 34+22+50+37 + imageHeight + 29+18+33;
        
    }
    return self;
}


- (void)clickButtonAction {
    !self.clickHandle ?: self.clickHandle(self);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
