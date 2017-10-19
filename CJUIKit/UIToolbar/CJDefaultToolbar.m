//
//  CJDefaultToolbar.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/3/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDefaultToolbar.h"

@interface CJDefaultToolbar ()

@property (nonatomic, strong) UIBarButtonItem *bbItem_value;

@end

@implementation CJDefaultToolbar

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
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
    self.backgroundColor = [UIColor whiteColor];
    self.option = CJDefaultToolbarOptionConfirm;
    
    UIImageView *seprateLineImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    seprateLineImageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:seprateLineImageView];
    seprateLineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:seprateLineImageView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:seprateLineImageView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:seprateLineImageView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:seprateLineImageView
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:1]];
}

- (void)setOption:(CJDefaultToolbarOption)option {
    _option = option;
    
    //知识点(iOS11):[iOS11 UIToolBar Contentview](https://stackoverflow.com/questions/46107640/ios11-uitoolbar-contentview)
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
    if (option & CJDefaultToolbarOptionCancel) {
        UIBarButtonItem *bbitem_cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
        [toolbarItems addObject:bbitem_cancel];
    } else {
        UIBarButtonItem *bbitem_fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        bbitem_fix.width = 40;
        [toolbarItems addObject:bbitem_fix];
    }
    
    UIBarButtonItem *bbitem_flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbarItems addObject:bbitem_flex];
    
    if (option & CJDefaultToolbarOptionValue) {
        UIBarButtonItem *bbItem_value = [[UIBarButtonItem alloc] initWithTitle:@"这是一个值的显示位置,其长度会自适应" style:UIBarButtonItemStylePlain target:self action:nil];
        [toolbarItems addObject:bbItem_value];
        
        self.bbItem_value = bbItem_value;
    } else {
        UIBarButtonItem *bbitem_fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        bbitem_fix.width = 40;
        [toolbarItems addObject:bbitem_fix];
        
        self.bbItem_value = nil;
    }
    
    //UIBarButtonItem *bbitem_flex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbarItems addObject:bbitem_flex];
    
    if (option & CJDefaultToolbarOptionConfirm) {
        UIBarButtonItem *bbitem_confirm = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAction:)];
        UIColor *color = [UIColor colorWithRed:43/255.0 green:76/255.0 blue:171/255.0 alpha:1];
        NSDictionary *attributes = @{NSForegroundColorAttributeName:color};
        [bbitem_confirm setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        [toolbarItems addObject:bbitem_confirm];
    } else {
        UIBarButtonItem *bbitem_fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        bbitem_fix.width = 40;
        [toolbarItems addObject:bbitem_fix];
    }
    
    [self setItems:toolbarItems];
}

- (void)confirmAction:(id)sender {
    if (self.confirmHandle) {
        self.confirmHandle();
    }
}

- (void)cancelAction:(id)sender {
    if (self.cancelHandle) {
        self.cancelHandle();
    }
}

/** 完整的描述请参见文件头部 */
- (void)updateShowingValue:(NSString *)value {
    self.bbItem_value.title = value;
}

@end
