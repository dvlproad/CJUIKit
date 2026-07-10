//
//  CQTSRipeButtonCollectionViewCell.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQTSRipeButtonCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "CQTSButtonFactory.h"

@interface CQTSRipeButtonCollectionViewCell () {
    
}
@property (nonatomic, strong) UIButton *textButton; /**< 文本按钮 */

@end

@implementation CQTSRipeButtonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
//        self.selected = NO;
    }
    return self;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    [self.contentView addSubview:self.textButton];
    [self.textButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(2);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(2);
        make.centerY.equalTo(self.contentView);
    }];
}


- (UIButton *)textButton {
    if (_textButton == nil) {
        UIButton *textButton = [CQTSButtonFactory submitButtonWithSubmitTitle:nil editTitle:nil showEditTitle:NO clickSubmitTitleHandle:nil clickEditTitleHandle:nil];
        [textButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        textButton.layer.cornerRadius = 10;
        textButton.userInteractionEnabled = NO; // 使得按钮位置的cell能够接收点击事件
        _textButton = textButton;
    }
    
    return _textButton;
}

#pragma mark - Setter
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.textButton.selected = selected;
}

- (void)setText:(NSString *)text {
    _text = text;
    [self.textButton setTitle:text forState:UIControlStateNormal];
    [self.textButton setTitle:text forState:UIControlStateSelected];
}


#pragma mark - Other Method
/*
 *  计算cell的宽度
 *
 *  @param tagString    cell上的文本
 *  @param cellHeight   cell的高度
 *  @param showEdit     计算时候是否要加上编辑按钮
 *
 *  @return cell的宽度
 */
+ (CGFloat)cellWidthText:(NSString *)tagString cellHeight:(CGFloat)cellHeight {
    CGFloat titleLabelMaxHeight = cellHeight - 2*2;
    CGSize titleLabelMaxSize = CGSizeMake(CGFLOAT_MAX, titleLabelMaxHeight);
    UIFont *font = [UIFont systemFontOfSize:14.0];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
   paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
   paragraphStyle.lineSpacing = 0;
    CGSize titleTextSize = [CQTSRipeButtonCollectionViewCell getTextSizeFromString:tagString withFont:font maxSize:titleLabelMaxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:paragraphStyle];
    CGFloat titleTextWidth = titleTextSize.width;
    titleTextWidth += 2*10;  // 为了让button的文字与边缘有一定的间距
    
    CGFloat cellWidth = titleTextWidth;
    
    return cellWidth;
}

#pragma mark - Other Method
+ (CGSize)getTextSizeFromString:(NSString *)string withFont:(UIFont *)font
                        maxSize:(CGSize)maxSize
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    if (string.length == 0) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        if (paragraphStyle == nil) {
            paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = lineBreakMode;
        }
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect textRect = [string boundingRectWithSize:maxSize
                                               options:options
                                            attributes:attributes
                                               context:nil];
        CGSize size = textRect.size;
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}



@end
