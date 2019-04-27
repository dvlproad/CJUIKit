//
//  CJPopoverListView.m
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJPopoverListView.h"

static const NSInteger kArrowHeight = 10.f;
static const NSInteger kCellRowHeight = 44.f;

#define KPOPOVERView_SPACE      2.f
#define KPOPOVERView_TITLE_FONT [UIFont systemFontOfSize:16]
#define KPOPOVERView_BG_COLOR   [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f]

@interface CJPopoverListView () <UITableViewDataSource, UITableViewDelegate> {
    BOOL isArrowDown;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;

@end





@implementation CJPopoverListView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderColor = [UIColor colorWithRed:200/255.0f green:199/255.0f blue:204/255.0f alpha:1.0f];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.titleArray = titles;
        self.imageArray = images;
        
        self.frame = [self getViewFrame];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    
    frame.size.height = [self.titleArray count] * kCellRowHeight + KPOPOVERView_SPACE + kArrowHeight;
    
    for (NSString *title in self.titleArray) {
        NSDictionary *attributes = @{NSFontAttributeName:KPOPOVERView_TITLE_FONT};
        NSAttributedString *attributedText =
        [[NSAttributedString alloc] initWithString:title attributes:attributes];
        
        CGRect rect =
        [attributedText boundingRectWithSize:(CGSize){300, 100}
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                     context:nil];
        CGFloat width = rect.size.width;
        
        frame.size.width = MAX(width, frame.size.width);
    }
    
    if ([self.titleArray count] == [self.imageArray count]) {
        frame.size.width = 5 + 34 + 5 + frame.size.width + 10;
    }else{
        frame.size.width = 5 + frame.size.width + 10;
    }
    
    frame.origin.x = self.showPoint.x - frame.size.width/2;
    frame.origin.y = self.showPoint.y;
    
    //左间隔最小5x
    if (frame.origin.x < 5) {
        frame.origin.x = 5;
    }
    //右间隔最小5x
    if ((frame.origin.x + frame.size.width) > 315) {
        frame.origin.x = 315 - frame.size.width;
    }
    
    //add by lichq TODO如果弹出框超出页面部分，则改为向上弹出
    if (self.showPoint.y + frame.size.height > [[UIScreen mainScreen] bounds].size.height) {
        frame.origin.y = self.showPoint.y - frame.size.height;
        isArrowDown = YES;
    }else{
        
    }
    
    return frame;
}


-(void)showPopoverView
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismissPopoverView:) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    
    self.frame = [self getViewFrame];// NSLog(@"%@", NSStringFromCGRect(self.frame));
    //add by lichq TODO如果弹出框超出页面部分，则改为向上弹出
    if (self.showPoint.y + self.frame.size.height > [[UIScreen mainScreen] bounds].size.height) {
        self.showPoint = CGPointMake(self.showPoint.x, self.showPoint.y-30);//减去btn的高度
        CGRect frame = self.frame;
        frame.origin.y = self.showPoint.y - frame.size.height;
        self.frame = frame;
    }
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}


-(void)dismissPopoverView:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        weakSelf.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf.handerView removeFromSuperview];
    }];
    
}


#pragma mark - UITableView

-(UITableView *)tableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGRect rect = self.frame;
    rect.origin.x = KPOPOVERView_SPACE;
    if (isArrowDown == NO) {
        rect.origin.y = kArrowHeight + KPOPOVERView_SPACE;
    }else{
        rect.origin.y = KPOPOVERView_SPACE;
    }
    
    rect.size.width -= KPOPOVERView_SPACE * 2;
    rect.size.height -= (KPOPOVERView_SPACE - kArrowHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    //_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    
    return _tableView;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.frame = CGRectMake(0, 0, cell.frame.size.width, kCellRowHeight);//额外增加
        
        if ([_imageArray count] == 0) {
            CGRect labFrame = CGRectMake(5, 0, cell.frame.size.width-5, cell.frame.size.height);
            UILabel *lab = [[UILabel alloc]initWithFrame:labFrame];
            lab.text = [_titleArray objectAtIndex:indexPath.row];
            lab.font = KPOPOVERView_TITLE_FONT;
            [cell.contentView addSubview:lab];
        }else{
            CGRect imageFrame = CGRectMake(5, 5, 34, 34);
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:imageFrame];
            imageV.image = [_imageArray objectAtIndex:indexPath.row];
            [cell.contentView addSubview:imageV];
            
            CGRect labFrame = CGRectMake(45, 0, cell.frame.size.width-50, cell.frame.size.height);
            UILabel *lab = [[UILabel alloc]initWithFrame:labFrame];
            lab.text = [_titleArray objectAtIndex:indexPath.row];
            lab.font = KPOPOVERView_TITLE_FONT;
            [cell.contentView addSubview:lab];
        }
    }
    
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = KPOPOVERView_BG_COLOR;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismissPopoverView:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellRowHeight;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CJArrowDirection arrowDirection = CJArrowDirectionUp;
    if (isArrowDown) {
        arrowDirection = CJArrowDirectionDown;
    }
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    
    CGFloat arrowHeight = kArrowHeight;
    CGFloat arrowCurvature = 6.0f;
    UIColor *arrowBorderColor = self.borderColor;
    UIColor *arrowFillColor = KPOPOVERView_BG_COLOR;
    
    [CJDrawRectUtil drawArrowInRect:rect
                 withArrowDirection:arrowDirection
                         arrowPoint:arrowPoint
                        arrowHeight:arrowHeight
                     arrowCurvature:arrowCurvature
                   arrowBorderColor:arrowBorderColor
                     arrowFillColor:arrowFillColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
