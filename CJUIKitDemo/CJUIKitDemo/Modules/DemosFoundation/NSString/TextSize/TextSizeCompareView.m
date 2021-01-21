//
//  TextSizeCompareView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextSizeCompareView.h"
#import <CJFoundation/NSString+CJTextSizeInView.h>

@interface TextSizeCompareView () {
    
}

@end


@implementation TextSizeCompareView

- (instancetype)initWithWithText:(NSString *)text
                            font:(UIFont *)font
                        viewWidth:(CGFloat)viewWidth
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViewsWithText:text font:font viewWidth:viewWidth];
    }
    return self;
}

- (void)setupViewsWithText:(NSString *)text
                      font:(UIFont *)font
                 viewWidth:(CGFloat)viewWidth
{
    UIView *container = self;
    container.backgroundColor = CJColorRandom;
    
    // 1、文本在label中的所占高度
    CGFloat lefMargin = 10;
    UILabel *textSizeInLabelLabel = [[UILabel alloc] init];
    textSizeInLabelLabel.backgroundColor = [UIColor greenColor];
    [container addSubview:textSizeInLabelLabel];
    [textSizeInLabelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container).mas_offset(lefMargin);
        make.centerX.mas_equalTo(container);
        make.top.mas_equalTo(container).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [container addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textSizeInLabelLabel);
        make.centerX.mas_equalTo(textSizeInLabelLabel);
        make.top.mas_equalTo(textSizeInLabelLabel.mas_bottom).mas_offset(2);
        make.height.mas_equalTo(40);
    }];


    // 2、文本在textView中的所占高度
    UILabel *textHeightInTextViewLabel = [[UILabel alloc] init];
    textHeightInTextViewLabel.backgroundColor = [UIColor greenColor];
    [container addSubview:textHeightInTextViewLabel];
    [textHeightInTextViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(label);
        make.centerX.mas_equalTo(label);
        make.height.mas_equalTo(textSizeInLabelLabel);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor redColor];
    textView.text = text;
    textView.font = font;
    [container addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textHeightInTextViewLabel.mas_bottom).mas_offset(2);
        make.left.mas_equalTo(label);
        make.centerX.mas_equalTo(label);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(container).mas_offset(-10); // 为了能够自适应高度
    }];
    
//    NSDictionary *textViewAttributes = [NSString __textViewAttributesWithFont:font];
//    textView.attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:textViewAttributes];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        CGFloat maxWidth = viewWidth-2*lefMargin;
        CGFloat maxWidth1 = label.bounds.size.width;
                
        CGFloat labelHeight = [text cjTextHeightInLabelWithMaxWidth:maxWidth font:font];
        CGFloat textViewHeight = [text cjTextHeightInTextViewWithMaxWidth:maxWidth font:font];
        NSLog(@"1文本在label中的所占高度%.2f", labelHeight);
        NSLog(@"2文本在textView中的所占高度%.2f", textViewHeight);
        textSizeInLabelLabel.text = [NSString stringWithFormat:@"%.2f", labelHeight];
        textHeightInTextViewLabel.text = [NSString stringWithFormat:@"%.2f", textViewHeight];
        
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(labelHeight);
        }];
        [textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textViewHeight);
        }];
    });
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
