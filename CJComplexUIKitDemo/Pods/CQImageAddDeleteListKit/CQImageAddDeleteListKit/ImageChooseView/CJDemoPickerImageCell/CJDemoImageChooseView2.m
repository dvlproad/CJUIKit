//
//  CJDemoImageChooseView2.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/2.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoImageChooseView2.h"
#import "UIImage+CJBundleImage.h"
#import "CJDemoImageResultModel.h"

@interface CJDemoImageChooseView2 () {
    
}
@property (nonatomic, assign, readonly) BOOL containTitle;  /**< 是否包含title */

@property (nonatomic, strong) UIButton *photoImageButton;   /**< 图片选择与展示按钮 */

@property (nonatomic, strong) UIView *resultView;           /**< 识别结果视图 */
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UIImageView *resultImageView;

@property (nonatomic, strong) UIButton *deleteButton;     /**< 删除按钮(删除后才能重新选择新图片) */
@property (nonatomic, assign, readonly) BOOL isEmptyImage;  /**< 是否还未选中任何图片 */
@property (nonatomic, strong) UIImage *defaultPhotoImage;   /**< 图片选择按钮默认的图片 */

@property (nonatomic, copy) void(^imageChooseHandle)(void);
@property (nonatomic, copy) void(^imageDeleteHandle)(CJDemoImageChooseView2 *imageChooseView);

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;   /**< 加载网络图片时候的进度显示器 */

@end



@implementation CJDemoImageChooseView2


- (instancetype)initWithDefaultPhotoImage:(UIImage *)defaultPhotoImage
                             containTitle:(BOOL)containTitle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _defaultPhotoImage = defaultPhotoImage;
        _isEmptyImage = YES;
        _containTitle = containTitle;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    //高170
    //self.backgroundColor = [UIColor orangeColor];
    self.clipsToBounds = YES;
    
    if (self.containTitle) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self).mas_offset(20);
            make.height.mas_equalTo(17);
        }];
        self.titleLabel = titleLabel;
    }
    
    [self addSubview:self.photoImageButton];
    [self.photoImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(-10);
        if (self.containTitle) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(13);
        } else {
            make.top.mas_equalTo(self).mas_offset(0);
        }
        
        make.height.mas_equalTo(98);
    }];
    
    
    //resultView(覆盖在photoImageButton上,包含 resultLabel 和 resultImageView)
    UIView *resultView = [[UIView alloc] initWithFrame:CGRectZero];
    resultView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.76];
    [self addSubview:resultView];
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.photoImageButton);
        make.bottom.mas_equalTo(self.photoImageButton.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    self.resultView = resultView;
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.text = NSLocalizedString(@"识别成功", nil);
    resultLabel.textColor = [UIColor whiteColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:17];
    resultLabel.minimumScaleFactor = 0.5;
    resultLabel.adjustsFontSizeToFitWidth = YES;
    [resultView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(resultView).mas_offset(20);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(resultView);
        make.height.mas_equalTo(30);
    }];
    self.resultLabel = resultLabel;
    
    UIImageView *resultImageView = [[UIImageView alloc] init];
    [resultImageView setImage:[UIImage commonPickerImageNamed:@"two_photo_ok"]];
    [resultView addSubview:resultImageView];
    [resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(resultLabel.mas_left).mas_offset(-10);
        make.width.mas_equalTo(20);
        make.centerY.mas_equalTo(resultView);
        make.height.mas_equalTo(20);
    }];
    self.resultImageView = resultImageView;
    
    //deleteButton
    [self addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImageButton.mas_bottom).mas_offset(-10);
        make.left.mas_equalTo(self.photoImageButton.mas_right).mas_offset(-10);
        make.width.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.activityIndicator];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.photoImageButton);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    resultView.hidden = YES;
}

#pragma mark - Setter
- (void)setAllowPickImage:(BOOL)allowPickImage {
    _allowPickImage = allowPickImage;
    
    BOOL shouldShowDelete = allowPickImage && !self.isEmptyImage;
    self.deleteButton.hidden = !shouldShowDelete;
}

- (void)setupImageChooseHandle:(void(^)(void))imageChooseHandle
             imageDeleteHandle:(void(^)(CJDemoImageChooseView2 *imageChooseView))imageDeleteHandle {
    self.imageChooseHandle = imageChooseHandle;
    self.imageDeleteHandle = imageDeleteHandle;
}

/// 使用本地照片更新并显示识别结果
- (void)updatePhotoWithLocalImage:(UIImage *)photoImage
             recognizeResultModel:(nullable CJDemoImageResultModel *)recognizeResultModel
{
    [self __updatePhotoWithImage:photoImage recognizeResultModel:recognizeResultModel];
}

