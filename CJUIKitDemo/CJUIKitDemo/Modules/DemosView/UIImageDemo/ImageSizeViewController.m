
//  ImageSizeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "ImageSizeViewController.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIImageCJCutHelper.h"
#import "UIButton+CJMoreProperty.h"
#else
#import <CJBaseUIKit/UIImageCJCutHelper.h>
#endif

#import "TwoImageCompareView.h"

#import <CQDemoKit/CQTSContainerViewFactory.h>
#import <CQDemoKit/CQTSButtonFactory.h>

@interface ImageSizeViewController ()

@end

@implementation ImageSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"图片裁剪前后比对", nil);
    
    UILabel *homeDirectoryLabel = [[UILabel alloc] init];
    [self.view addSubview:homeDirectoryLabel];
    [homeDirectoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
    }];
    homeDirectoryLabel.numberOfLines = 0;
    homeDirectoryLabel.text = NSHomeDirectory();
    NSLog(@"NSHomeDirectory() = %@", NSHomeDirectory());
    
    
    [self setupViews];
}

#pragma mark - SetupViews
- (void)setupViews {
    TwoImageCompareView *compareView1 = [self compareView];
    TwoImageCompareView *compareView2 = [self compareView];
    TwoImageCompareView *compareView3 = [self compareView];
    TwoImageCompareView *compareView4 = [self compareView];
    NSArray<UIView *> *compareViews = @[compareView1, compareView2, compareView3, compareView4];
    UIView *container = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeVertical withSubviews:compareViews fixedSpacing:10];
    [self.view addSubview:container];
    
    
    UIButton *tsButton = [CQTSButtonFactory themeBGButtonWithTitle:@"重新裁剪，测试闪烁" actionBlock:^(UIButton * _Nonnull bButton) {
        UIImage *originImage1 = [UIImage imageNamed:@"longVertical.jpg"];
        
        CGSize cutSize1 = CGSizeMake(30, 100);
        [self setupCompareView:compareView1 withOriginImage:originImage1 cutSize:cutSize1];
        
        CGSize cutSize2 = CGSizeMake(50, 100);
        [self setupCompareView:compareView2 withOriginImage:originImage1 cutSize:cutSize2];
        
        CGSize cutSize3 = CGSizeMake(100, 100);
        [self setupCompareView:compareView3 withOriginImage:originImage1 cutSize:cutSize3];
        
        CGSize cutSize4 = CGSizeMake(120, 100);
        [self setupCompareView:compareView4 withOriginImage:originImage1 cutSize:cutSize4];
    }];
    [self.view addSubview:tsButton];
    [tsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
  
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tsButton.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(4*100+3*10);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}


#pragma mark - Private Method
- (TwoImageCompareView *)compareView {
    TwoImageCompareView *compareView = [[TwoImageCompareView alloc] initWithFrame:CGRectZero];
    compareView.backgroundColor = [UIColor redColor];
    compareView.imageView1.layer.masksToBounds = YES;
    compareView.imageView2.layer.masksToBounds = YES;
    compareView.imageView1.contentMode = UIViewContentModeScaleAspectFit; // 为了显示原图，好作为新图的比对
    compareView.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    return compareView;
}


- (void)setupCompareView:(TwoImageCompareView *)compareView
         withOriginImage:(UIImage *)originImage
                 cutSize:(CGSize)cutSize
{
    UIImage *newImage = [UIImageCJCutHelper cutImage:originImage fromRegionType:UIImageCutFromRegionCenter tooWidthKeepRatio:4/3.0 tooHeightKeepRatio:343/580.0 noTooWidthOrHeightKeepRatio:1/1.0];
    compareView.imageView1.image = originImage;
    compareView.imageView2.image = newImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
