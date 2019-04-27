//
//  CJTextView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextView.h"

@interface CJTextView ()

@property (nonatomic, strong) UITextView *placeholderView;      /**< 占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示 */

@property (nonatomic, assign) NSInteger currentTexViewHeight;   /**< 文本框的当前高度 */
@property (nonatomic, assign) NSInteger maxTextViewHeight;      /**< 文字框的最大显示高度 */

/**
 *  文字高度改变block → 文字高度改变且变化的范围在指定区间内则会调用这个代码块
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, copy) void(^textViewHeightChangeBlock)(NSString *text, CGFloat currentTexViewHeight);

@end



@implementation CJTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [self cj_makeView:self addSubView:self.placeholderView withEdgeInsets:UIEdgeInsetsZero];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
      textHeightChangeBlock:(void(^)(NSString *text, CGFloat currentTextViewHeight))textViewHeightChangeBlock
{
    //计算文本框显示的最大高度 = (每行高度 * 总行数 + 文字上下间距)
    NSAssert(self.font != nil, @"此时未设置文字字体，会导致文本框最大高度计算问题，所以请先设置");
    _maxTextViewHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
    _textViewHeightChangeBlock = textViewHeightChangeBlock;
    
    [self textDidChange];
}

/* 完整的描述请参见文件头部 */
- (void)setMaxTextViewHeight:(NSUInteger)maxTextViewHeight
       textHeightChangeBlock:(void (^)(NSString *text, CGFloat currentTextViewHeight))textViewHeightChangeBlock
{
    _maxTextViewHeight = maxTextViewHeight;
    
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

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placeholderView.font = font;
}

- (void)textDidChange
{
    self.placeholderView.hidden = self.text.length > 0; //占位文字是否显示
    
    CGSize size = [self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    NSInteger currentTextViewHeight = ceilf(size.height);
    if (_originTextViewHeight == 0) {
        _originTextViewHeight = currentTextViewHeight;//使用文本的高度作为默认高度
    }
        
    if (self.currentTexViewHeight != currentTextViewHeight) { //高度不一样，就改变了高度
        self.currentTexViewHeight = currentTextViewHeight;
        
        if (currentTextViewHeight > self.maxTextViewHeight) {
            self.scrollEnabled = YES;//当前文本框的最大高度，已经大于文本框的最大显示高度，则应该允许滚动
        } else {
            self.scrollEnabled = NO;
        }
        
        if (currentTextViewHeight <= self.maxTextViewHeight) {
            if (self.textViewHeightChangeBlock) {
                self.textViewHeightChangeBlock(self.text, currentTextViewHeight);
            }
        }
    }
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











#pragma mark - 字符插入或者删除操作
/**
 *  插入系统表情字符
 *
 *  @param emotionString 要插入的系统表情字符
 */
- (void)insertEmotionString:(NSString *)emotionString {
    //NSLog(@"emotionString = %@", emotionString);
    if (emotionString.length == 0) {
        return;
    }
    
    NSInteger systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        UIFont *emotionFont = self.font;
        NSAttributedString *emotionAttributedString = [self getAttributedStringFromText:emotionString withTextFont:emotionFont];
        
        NSRange range = [self selectedRange];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attr insertAttributedString:emotionAttributedString atIndex:range.location];
        self.attributedText = attr;
        [self textDidChange]; //注意：如果是修改TextView的attributedText，不会自动调用textDidChange
        
    } else {
        NSString *chatText = self.text;
        
        self.text = @"";
        self.text = [NSString stringWithFormat:@"%@%@", chatText, emotionString];
    }
}


- (NSAttributedString *)getAttributedStringFromText:(NSString *)string withTextFont:(UIFont *)font {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 0.0;
    
    
    if (font == nil) {
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle};
        [attributedString addAttributes:attributes range:NSMakeRange(0, string.length)];
    } else {
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     };
        [attributedString addAttributes:attributes range:NSMakeRange(0, string.length)];
    }
    
    return attributedString;
}


/**
 *  删除倒数的几个字符(因为一个删除操作，有时候是删除一个字符，但有时候是删除最后一个表情)
 */
- (void)deleteCharactersLength:(NSInteger)shouldDeleteCharactersLength {
    if (shouldDeleteCharactersLength <= 0) {
        return;
    }
    
    NSInteger systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        self.attributedText = [self backspaceText:attr length:shouldDeleteCharactersLength];
        
        [self textDidChange]; //注意：如果是修改TextView的attributedText，不会自动调用textDidChange
        
    } else {
        NSString *chatText = self.text;
        self.text = [chatText substringToIndex:chatText.length-shouldDeleteCharactersLength];
    }
}

- (NSMutableAttributedString *)backspaceText:(NSMutableAttributedString *)attr length:(NSInteger)length
{
    NSRange range = [self selectedRange];
    if (range.location == 0) {
        return attr;
    }
    [attr deleteCharactersInRange:NSMakeRange(range.location - length, length)];
    return attr;
}

@end