/// 使用网络照片更新并显示识别结果
- (void)updatePhotoWithNetworkImageUrl:(NSString *)photoImageUrl
                  recognizeResultModel:(nullable CJDemoImageResultModel *)recognizeResultModel
                             completed:(void(^ _Nullable)(UIImage *image))completedBlock
{
    UIImage *placeHoderImage = [UIImage commonPickerImageNamed:@"imageLook"];
    [self.photoImageButton setImage:placeHoderImage forState:UIControlStateNormal];
    
    [self __showActivityIndicator:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:photoImageUrl];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self __showActivityIndicator:NO];
            [self __updatePhotoWithImage:image recognizeResultModel:recognizeResultModel];
            
            !completedBlock ?: completedBlock(image);
        });
    });
}

/// 准备开始更新显示网络图片
- (void)beginUpdateNetworkImage {
    UIImage *placeHoderImage = [UIImage commonPickerImageNamed:@"imageLook.png"];
    [self.photoImageButton setImage:placeHoderImage forState:UIControlStateNormal];
    
    [self __showActivityIndicator:YES];
}

/**
 *  结束更新显示网络图片
 *
 *  @param networkImage 网络图片
 *  @param resultModel  获取网络图片的结果
 */
- (void)endUpdateNetworkImage:(UIImage *)networkImage
              withResultModel:(nullable CJDemoImageResultModel *)resultModel
{
    [self __showActivityIndicator:NO];
    [self __updatePhotoWithImage:networkImage recognizeResultModel:resultModel];
}



/// 更新照片并显示识别结果
- (void)__updatePhotoWithImage:(UIImage *)image recognizeResultModel:(CJDemoImageResultModel *)recognizeResultModel {
    _isEmptyImage = NO;
    _image = image;
    if (self.allowPickImage) {
        self.deleteButton.hidden = NO;
    }
    [self.photoImageButton setImage:image forState:UIControlStateNormal];
    
    //resultView
    if (recognizeResultModel) {
        self.resultView.hidden = NO;
        if (recognizeResultModel.success) {
            [self.resultImageView setImage:[UIImage commonPickerImageNamed:@"two_photo_ok"]];
            //[self.resultLabel setText:NSLocalizedString(@"识别成功", nil)];
        } else {
            [self.resultImageView setImage:[UIImage commonPickerImageNamed:@"two_photo_warning"]];
            //[self.resultLabel setText:NSLocalizedString(@"识别失败", nil)];
        }
        self.resultLabel.text = recognizeResultModel.resultString;
    }
}

- (void)buttonAction:(UIButton *)button {
    if (self.allowPickImage && self.isEmptyImage) {
        if (self.imageChooseHandle) {
            self.imageChooseHandle();
        }
    }
}

- (void)deleteButtonAction:(UIButton *)button {
    [self __showEmpty];
    if (self.imageDeleteHandle) {
        self.imageDeleteHandle(self);
    }
}

/// 删除图片
- (void)deleteImage {
    [self __showEmpty];
}

#pragma mark - Lazy
/// 图片选择与展示按钮
- (UIButton *)photoImageButton {
    if (_photoImageButton == nil) {
        _photoImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoImageButton setBackgroundColor:CJColorFromHexString(@"#F5F5F6")];
        _photoImageButton.layer.cornerRadius = 8;
        _photoImageButton.layer.masksToBounds = YES;
        [_photoImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_photoImageButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_photoImageButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_photoImageButton setImage:self.defaultPhotoImage forState:UIControlStateNormal];
    }
    return _photoImageButton;
}

/// 删除按钮(删除后才能重新选择新图片)
- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_deleteButton setBackgroundColor:CJColorFromHexString(@"#F5F5F6")];
        _deleteButton.layer.cornerRadius = 6;
        [_deleteButton setImage:[UIImage commonPickerImageNamed:@"healthCer_delete_blue"] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

/// 加载网络图片时候的进度显示器
- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.color = CJColorFromHexString(@"#01ADFE");
        //_activityIndicator.backgroundColor = CJColorFromHexString(@"#F9F9F9");
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}


#pragma mark - Private
///显示默认的照片
- (void)__showEmpty {
    _isEmptyImage = YES;
    _image = nil;
    self.deleteButton.hidden = YES;
    [self.photoImageButton setImage:self.defaultPhotoImage forState:UIControlStateNormal];
    self.resultView.hidden = YES;
}

/// 显示图片加载进度
- (void)__showActivityIndicator:(BOOL)show {
    if (show) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - Class Method
+ (CGFloat)cellHeightWithContainTitle:(BOOL)containTitle {
    CGFloat imageChooseHeight = 0;
    if (containTitle) {
        imageChooseHeight = 20+17+13+98-10+20;
    } else {
        imageChooseHeight = 98-10+20;
    }
    return imageChooseHeight;
}

@end
