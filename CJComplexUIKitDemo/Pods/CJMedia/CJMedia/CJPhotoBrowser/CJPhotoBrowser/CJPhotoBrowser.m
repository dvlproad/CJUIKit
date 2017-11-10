//
//  CJPhotoBrowser.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CJPhotoBrowser.h"

#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>

#import "CJPhotoView.h"


#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface CJPhotoBrowser () <MJPhotoViewDelegate>
{
    // 滚动的view
	UIScrollView *_photoScrollView;
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;
    
    
    // 一开始的状态栏
    BOOL _statusBarHiddenInited;
}

@property (nonatomic, strong) CJPhotoToolbar *toolbar;
@property (nonatomic, strong) CJBottomToolbar *bottomToolbar;
@property (nonatomic, strong) CJDeleteToolbar *deleteToolbar;

@end

@implementation CJPhotoBrowser

#pragma mark - Lifecycle

- (void)dealloc
{
    _callback = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backACT" object:nil];
    }

- (void)loadView
{
    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.view = [[UIView alloc] init];
    self.view.frame = [UIScreen mainScreen].bounds;
	self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backACT:) name:@"backACT" object:nil];
       
    // 1.创建UIScrollView
    [self createScrollView];
    
    // 2.创建工具条
    
    if (self.isDelete) {
        [self creatDeteleToolbar];
    }else
    {
    [self createBottomToolbar];
    [self createToolbar];
    
   
    }
}

- (void)show
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];

    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
}

#pragma mark - 私有方法
#pragma mark 创建工具条
- (void)createBottomToolbar
{
    CGFloat barHeight = 44;
    CGFloat barY = self.view.frame.size.height - barHeight;
    if (_bottomToolbar == nil) {
        _bottomToolbar = [[CJBottomToolbar alloc] init];
    }
    _bottomToolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    _bottomToolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    __weak typeof(self)weakSelf = self;
    _bottomToolbar.sentCallBack = ^(BOOL sent)
    {
        if (sent) {
            if (weakSelf.psentCallBack) {
                weakSelf.psentCallBack(YES);
            }
           [weakSelf photoViewDidEndZoom:nil];
            
        }
    };
    _bottomToolbar.sendNum = [NSNumber numberWithInteger:_selectedNum];
    [self.view addSubview:_bottomToolbar];

}


-(void)creatDeteleToolbar
{
    __weak typeof(self)weakSelf = self;
    CGFloat barHeight = 64;
    _deleteToolbar = [[CJDeleteToolbar alloc] init];
    _deleteToolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, barHeight);
    _deleteToolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _deleteToolbar.photos = _photos;
    _deleteToolbar.selectedNum = _selectedNum;
    _deleteToolbar.maxCount = _maxCount;
    _deleteToolbar.callback = ^(NSNumber *currentNum)
    {
        if (weakSelf.currentNumCallback) {
            weakSelf.currentNumCallback(currentNum);
        }
    };
    _deleteToolbar.backAction = self.backAction;
    [self.view addSubview:_deleteToolbar];
    
    [self updateTollbarState];

}


-(void)backACT:(NSNotification *)notic
{
    if (self.backAction) {
        self.backAction();
    }
     [self photoViewDidEndZoom:nil]; 
}

-(void)backACT
{
    if (self.backAction) {
        self.backAction();
    }
    [self photoViewDidEndZoom:nil];
 
}


- (void)createToolbar
{
    __weak typeof(self)weakSelf = self;
    CGFloat barHeight = 64;
    if (_toolbar == nil) {
          _toolbar = [[CJPhotoToolbar alloc] init];
    }
  
    _toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, barHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolbar.photos = _photos;
    _toolbar.callback = ^(BOOL needRefresh)
    {
        weakSelf.callback(needRefresh);
    };
    _toolbar.selectedNum = _selectedNum;
    _toolbar.maxCount = _maxCount;
    _toolbar.selectNumCallBack = ^(NSInteger selectNum)
    {
        weakSelf.bottomToolbar.numStr = [NSString stringWithFormat:@"%zd",selectNum];
    };
    [self.view addSubview:_toolbar];
    
    [self updateTollbarState];
}

#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
	_photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
	_photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_photoScrollView.pagingEnabled = YES;
	_photoScrollView.delegate = self;
	_photoScrollView.showsHorizontalScrollIndicator = NO;
	_photoScrollView.showsVerticalScrollIndicator = NO;
	_photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
	[self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
   
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (photos.count > 1) {
        _visiblePhotoViews = [NSMutableSet set];
        _reusablePhotoViews = [NSMutableSet set];
    }
    
    for (int i = 0; i<_photos.count; i++) {
        CJPhotoModel *photo = _photos[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
}

-(void)deleteP:(NSInteger)index andPhotos:(NSArray *)photos
{
    if (photos.count > 0) {
        self.currentPhotoIndex = index<photos.count-1?index:photos.count-1;
        self.photos = photos;
        [_photoScrollView removeFromSuperview];
        [_toolbar removeFromSuperview];
        [_deleteToolbar removeFromSuperview];
        [_bottomToolbar removeFromSuperview];
        [self createScrollView];
        if (self.isDelete) {
            [self creatDeteleToolbar];
        }else{
            [self createBottomToolbar];
            [self createToolbar];
        }
        [self showPhotos];
        _deleteToolbar.photos = photos;
    }
    
}

#pragma mark 设置选中的图片
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    for (int i = 0; i<_photos.count; i++) {
        CJPhotoModel *photo = _photos[i];
        photo.firstShow = i == currentPhotoIndex;
    }
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - CJPhotoView代理
- (void)photoViewSingleTap:(CJPhotoView *)photoView
{
    [UIApplication sharedApplication].statusBarHidden = _statusBarHiddenInited;
    self.view.backgroundColor = [UIColor clearColor];
    
    // 移除工具条
    [_toolbar removeFromSuperview];
}

- (void)photoViewDidEndZoom:(CJPhotoView *)photoView
{
    if (_callback) {
        _callback(NO);
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];

}

- (void)photoViewImageFinishLoad:(CJPhotoView *)photoView
{
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
    _deleteToolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark 显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
	NSInteger firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	NSInteger lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = _photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = _photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (CJPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:index];
		}
	}
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(NSUInteger)index
{
    CJPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[CJPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    CJPhotoModel *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(NSUInteger)index
{
    if (index > 0) {
        CJPhotoModel *photo = _photos[index - 1];
        [self downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        CJPhotoModel *photo = _photos[index + 1];
        [self downloadWithURL:photo.url];
    }
}

- (void)downloadWithURL:(NSURL *)url {
    // cmp不能为空
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
    }];
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (CJPhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
           return YES;
        }
    }
	return  NO;
}

#pragma mark 循环利用某个view
- (CJPhotoView *)dequeueReusablePhotoView
{
    CJPhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
    _deleteToolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateTollbarState];
}
@end
