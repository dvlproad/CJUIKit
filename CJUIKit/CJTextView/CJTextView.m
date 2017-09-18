//
//  CJTextView.m
//  CJTextView
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextView.h"

@interface CJTextView ()

@property (nonatomic, strong) UITextView *placeholderView;      /**< 占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示 */

@property (nonatomic, assign) NSInteger currentTexViewHeight;   /**< 文本框的当前高度 */
@property (nonatomic, assign) NSInteger maxTextViewHeight;      /**< 文字框的最大显示高度 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;      /**< 设置textView的最大行数 */

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) void(^textViewHeightChangeBlock)(NSString *text,CGFloat currentTexViewHeight);

@end



@implementation CJTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    [self cj_makeView:self addSubView:self.placeholderView withEdgeInsets:UIEdgeInsetsZero];
}


- (UITextView *)placeholderView {
    if (_placeholderView == nil) {
        _placeholderView = [[UITextView alloc] init];
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font = self.font;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
    }
    return _placeholderView;
}

/* 完整的描述请参见文件头部 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines textHeightChangeBlock:(void (^)(NSString *, CGFloat))textViewHeightChangeBlock {
    _maxNumberOfLines = maxNumberOfLines;
    
    //计算文本框显示的最大高度 = (每行高度 * 总行数 + 文字上下间距)
    NSAssert(self.font != nil, @"此时未设置文字字体，会导致文本框最大高度计算问题，所以请先设置");
    _maxTextViewHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
    
    _textViewHeightChangeBlock = textViewHeightChangeBlock;
    
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
    self.placeholderView.hidden = self.text.length > 0; //占位文字是否显示
    
    NSInteger currentTextViewHeight = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    if (_originTextViewHeight == 0) {
        _originTextViewHeight = currentTextViewHeight;
    }
    
    if (self.currentTexViewHeight != currentTextViewHeight) { //高度不一样，就改变了高度
        self.currentTexViewHeight = currentTextViewHeight;
        
        if (currentTextViewHeight > self.maxTextViewHeight) { //当前文本框的最大高度，已经大于文本框的最大显示高度，则应该允许滚动
            self.scrollEnabled = YES;
            
        } else {
            self.scrollEnabled = NO;
            
            if (self.textViewHeightChangeBlock) {
                self.textViewHeightChangeBlock(self.text, currentTextViewHeight);
                [self.superview layoutIfNeeded];
            }
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}

@end
