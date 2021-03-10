
//  ImageCompressViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "ImageCompressViewController.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIImageCJCompressHelper.h"
#else
#import <CJBaseUIKit/UIImageCJCompressHelper.h>
#endif

#import "DemoCacheUtil.h"

#import "TwoImageCompareView.h"

#import <CQDemoKit/CQTSContainerViewFactory.h>

@interface ImageCompressViewController ()

@end

@implementation ImageCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"图片压缩前后比对", nil);
    
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
    UIImage *originImage1 = [UIImage imageNamed:@"10M_02.jpg"];
    
    NSInteger compressMaxDataLength1 = 40.0f * 1024.0f;  //40k
    TwoImageCompareView *compareView1 = [self compareViewWithOriginImage:originImage1 compressMaxDataLength:compressMaxDataLength1];
    
//    NSInteger compressMaxDataLength2 = 40.0f * 1024.0f;  //40k
//    TwoImageCompareView *compareView2 = [self compareViewWithOriginImage:originImage1 compressMaxDataLength:compressMaxDataLength2];
//
//    NSInteger compressMaxDataLength3 = 40.0f * 1024.0f;  //40k
//    TwoImageCompareView *compareView3 = [self compareViewWithOriginImage:originImage1 compressMaxDataLength:compressMaxDataLength3];
//
//    NSInteger compressMaxDataLength4 = 40.0f * 1024.0f;  //40k
//    TwoImageCompareView *compareView4 = [self compareViewWithOriginImage:originImage1 compressMaxDataLength:compressMaxDataLength4];
    
    NSArray<UIView *> *compareViews = @[compareView1];
    UIView *container = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeVertical withSubviews:compareViews fixedSpacing:10];
    
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(150);
        make.height.mas_equalTo(4*100+3*10);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - Private Method
- (TwoImageCompareView *)compareViewWithOriginImage:(UIImage *)originImage
                              compressMaxDataLength:(NSInteger)maxDataLength
{
    TwoImageCompareView *compareView1 = [[TwoImageCompareView alloc] initWithFrame:CGRectZero];
    compareView1.backgroundColor = [UIColor redColor];
    compareView1.imageView1.layer.masksToBounds = YES;
    compareView1.imageView2.layer.masksToBounds = YES;
    compareView1.imageView1.contentMode = UIViewContentModeScaleAspectFit; // 为了显示原图，好作为新图的比对
    compareView1.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    compareView1.imageView1.image = originImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *compressImageData = [UIImageCJCompressHelper compressImage:originImage withLastPossibleSize:CGSizeMake(1080, 1080) maxDataLength:maxDataLength];
        UIImage *compressImage = [UIImage imageWithData:compressImageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            compareView1.imageView2.image = compressImage;
        });
    });

    
    //[DemoCacheUtil saveImageData:compressImageData forModuleType:DemoModuleTypeAsset];
    
    return compareView1;
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
