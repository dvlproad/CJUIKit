////
////  CJFileChooseToolBar.m
////  FileChooseViewDemo
////
////  Created by ciyouzen on 2016/4/10.
////  Copyright © 2016年 dvlproad. All rights reserved.
////
//
//#import "CJFileChooseToolBar.h"
////#import "SDWebImageManager.h"
////#import "VoiceButtonManager.h"
//
//NSString * const HPResourceHaveNotUploadSuccess = @"有文件尚未上传，请先完成上传";
//
//@interface CJFileChooseToolBar()
//
//@property (strong,nonatomic) UIView                   * background;
//@property (strong,nonatomic) NSMutableArray           * items;
//@property (assign,nonatomic) HPToolBarInputViewType   inputViewType;
//@property (strong,nonatomic) HPToolBarSoundInputView  * soundInputView;
//@property (strong,nonatomic) HPToolBarImageInputView  * imageInputView;
//@property (strong,nonatomic) HPToolBarAttachInputView * attachInputView;
//@end
//
//
//
//@implementation CJFileChooseToolBar
//
//-(void)dealloc
//{
//    if (self.options & HPToolBarOptionsMic) {
////        [[VoiceButtonManager shareInstance] removeAllVoiceButtons];
//    }
//}
//
//- (void)commonInit
//{
//    _maxImageCount = 5;
//    _maxSoundCount = 3;
//    _maxAttachCount = 5;
//    self.toolBarColor = [UIColor redColor];
////    self.uploadType = HPUpLoadTypeNone;
//}
//
//#pragma mark - 图片
//-(void)setupOriginImageSource:(NSArray *)originImageSource
//{
//    NSAssert(self.options & HPToolBarOptionsImage, @"you have not set this option");
//    _originImageSource = originImageSource;
//    for (id urlString in originImageSource) {
//        if ([urlString isKindOfClass:[NSString class]]) {
////            NSURL * url = [NetworkClient urlForString:urlString];
////            if (![[HPFileManager shareManager]imageExistAtPath:url]) {
////                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////                }];
////            }
//        }
//    }
//    [self.imageInputView setupOriginImageSource:originImageSource];
//}
//
//-(void)setupOriginImageItems:(NSArray <HPToolBarImageInputViewItem *>*)originImageItems
//{
//    NSAssert(self.options & HPToolBarOptionsImage, @"you have not set this option");
//    _originImageItems = originImageItems;
//    
//    //下载为缓存的图片
//    for (HPToolBarImageInputViewItem * item in originImageItems) {
//        if (item.filePath.length > 0) {
////            NSURL * url = [NetworkClient urlForString:item.filePath];
////            if (![[HPFileManager shareManager]imageExistAtPath:url]) {
////                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////                }];
////            }
//        }
//    }
////    [self.imageInputView setupOriginImageItems:originImageItems];
//}
//
//- (NSArray<HPToolBarImageInputViewItem *>*)getCurrentImageItems
//{
//    NSArray * imageItems = [self.imageInputView getCurrentImageItems];
//    return imageItems;
//}
//
//- (BOOL)hasImageEdite
//{
//    return [self.imageInputView hasImageEdite];
//}
//
//#pragma mark - 语音
//-(void)setupOriginSoundSource:(NSArray *)originSoundSource
//{
//    NSAssert(self.options & HPToolBarOptionsMic, @"you have not set this option");
//    _originSoundSource = originSoundSource;
//    for (id urlString in originSoundSource)
//    {
////        if ([urlString isKindOfClass:[NSString class]]) {
////            NSURL * url = [NetworkClient urlForString:urlString];
////            if (![[HPFileManager shareManager] fileExistAtVoiceFolderWithFileName:url.lastPathComponent])
////            {
////                [NetworkClient sessionDownloadWithUrl:url.absoluteString success:NULL fail:NULL];
////            }
////        }
//    }
////    [self.soundInputView setupOriginSoundSource:originSoundSource];
//}
//
//- (void)setupOriginSoundItems:(NSArray <HPToolbarSoundInputViewItem *>*)originSoundItems
//{
//    NSAssert(self.options & HPToolBarOptionsMic, @"you have not set this option");
//    _originSoundItems = originSoundItems;
//    for (HPToolbarSoundInputViewItem *item in originSoundItems)
//    {
////        if ([item.filePath isKindOfClass:[NSString class]]) {
////            NSURL * url = [NetworkClient urlForString:item.filePath];
////            if (![[HPFileManager shareManager] fileExistAtVoiceFolderWithFileName:url.lastPathComponent])
////            {
////                [NetworkClient sessionDownloadWithUrl:url.absoluteString success:NULL fail:NULL];
////            }
////        }
//    }
////    [self.soundInputView setupOriginSoundItems:originSoundItems];
//}
//
////- (NSArray <HPToolbarSoundInputViewItem *>*)getCurrentSoundItems
////{
////    return [self.soundInputView getCurrentSoundItems];
////}
////
////- (BOOL)hasSoundEdite
////{
////    return [self.soundInputView hasSoundEdite];
////}
//
//#pragma mark - 附件
//-(void)setupOriginAttachItems:(NSMutableArray<HPToolBarAttachInputViewItem *>*)originAttachItems
//{
//    NSAssert(self.options & HPToolBarOptionsAttachment, @"you have not set this option");
//    _originAttachItems = originAttachItems;
//    for (HPToolBarAttachInputViewItem * item in originAttachItems)
//    {
////        if ([item.url isKindOfClass:[NSString class]]) {
////            NSURL * url = [NetworkClient urlForString:item.url];
////            if (![[HPFileManager shareManager] fileExistAtAttachFolderWithFileName:url.lastPathComponent])
////            {
////                [NetworkClient sessionDownloadWithUrl:url.absoluteString success:NULL fail:NULL];
////            }
////        }
//    }
////    [self.attachInputView setupOriginAttachItems:originAttachItems];
//}
//
////-(NSArray <HPToolBarAttachInputViewItem *>*)getCurrentAttachItems;
////{
////    return [self.attachInputView getCurrentAttachItems];
////}
////
////- (BOOL)hasAttachEdite
////{
////    return [self.attachInputView hasAttachEdite];
////}
//#pragma mark - public
//-(instancetype)initWithFrame:(CGRect)frame optoins:(HPToolBarOptions)options viewController:(UIViewController*)viewController
//{
//    if (self = [super initWithFrame:frame]) {
//        [self commonInit];
//        self.vc = viewController;
//        self.options |= options;
//        self.inputViewType = HPToolBarInputViewTypeNone;
//        self.items = [NSMutableArray array];
//        UIView * background = [UIView new];
//        background.backgroundColor = self.toolBarColor;
//        self.background = background;
//        [self cj_makeView:self addSubView:background withEdgeInsets:UIEdgeInsetsZero];
//        
//        if (options & HPToolBarOptionsAttachment) {
//            UIButton * photo = [self addItemWithNormalImage:@"homework_attach" selectedImage:@"homework_attach_selected" target:self action:@selector(itemDidTouchUpInside:)];
//            photo.tag = HPToolBarInputViewTypeAttach;
//        }
//        
//        if (options & HPToolBarOptionsMic) {
//            UIButton * mic = [self addItemWithNormalImage:@"homework_mic" selectedImage:@"homework_mic_selected" target:self action:@selector(itemDidTouchUpInside:)];
//            mic.tag = HPToolBarInputViewTypeMic;
//            
//        }
//        if (options & HPToolBarOptionsImage) {
//            UIButton * photo = [self addItemWithNormalImage:@"homework_image_icon" selectedImage:@"homework_image_selected_icon" target:self action:@selector(itemDidTouchUpInside:)];
//            photo.tag = HPToolBarInputViewTypePhoto;
//        }
//    }
//    return self;
//}
//
//- (NSString *)getAllCurrentSourceJsonString
//{
//    NSMutableArray * allSourceArray = [NSMutableArray array];
//    
//    if (self.options & HPToolBarOptionsImage) {
//        
//        NSArray * imageItems = [self getCurrentImageItems];
//        for (HPToolBarImageInputViewItem * imageItem in imageItems) {
////            if (imageItem.uploadEntity) {
////                [allSourceArray addObject:imageItem.uploadEntity];
////            }
//        }
//    }
//    if (self.options & HPToolBarOptionsMic) {
//        
//        NSArray * soundItems = [self getCurrentSoundItems];
////        for (HPToolbarSoundInputViewItem * soundItem in soundItems) {
////            if (soundItem.uploadEntity) {
////                [allSourceArray addObject:soundItem.uploadEntity];
////            }
////        }
//    }
//    
//    if (self.options & HPToolBarOptionsAttachment) {
//        
//        NSArray * attachItems = [self getCurrentAttachItems];
//        for (HPToolBarAttachInputViewItem * attachItem in attachItems) {
////            if (attachItem.uploadEntity && [attachItem.fileType integerValue] == 1) {
////                [allSourceArray addObject:attachItem.uploadEntity];
////            }
//        }
//    }
//    
////    NSString * json = [HPUploadFileEntity jsonArrayWithObjectArray:allSourceArray];
//    NSString *json = @"";
//    return json;
//}
//
//#pragma mark -
////-(void)updateConstraints
////{
////    [super updateConstraints];
////    CGSize size = CGSizeMake(23, 23);
////    CGFloat space = 10;
////    CGFloat right = space;
////    for (UIButton * item in self.items) {
////        [item mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.size.mas_equalTo(size);
////            make.centerY.mas_equalTo(self);
////            make.right.mas_equalTo(-right);
////        }];
////        right += (space + size.width);
////    }
////}
//
//- (UIButton *)addItemWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
//{
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    button.imageView.contentMode = UIViewContentModeCenter;
////    [button setImage:HPImageForKey(normalImage) forState:UIControlStateNormal];
////    [button setImage:HPImageForKey(selectedImage) forState:UIControlStateSelected];
//    [self.items addObject:button];
//    [self addSubview:button];
//    return button;
//}
//
//- (void)itemDidTouchUpInside:(UIButton *)item
//{
//    if (self.isFirstResponder && self.inputViewType == item.tag)
//    {
//        item.selected = NO;
//        self.inputViewType = HPToolBarInputViewTypeNone;
//        [self resignFirstResponder];
//    }
//    else
//    {
//        [self resignFirstResponder];
//        item.selected = YES;
//        [self becomeFirstResponderWithType:item.tag];
//    }
//}
//
//- (void)becomeFirstResponderWithType:(HPToolBarInputViewType)inputViewType
//{
//    self.inputViewType = inputViewType;
//    [self becomeFirstResponder];
//}
//-(BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//
//-(BOOL)canResignFirstResponder
//{
//    for (UIButton *button in self.items) {
//        button.selected = NO;
//    }
//    return YES;
//}
//- (void)reloadItemsStatus
//{
//    for (UIButton *button in self.items) {
//        button.selected = button.tag == self.inputViewType;
//    }
//}
//
//- (BOOL)hasAnyOptoinEdite
//{
//    BOOL hasImageEdit = NO;
//    BOOL hasSoundEdit = NO;
//    BOOL hasAttachEdit = NO;
//    if (self.options & HPToolBarOptionsImage) {
//        hasImageEdit = [self hasImageEdite];
//    }
//    if (self.options & HPToolBarOptionsMic) {
//        hasSoundEdit = [self hasSoundEdite];
//    }
//    if (self.options & HPToolBarOptionsAttachment) {
//        hasAttachEdit = [self hasAttachEdite];
//    }
//    return hasImageEdit || hasSoundEdit || hasAttachEdit;
//}
//#pragma mark - getter
//-(UIView *)inputView
//{
//    switch (self.inputViewType) {
//        case HPToolBarInputViewTypePhoto:{
//            return self.imageInputView;
//        }
//            break;
//        case HPToolBarInputViewTypeMic:{
//            return self.soundInputView;
//        }
//        case HPToolBarInputViewTypeAttach: {
//            return self.attachInputView;
//        }
//            break;
//        default:
//            return nil;
//            break;
//    }
//}
//
////-(UIView *)imageInputView
////{
////    if (_imageInputView == nil) {
////        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
////        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
////        CGFloat height = 170;
////        if (MainScreenHeight < 568) {
////            height = 170;
////        }else{
////            height = AdaptedHeightValue(170);
////        }
////        HPToolBarImageInputView * inputView = [[HPToolBarImageInputView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, height) collectionViewLayout:flowLayout];
////        _imageInputView = inputView;
////        [inputView setPickPhotoCompleteBlock:^{
////            [self becomeFirstResponderWithType:HPToolBarInputViewTypePhoto];
////            [self reloadItemsStatus];
////        }];
////        [inputView setBackAction:^{
////            [self becomeFirstResponderWithType:HPToolBarInputViewTypePhoto];
////            [self reloadItemsStatus];
////        }];
////    }
////    _imageInputView.uploadType = self.uploadType;
////    _imageInputView.maxImageCount = self.maxImageCount;
////    _imageInputView.viewController = self.vc;
////    return _imageInputView;
////}
////
////-(HPToolBarSoundInputView *)soundInputView
////{
////    if (_soundInputView == nil) {
////        HPToolBarSoundInputView * tableView = [[HPToolBarSoundInputView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 170) style:UITableViewStylePlain];
////        tableView.height = [tableView getHeight];
////        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////        _soundInputView = tableView;
////        tableView.scrollEnabled = NO;
////        tableView.bounces = NO;
////    }
////    _soundInputView.uploadType = self.uploadType;
////    _soundInputView.maxSoundCount = self.maxSoundCount;
////    return _soundInputView;
////}
////
////-(HPToolBarAttachInputView *)attachInputView
////{
////    if (_attachInputView == nil) {
////        CGFloat height = 170;
////        if (MainScreenHeight < 568) {
////            height = 170;
////        }else{
////            height = AdaptedHeightValue(170);
////        }
////        HPToolBarAttachInputView * attachInputView = [[HPToolBarAttachInputView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, height)];
////        WS(weakself);
////        [attachInputView setWillPopPreViewController:^{
////            [weakself reloadItemsStatus];
////        }];
////        _attachInputView = attachInputView;
////    }
////    _attachInputView.viewController = self.vc;
////    _attachInputView.maxAttachCount = self.maxAttachCount;
////    _attachInputView.handleAddActionBlock = self.handleAddAttachActionBlock;
////    return _attachInputView;
////}
//
//-(BOOL)showImageAddItem
//{
//    return self.imageInputView.showAddItem;
//}
//
//-(BOOL)showAttachAddItem
//{
//    return self.attachInputView.showAddItem;
//}
//
////- (BOOL)allResourcesUploaded {
////    if (self.options & HPToolBarOptionsImage) {
////        NSArray * imageItems = [self getCurrentImageItems];
////        for (HPToolBarImageInputViewItem * imageItem in imageItems) {
////            if (!imageItem.uploadEntity.uploaded) {
////                return NO;
////            }
////        }
////    }
////    if (self.options & HPToolBarOptionsMic) {
////        NSArray * soundItems = [self getCurrentSoundItems];
////        for (HPToolbarSoundInputViewItem * soundItem in soundItems) {
////            if (!soundItem.uploadEntity.uploaded) {
////                return NO;
////            }
////        }
////    }
////    return YES;
////}
//
//#pragma mark - setter
//-(void)setToolBarColor:(UIColor *)toolBarColor
//{
//    _toolBarColor = toolBarColor;
//    if (self.background) {
//        self.background.backgroundColor = toolBarColor;
//    }
//}
//
//-(void)setShowAttachAddItem:(BOOL)showAttachAddItem
//{
//    self.attachInputView.showAddItem = showAttachAddItem;
//}
//
//-(void)setShowImageAddItem:(BOOL)showImageAddItem
//{
//    self.imageInputView.showAddItem = showImageAddItem;
//}
//
//
//
//#pragma mark - addSubView
//- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
//    [superView addSubview:subView];
//    subView.translatesAutoresizingMaskIntoConstraints = NO;
//    //left
//    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeLeft
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:superView
//                                                          attribute:NSLayoutAttributeLeft
//                                                         multiplier:1
//                                                           constant:edgeInsets.left]];
//    //right
//    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeRight
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:superView
//                                                          attribute:NSLayoutAttributeRight
//                                                         multiplier:1
//                                                           constant:edgeInsets.right]];
//    //top
//    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeTop
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:superView
//                                                          attribute:NSLayoutAttributeTop
//                                                         multiplier:1
//                                                           constant:edgeInsets.top]];
//    //bottom
//    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeBottom
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:superView
//                                                          attribute:NSLayoutAttributeBottom
//                                                         multiplier:1
//                                                           constant:edgeInsets.bottom]];
//}
//
//
//@end
