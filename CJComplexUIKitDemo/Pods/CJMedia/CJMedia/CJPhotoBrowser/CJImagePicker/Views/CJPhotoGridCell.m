//
//  CJPhotoGridCell.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJPhotoGridCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CJPhotoGridCell ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation CJPhotoGridCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageButton addTarget:self action:@selector(imageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imageButton];
    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.mas_equalTo(0);
    }];
    self.imageButton = imageButton;
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [checkButton addTarget:self action:@selector(checkButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkButton];
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-5);
        make.right.mas_equalTo(5);
        make.width.and.height.mas_equalTo(44);
    }];
    self.checkButton = checkButton;
    
    
    [self.checkButton setImage:[UIImage imageNamed:@"cjAlbumCheckedNormal"] forState:UIControlStateNormal];
    [self.checkButton setImage:[UIImage imageNamed:@"cjAlbumCheckedSelect"] forState:UIControlStateSelected];
    self.selected = NO;
}

- (void)imageButtonTap:(id)sender {
    if (self.imageButtonTapBlock) {
        self.imageButtonTapBlock();
    }
}

- (void)checkButtonTap:(id)sender {
    if (self.checkButtonTapBlock) {
        self.checkButtonTapBlock();
    }
}

- (void)setImageButtonImage:(UIImage *)image {
    [self.imageButton setImage:image forState:UIControlStateNormal];
}


- (void)setImageItem:(AlumbImageModel *)imageItem {
    _imageItem = imageItem;
    
    if (imageItem == nil) {
        self.hidden = YES;
        
    } else {
        self.hidden = NO;
        
        [self loadImage];                   //用来设置imageButton
        self.selected = imageItem.selected; //用来设置checkButton
    }
}

- (void)loadImage
{
    if (_imageItem.image != nil) {
        [self.imageButton setImage:_imageItem.image forState:UIControlStateNormal];
    } else {
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        [assetLibrary assetForURL:[NSURL URLWithString:_imageItem.url] resultBlock:^(ALAsset *asset)  {
            self.imageItem.image =[UIImage imageWithCGImage:asset.thumbnail];
            [self.imageButton setImage:self.imageItem.image forState:UIControlStateNormal];
        }failureBlock:^(NSError *error) {
            [self.imageButton setImage:[UIImage imageNamed:@"CJAvatar"] forState:UIControlStateNormal];
        }];
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    _checkButton.selected = selected;
}

@end
