//
//  UIView+CQOverlayImageBanned.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIView+CQOverlayImageBanned.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import "UIImage+CQImageKit.h"

@interface UIView () {
    
}

@end


@implementation UIView (CQOverlayImageBanned)

//cqOverlayImageBanned
- (CQVerticalImageLabelView *)cqOverlayImageBanned {
    return objc_getAssociatedObject(self, @selector(cqOverlayImageBanned));
}

- (void)setCqOverlayImageBanned:(CQVerticalImageLabelView *)cqOverlayImageBanned {
    objc_setAssociatedObject(self, @selector(cqOverlayImageBanned), cqOverlayImageBanned, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Config
/// 只调用一次暂时不放在初始化方法里
- (void)cq_configUIWithBannedSize:(CQBannedSize)bannedSize {
    if (bannedSize == CQBannedSizeSmall) {              // 小框：只有图片标记，没有文字说明
        [self cq_configUIWithBannedIconHeight:22 iconTitleSpacing:0 showTitlte:NO];
        
    } else if (bannedSize == CQBannedSizeMiddle) {
        [self cq_configUIWithBannedIconHeight:36 iconTitleSpacing:6 showTitlte:YES];
        UILabel *flagTitleLabel = self.cqOverlayImageBanned.titleLable;
        flagTitleLabel.textColor = [UIColor whiteColor];
        flagTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        
    } else if (bannedSize == CQBannedSizeBig) {      // 大框：图标标记+文字说明
        [self cq_configUIWithBannedIconHeight:42 iconTitleSpacing:6 showTitlte:YES];
        UILabel *flagTitleLabel = self.cqOverlayImageBanned.titleLable;
        flagTitleLabel.textColor = [UIColor whiteColor];
        flagTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    } else if (bannedSize == CQBannedSizeNone) {    // 无框：
        if (self.cqOverlayImageBanned != nil) {
            [self.cqOverlayImageBanned removeFromSuperview];
            self.cqOverlayImageBanned = nil;
        }
    }
}

- (void)cq_configUIWithBannedIconHeight:(CGFloat)iconHeight iconTitleSpacing:(CGFloat)iconTitleSpacing showTitlte:(BOOL)showTitle
{
    if (self.cqOverlayImageBanned != nil) {
        [self.cqOverlayImageBanned removeFromSuperview];
        self.cqOverlayImageBanned = nil;
    }
    CQVerticalImageLabelView *verticalImageLabelView = [[CQVerticalImageLabelView alloc] initWithIconHeight:iconHeight iconTitleSpacing:iconTitleSpacing showTitlte:showTitle];
    verticalImageLabelView.backgroundColor = [[UIColor alloc] initWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.8]; // #111111
    [self addSubview:verticalImageLabelView];
    [verticalImageLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.cqOverlayImageBanned = verticalImageLabelView;
    
    verticalImageLabelView.alpha = 0;   // 图片所在视图的banned标记，默认不显示
    NSString *title = NSLocalizedString(@"该图片涉嫌违规", nil);
    UIImage *image = [UIImage cqImagekit_xcassetImageNamed:@"icon_banned"];
    verticalImageLabelView.imageView.image = image;
    verticalImageLabelView.titleLable.text = title;
}

#pragma mark - Update
/// 要显示什么标记，已经初始化的时候就设置cq_configUIWithBannedSize了，所以不用imageUseType
- (void)cq_updateImageStatus:(CQImageStatus)imageStatus {
    if (imageStatus == CQImageStatusBanned) {
        if (self.cqOverlayImageBanned) { // 有些视图不管banned与否，CQBannedSize都是None
            self.cqOverlayImageBanned.alpha = 1;    // 显示违规标记和文字
        }
        
    } else {
        self.cqOverlayImageBanned.alpha = 0;
    }
}

@end
