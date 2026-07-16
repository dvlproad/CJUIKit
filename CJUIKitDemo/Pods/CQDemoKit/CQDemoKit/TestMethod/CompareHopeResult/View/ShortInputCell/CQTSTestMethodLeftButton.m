//
//  CQTSTestMethodLeftButton.m
//  CQDemoKit
//

#import "CQTSTestMethodLeftButton.h"
#import <Masonry/Masonry.h>

@interface CQTSTestMethodLeftButton ()
@property (nonatomic, strong) UILabel *rotatedLabel;
@property (nonatomic, strong) UIStackView *verticalStack;
@property (nonatomic, strong) NSArray<UILabel *> *charLabels;
@end

@implementation CQTSTestMethodLeftButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRed:0.35 green:0.70 blue:0.45 alpha:1.0];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;

    UILabel *rotatedLabel = [[UILabel alloc] init];
    rotatedLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    rotatedLabel.textColor = [UIColor whiteColor];
    rotatedLabel.textAlignment = NSTextAlignmentCenter;
    rotatedLabel.numberOfLines = 1;
    rotatedLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self addSubview:rotatedLabel];
    self.rotatedLabel = rotatedLabel;

    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.distribution = UIStackViewDistributionEqualSpacing;
    stack.spacing = 0;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    stack.hidden = YES;
    [self addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [stack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
    ]];
    self.verticalStack = stack;

    _verticalStyle = CJVerticalTextButtonStyleRotated;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);

    if (self.verticalStyle == CJVerticalTextButtonStyleRotated) {
        self.rotatedLabel.hidden = NO;
        self.verticalStack.hidden = YES;

        self.rotatedLabel.bounds = CGRectMake(0, 0, h, w);
        self.rotatedLabel.center = CGPointMake(w / 2.0, h / 2.0);
    } else {
        self.rotatedLabel.hidden = YES;
        self.verticalStack.hidden = NO;
    }
}

- (void)setVerticalStyle:(CJVerticalTextButtonStyle)verticalStyle {
    _verticalStyle = verticalStyle;
    [self setNeedsLayout];
}

#pragma mark - Config
- (void)configTitle:(NSString *)verticalTitle {
    self.rotatedLabel.text = verticalTitle;

    for (UILabel *oldLabel in self.charLabels) {
        [oldLabel removeFromSuperview];
    }

    NSMutableArray<UILabel *> *labels = [NSMutableArray arrayWithCapacity:verticalTitle.length];
    UIFont *font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];

    for (NSUInteger i = 0; i < verticalTitle.length; i++) {
        unichar c = [verticalTitle characterAtIndex:i];
        NSString *charStr = [NSString stringWithCharacters:&c length:1];

        UILabel *label = [[UILabel alloc] init];
        label.font = font;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = charStr;
        [labels addObject:label];

        [self.verticalStack addArrangedSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(18);
        }];
    }
    self.charLabels = labels;
}

@end
