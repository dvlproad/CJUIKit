//
//  CQBaseAddDeleteContainerView.m
//  CQAddDeleteDemo
//
//  Created by ciyouzen on 2017/5/21.
//

#import "CQBaseAddDeleteContainerView.h"
#import <Masonry/Masonry.h>

@interface CQBaseAddDeleteContainerView () {
    
}
@property (nonatomic, strong) UIView *addContainerView;

// delete
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, copy, readonly) void(^deleteHandle)(void);

// add 和 browser (不一定要设置，很多时候我们不设置，而是靠的是 cell 的 didSelectItemAtIndexPath)
@property (nonatomic, copy, readonly) void(^addHandle)(void);
@property (nonatomic, copy, readonly) void(^browseHandle)(void);

@end



@implementation CQBaseAddDeleteContainerView

#pragma mark - Init

/*
 *  初始化
 *
 *  @param addIconImage                 加号icon（加号大小会取图片大小）
 *  @param addContainerViewBGColor      加号视图的背景色(此颜色和加号icon共同构成加号视图，圆角与contentContainerView一致)
 *  @param deleteIconImage              删除icon
 *  @param containerMarginToTopRight    container离视图顶部和右侧的间距
 *  @param contentContainerView         内容视图的容器（常为UIImage或者其他组合视图，如由一些视图组成的卡片视图）
 *
 *  @return 视图
 */
- (instancetype)initWithAddIconImage:(UIImage *)addIconImage
             addContainerViewBGColor:(UIColor *)addContainerViewBGColor
                     deleteIconImage:(UIImage *)deleteIconImage
           containerMarginToTopRight:(CGFloat)containerMarginToTopRight
                contentContainerView:(UIView *)contentContainerView
{
    // 加号
    UIView *addContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    addContainerView.backgroundColor = addContainerViewBGColor;
    
    UIImageView *addIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    addIconImageView.image = addIconImage;
    [addContainerView addSubview:addIconImageView];
    [addIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(addContainerView);
        make.size.mas_equalTo(addIconImage.size);
    }];
    
    return [self initWithAddContainerView:addContainerView deleteIconImage:deleteIconImage containerMarginToTopRight:containerMarginToTopRight contentContainerView:contentContainerView];
}


/*
 *  初始化
 *
 *  @param addContainerView             加号视图的容器(常见为直接是一个UIImageView，也可能是一个内部包含加号icon图片的自定义视图)
 *  @param deleteIconImage              删除icon
 *  @param containerMarginToTopRight    container离视图顶部和右侧的间距
 *  @param contentContainerView         内容视图的容器（常为UIImage或者其他组合视图，如由一些视图组成的卡片视图）
 *
 *  @return 视图
 */
- (instancetype)initWithAddContainerView:(UIView *)addContainerView
                         deleteIconImage:(UIImage *)deleteIconImage
               containerMarginToTopRight:(CGFloat)containerMarginToTopRight
                    contentContainerView:(UIView *)contentContainerView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViewsWithAddContainerView:addContainerView
                             deleteIconImage:deleteIconImage
                   containerMarginToTopRight:containerMarginToTopRight
                        contentContainerView:contentContainerView];
        
        _containerMarginToTopRight = containerMarginToTopRight;
        
        // 设置addContainerView圆角与contentContainerView一致
        self.addContainerView.layer.masksToBounds = self.contentContainerView.layer.masksToBounds;
        self.addContainerView.layer.cornerRadius = self.contentContainerView.layer.cornerRadius;
        
        // 数据
        [self showContentUIWithIsAddButton:NO];
    }
    return self;
}
 

- (void)setupViewsWithAddContainerView:(UIView *)addContainerView
                       deleteIconImage:(UIImage *)deleteIconImage
             containerMarginToTopRight:(CGFloat)containerMarginToTopRight
                  contentContainerView:(UIView *)contentContainerView
{
    // 加号添加视图
    [self addSubview:addContainerView];
    [addContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(-containerMarginToTopRight);
        make.top.mas_equalTo(self).mas_offset(containerMarginToTopRight);
        make.bottom.mas_equalTo(self).mas_offset(-0);
    }];
    _addContainerView = addContainerView;
    UITapGestureRecognizer *addTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__addAction)];
    [addContainerView addGestureRecognizer:addTapGR];
    
    
    
    // 有内容时候的视图
    [self addSubview:contentContainerView];
    [contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(addContainerView);   // 和 addContainerView 等大
    }];
    _contentContainerView = contentContainerView;
    
    // 删除号
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton addTarget:self action:@selector(__deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setBackgroundImage:deleteIconImage forState:UIControlStateNormal];
    [self addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-0);
        make.top.mas_equalTo(self).mas_offset(0);
        make.size.mas_equalTo(deleteIconImage.size);
    }];
    self.deleteButton = deleteButton;
}


#pragma mark - Config
/*
 *  设置 delete 的执行事件
 *
 *  @param deleteHandle     点击“减号”进行删除
 */
- (void)configDeleteHandle:(void(^)(void))deleteHandle
{
    _deleteHandle = deleteHandle;
}

/*
 *  设置 add 和 browser 的执行事件(不一定要设置，很多时候我们不设置，而是靠的是 cell 的 didSelectItemAtIndexPath)
 *
 *  @param addHandle        点击“加号”进行添加
 *  @param browseHandle     点击"内容"进行查看(可以为nil,为ni的时候不会添加browseTapGR，防止无脑添加盖住了某些视图本身的tap操作)
 */
- (void)configAddHandle:(void(^)(void))addHandle
           browseHandle:(void(^ _Nullable)(void))browseHandle
{
    _addHandle = addHandle;
    _browseHandle = browseHandle;
    
    if (browseHandle != nil) {
        UITapGestureRecognizer *browseTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__browseAction)];
        [self.contentContainerView addGestureRecognizer:browseTapGR];
    }
}

#pragma mark - UI
/*
 *  显示内容视图
 *
 *  @param isAddButton  是否是添加按钮(是添加按钮的话，则要隐藏删除按钮;不是的话，显示删除按钮，用于有些视图要浏览的时候才能删除)
 */
- (void)showContentUIWithIsAddButton:(BOOL)isAddButton {
    self.addContainerView.hidden = !isAddButton;
    self.deleteButton.hidden = isAddButton;
    self.contentContainerView.hidden = isAddButton;
}



#pragma mark - Private Method
/// 点击“加号”进行添加
- (void)__addAction {
    !self.addHandle ?: self.addHandle();
}

/// 点击“减号”进行删除
- (void)__deleteAction {
    !self.deleteHandle ?: self.deleteHandle();
}

/// 点击“内容”进行查看
- (void)__browseAction {
    NSLog(@"外部设置了 browseHandle ，导致整个视图了添加自定义 UITapGestureRecognizer，并触发了");
    !self.browseHandle ?: self.browseHandle();
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
