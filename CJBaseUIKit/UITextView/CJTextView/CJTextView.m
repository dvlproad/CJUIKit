//
//  CJTextView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextView.h"
#import "UITextInputHeightCJHelper.h"

@interface CJTextView () {
    
}
@property (nonatomic, assign) NSInteger currentTexViewHeight;   /**< 文本框的当前高度 */
@property (nonatomic, assign) NSInteger maxTextViewHeight;      /**< 文字框的最大显示高度 */

@property (nonatomic, copy, readonly) void(^didChangeHappenHandle)(UITextView *bTextView);
/**
 *  文字高度改变block → 文字高度改变且变化的范围在指定区间内则会调用这个代码块
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, copy, readonly) void(^didChangeCompleteBlock)(NSString *text, BOOL shouldUpdateHeight, CGFloat currentTextViewHeight);

@end



@implementation CJTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    
    [self addSubview:self.placeholderView];
    self.placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.placeholderView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    // textView是UIScrollView，所以需要宽两个属性来限制，如width、right(如过单纯只使用right无法限制placeholder textView的宽)
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.placeholderView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.placeholderView
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    
    _placeholderViewTopLayoutConstraint =
        [NSLayoutConstraint constraintWithItem:self.placeholderView
                                     attribute:NSLayoutAttributeTop    //top
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0];
    [self addConstraint:self.placeholderViewTopLayoutConstraint];
    
    
    // textView是UIScrollView，所以需要高两个属性来限制，如height、bottom(如过单纯只使用bottom无法限制placeholder textView的高)
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.placeholderView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:1
                                   constant:0]];
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.placeholderView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    
    //self.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.5];
    //self.placeholderView.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.5];
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


/*
 *  设置didChange触发时候的各个操作
 *
 *  @param didChangeHappenHandle        didChange触发开始的时候
 *  @param didChangeCompleteBlock       didChange操作结束的时候
 */
- (void)configDidChangeHappenHandle:(void(^ _Nullable)(UITextView *bTextView))didChangeHappenHandle
             didChangeCompleteBlock:(void(^ _Nonnull)(NSString *text, BOOL shouldUpdateHeight, CGFloat currentTextViewHeight))didChangeCompleteBlock
{
    _didChangeHappenHandle = didChangeHappenHandle;
    _didChangeCompleteBlock = didChangeCompleteBlock;
}

/* 完整的描述请参见文件头部 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    //计算文本框显示的最大高度 = (每行高度 * 总行数 + 文字上下间距)
    NSAssert(self.font != nil, @"此时未设置文字字体，会导致文本框最大高度计算问题，所以请先设置");
    _maxTextViewHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
    NSAssert(self.didChangeCompleteBlock != nil, @"请在此方法前设置didChangeCompleteBlock，否则此方法执行后如果高度有变化，会无法得到回调");
    [self textDidChange];
}

/* 完整的描述请参见文件头部 */
- (void)setMaxTextViewHeight:(NSInteger)maxTextViewHeight
{
    _maxTextViewHeight = maxTextViewHeight;
    
    NSAssert(self.didChangeCompleteBlock != nil, @"请在此方法前设置didChangeCompleteBlock，否则此方法执行后如果高度有变化，会无法得到回调");
    [self textDidChange];
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
    self.placeholderView.hidden = self.text.length > 0; //占位文字是否显示
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    self.placeholderView.hidden = self.text.length > 0; //占位文字是否显示
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    
    self.placeholderView.textAlignment = textAlignment;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placeholderView.font = font;
}


#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //[self updateTexViewHeightIfNeed];
}

#pragma mark - textDidChange(由UITextViewTextDidChangeNotification触发，或者手动触发)
- (void)textDidChange {
    // 执行开始事件
    if (self.didChangeHappenHandle) {
        self.didChangeHappenHandle(self);
    }
    
    [self updateTexViewHeightIfNeed];
}

- (void)updateTexViewHeightIfNeed {
    BOOL shouldUpdateTexViewHeight = [self __checkShouldUpdateTexViewHeightIfNeed];
    
    if (self.didChangeCompleteBlock) {
        self.didChangeCompleteBlock(self.text, shouldUpdateTexViewHeight, self.currentTexViewHeight);
    }
}

- (BOOL)__checkShouldUpdateTexViewHeightIfNeed {
    // 继续执行其他事件
    self.placeholderView.hidden = self.text.length > 0; //占位文字是否显示
    
    CGFloat maxWidth = self.bounds.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize size = [self sizeThatFits:maxSize];
    NSInteger currentTextViewHeight = ceilf(size.height);
    
    // 如果placeholder文本的高度大于正式文本的高度，则使用placeholder的高度
    CGFloat placeholderHeight = [UITextInputHeightCJHelper textHeightInTextViewForText:self.placeholder ithMaxWidth:maxWidth font:self.placeholderView.font];
    if (currentTextViewHeight < placeholderHeight) {
        currentTextViewHeight = placeholderHeight;
    }
    
    
    
    if (_originTextViewHeight == 0) {
        _originTextViewHeight = currentTextViewHeight;//使用文本的高度作为默认高度
    }
    
    BOOL oldTextViewHeight = self.currentTexViewHeight;
    if (oldTextViewHeight != currentTextViewHeight) { //高度不一样，就改变了高度
        BOOL shouldUpdateHeight = YES;
        if (oldTextViewHeight > self.maxTextViewHeight && currentTextViewHeight > self.maxTextViewHeight) {
            shouldUpdateHeight = NO;
        }
        
        if (shouldUpdateHeight) {
            CGFloat newTextViewHeight = MIN(currentTextViewHeight, self.maxTextViewHeight);
            _currentTexViewHeight = newTextViewHeight;
        }
        
        return shouldUpdateHeight;
    } else {
        return NO;
    }
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
