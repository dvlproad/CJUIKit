//
//  CJTextView.m
//  CJTextView
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextView.h"

@interface CJTextView ()

@property (nonatomic, weak) UITextView *placeholderView;    /**< 占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示 */
@property (nonatomic, assign) NSInteger textHeight;         /**< 文字高度 */
@property (nonatomic, assign) NSInteger maxTextHeight;      /**< 文字最大高度 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;  /**< 设置textView的最大行数 */

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) void(^cjTextHeightChangeBlock)(NSString *text,CGFloat textHeight);

@end



@implementation CJTextView

- (UITextView *)placeholderView
{
    if (_placeholderView == nil) {
        UITextView *placeholderView = [[UITextView alloc] init];
        _placeholderView = placeholderView;
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font = self.font;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

/** 完整的描述请参见文件头部 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines textHeightChangeBlock:(void (^)(NSString *, CGFloat))textHeightChangeBlock {
    _maxNumberOfLines = maxNumberOfLines;
    
    // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
    _maxTextHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
    
    _cjTextHeightChangeBlock = textHeightChangeBlock;
    
    [self textDidChange];
}


- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
}

- (void)textDidChange
{
    // 占位文字是否显示
    self.placeholderView.hidden = self.text.length > 0;
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textHeight != height) { // 高度不一样，就改变了高度
        
        // 最大高度，可以滚动
        self.scrollEnabled = height > _maxTextHeight && _maxTextHeight > 0;
        
        _textHeight = height;
        
        if (_cjTextHeightChangeBlock && self.scrollEnabled == NO) {
            _cjTextHeightChangeBlock(self.text, height);
            [self.superview layoutIfNeeded];
            self.placeholderView.frame = self.bounds;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
