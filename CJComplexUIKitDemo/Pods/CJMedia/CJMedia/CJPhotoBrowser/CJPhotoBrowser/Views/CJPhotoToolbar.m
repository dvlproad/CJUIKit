//
//  CJPhotoToolbar.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJPhotoToolbar.h"
#import "CJPhotoModel.h"

#import "MBProgressHUD+CJPhotoBrowser.h"
#import "CJAlumbImageUtil.h"

@interface CJPhotoToolbar()

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *saveImageBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton * btnFav;
@property (nonatomic, strong) UIButton * btnSelected;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation CJPhotoToolbar

- (void)dealloc
{
    _callback = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    self.backgroundColor = [UIColor whiteColor];
    _photos = photos;
    
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    if (_photos.count > 0) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.textColor = blueTextColor;
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
        [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.centerX.equalTo(self);
        }];
    }
    
    // 返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"nav_back_blue"];
    backButtonImage = [CJAlumbImageUtil cj_changeImage:backButtonImage withTintColor:blueTextColor];
    [_backBtn setImage:backButtonImage forState:(UIControlStateNormal)];
    [_backBtn addTarget:self action:@selector(backACT) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -50,0, 0)];
    [_backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(_indexLabel);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    
    _btnSelected = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedNormal"] forState:UIControlStateNormal];
    [_btnSelected addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSelected];
    [_btnSelected mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(_indexLabel);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
    }];
}


- (void)backACT
{
    _callback(NO);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backACT" object:nil];
}

- (void)checkAction
{
    CJPhotoModel *photo = _photos[_currentPhotoIndex];
    photo.imageItem.selected = !photo.imageItem.selected;
    if (_selectedNum >= _maxCount && photo.imageItem.selected) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"最多只能选%zd张图片", _maxCount] message:nil delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
        photo.imageItem.selected = NO;
        [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedNormal"] forState:UIControlStateNormal];
        return;
    }
    if (photo.imageItem.selected) {
        _selectedNum++;
        [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedSelect"] forState:UIControlStateNormal];
    } else {
        _selectedNum--;
        [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedNormal"] forState:UIControlStateNormal];
    }
    if (_selectNumCallBack) {
        _selectNumCallBack(_selectedNum);
    }
    
}

- (void)saveImage
{
    
    __weak CJPhotoModel *photo = _photos[_currentPhotoIndex];
    
    if (photo.image == nil) {
        return;
    }
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self.hud hideAnimated:YES];
    if (error) {
        
        [MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        CJPhotoModel *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        [MBProgressHUD showSuccess:@"成功保存到相册" toView:nil];
        
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%d / %lu", (int)_currentPhotoIndex + 1, (unsigned long)_photos.count];
    
    CJPhotoModel *photo = _photos[_currentPhotoIndex];
    [_textView setText:photo.photoDescription];
    
    if (photo.fav) {
        [_btnFav setImage:[UIImage imageNamed:@"cjAlbumCheckedSelect"] forState:UIControlStateNormal];
    } else {
        [_btnFav setImage:[UIImage imageNamed:@"photo_fav"] forState:UIControlStateNormal];
    }
    if ([photo.url.absoluteString hasPrefix:@"assets"]) {
        _saveImageBtn.hidden = YES;
    } else {
        _saveImageBtn.hidden = NO;
    }
    if (photo.imageItem != nil) {
        _btnSelected.hidden = NO;
        if (photo.imageItem.selected) {
            [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedSelect"] forState:UIControlStateNormal];
        } else {
            [_btnSelected setImage:[UIImage imageNamed:@"cjAlbumCheckedNormal"] forState:UIControlStateNormal];
        }
    } else {
        _btnSelected.hidden = YES;
    }
}


@end



@interface CJBottomToolbar ()

@end
@implementation CJBottomToolbar

-(void)setSendNum:(NSNumber *)sendNum
{
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1].CGColor;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    
    _number = [[UILabel alloc] init];
    _number.font = [UIFont systemFontOfSize:16.0f];
    _number.text = [NSString stringWithFormat:@"(%d)",[sendNum intValue]];
    _number.textColor = blueTextColor;
    _number.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY).mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.and.height.mas_equalTo(25);
    }];
    
    UIButton * btnSent = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnSent setTitle:@"完成" forState:UIControlStateNormal];
    [btnSent setTitleColor:blueTextColor forState:UIControlStateNormal];
    btnSent.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomView addSubview:btnSent];
    [btnSent addTarget:self action:@selector(sentPhotos) forControlEvents:UIControlEventTouchUpInside];
    [btnSent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(_number.mas_left).mas_equalTo(25);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        
    }];
    
    
    
}

