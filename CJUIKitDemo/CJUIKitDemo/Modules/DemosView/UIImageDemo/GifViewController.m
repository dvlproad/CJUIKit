//
//  GifViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/7/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "GifViewController.h"
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/SDWebImageDownloader.h>

@interface GifViewController () {
    
}
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *pngBlueButton = [DemoButtonFactory blueButton];
    [pngBlueButton setTitle:NSLocalizedString(@"显示PNG图片", nil) forState:UIControlStateNormal];
    [pngBlueButton addTarget:self action:@selector(showPNG) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pngBlueButton];
    [pngBlueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *gifBlueButton = [DemoButtonFactory blueButton];
    [gifBlueButton setTitle:NSLocalizedString(@"显示Gif动画", nil) forState:UIControlStateNormal];
    [gifBlueButton addTarget:self action:@selector(showGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gifBlueButton];
    [gifBlueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pngBlueButton.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gifBlueButton.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(144);
    }];
    self.imageView = imageView;
}

- (void)showPNG {
    self.imageView.image = [UIImage imageNamed:@"imageOriginColor"];
}

- (void)showGif {
    NSString *gifUrl = @"http://qq.yh31.com/tp/zjbq/201711142021166458.gif";
    NSURL *imgeUrl = [NSURL URLWithString:gifUrl];
    SDWebImageDownloaderOptions options = 0;
    
    // 方法一 SDWebImageDownloader下载
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:imgeUrl
                             options:options
                            progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                
                            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                self.imageView.image = [UIImage sd_imageWithGIFData:data];
                            }];
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