-(void)sentPhotos
{
    if ([_number.text isEqualToString:@"(0)"]) {
        return;
    }
    if (_sentCallBack) {
        _sentCallBack(YES);
    }
    
    
}


-(void)setNumStr:(NSString *)numStr{
    _number.text = [NSString stringWithFormat:@"(%@)",numStr];
}
@end


@interface CJDeleteToolbar()<UIActionSheetDelegate>

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton * btnDelete;

@end

@implementation CJDeleteToolbar


- (void)dealloc
{
    _callback = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    
    _photos = photos;
    if (_indexLabel == nil) {
        if (_photos.count > 0) {
            _indexLabel = [[UILabel alloc] init];
            _indexLabel.font = [UIFont boldSystemFontOfSize:20];
            _indexLabel.textColor = blueTextColor;
            _indexLabel.textAlignment = NSTextAlignmentCenter;
            _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:_indexLabel];
            [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(44);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.centerX.equalTo(self);
            }];
        }
        
        // 保存图片按钮
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *backButtonImage = [UIImage imageNamed:@"nav_back_blue"];
        backButtonImage = [CJAlumbImageUtil cj_changeImage:backButtonImage withTintColor:blueTextColor];
        [_backBtn setImage:backButtonImage forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(backACT) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -50,0, 0)];
        [_backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(_indexLabel);
            make.size.mas_equalTo(CGSizeMake(100, 44));
        }];
        
        
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [ _btnDelete setTitleColor:blueTextColor forState:UIControlStateNormal];
        [_btnDelete addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDelete];
        
        [_btnDelete mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(_indexLabel);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(36);
        }];
        
    }else{
        // 更新页码
        _indexLabel.text = [NSString stringWithFormat:@"%d / %lu", (int)_currentPhotoIndex + 1, (unsigned long)_photos.count];
    }
}


- (void)backACT
{
    if (self.backAction) {
        self.backAction();
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backACT" object:nil];
}

- (void)checkAction
{
    if (_callback) {
        _callback([NSNumber numberWithInteger:self.currentPhotoIndex]);
    }
//    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:@"确定删除这张照片吗？" message:@"" buttonTitles:@[@"删除"] buttonStyle:JGActionSheetButtonStyleDefault];
//    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
//    NSArray *sections = @[section1, cancelSection];
//    
//    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
//    __weak typeof(self)weakSelf =self;
//    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
//        if (indexPath.row == 0&&indexPath.section==0) {
//            if (_callback) {
//                _callback([NSNumber numberWithInteger:weakSelf.currentPhotoIndex]);
//            }
//            [sheet dismissAnimated:YES];
//        }else
//        {
//            [sheet dismissAnimated:YES]; 
//        }
//    }];
//    [sheet setOutsidePressBlock:^(JGActionSheet *sheet){
//        [sheet dismissAnimated:YES];
//    }];
//    [sheet showInView:self.superview animated:YES];
//    
}

- (void)saveImage
{
    
    __weak CJPhotoModel *photo = _photos[_currentPhotoIndex];
    
    if (photo.image == nil) {
        return;
    }
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self.hud hideAnimated:YES];
    if (error) {
        
        [MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        CJPhotoModel *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        [MBProgressHUD showSuccess:@"成功保存到相册" toView:nil];
        
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%d / %lu", (int)_currentPhotoIndex + 1, (unsigned long)_photos.count];
    
}

@end
