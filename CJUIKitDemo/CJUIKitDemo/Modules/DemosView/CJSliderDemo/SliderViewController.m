//
//  SliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SliderViewController.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"

@interface SliderViewController ()

@end



@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"CJSlider", nil);
    
    [self setupBaseSlier];
    
    
    [self setupPlayerSlider];
    
    
    [self setupSliderControl];

}

#pragma mark - CJBaseUISlider
- (void)setupBaseSlier {
    
    CGRect baseSliderFrame = self.baseSlider.frame;
    baseSliderFrame.size.height = 80;
    self.baseSlider.frame = baseSliderFrame;
    self.baseSlider.backgroundColor = [UIColor redColor];
    
    self.baseSlider.minimumValue = -1;
    self.baseSlider.maximumValue = 1;
    self.baseSlider.value = 0;
    
    
    self.baseSlider.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:-1 max:0.4 toValue:-1],
                                    [[CJAdsorbModel alloc] initWithMin:0.4 max:1 toValue:1]
                                    ];
    
    self.baseSlider.trackHeight = 40;  

    UIImage *thumbImage = [[UIImage imageNamed:@"bg.jpg"] cj_transformImageToSize:CGSizeMake(80, 80)];
    
    
    thumbImage = [thumbImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.baseSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    
//    self.baseSlider.sliderType = CJSliderTypeRange;
//    self.baseSlider.blankColor = [UIColor greenColor];
//    self.baseSlider.rangeColor = [UIColor cyanColor];
//    self.baseSlider.basePercentValue = 0.7;
    
    
    [self.baseSlider addTarget:self action:@selector(bothwaySliderAction:) forControlEvents:UIControlEventValueChanged];
    
    self.baseSliderValuelabel.text = [NSString stringWithFormat:@"%f", self.baseSlider.value];
}

- (void)bothwaySliderAction:(UISlider *)slider {
    self.baseSliderValuelabel.text = [NSString stringWithFormat:@"%f", slider.value];
}


#pragma mark - CJPlayerSlider
- (void)setupPlayerSlider {
    self.playerSlider.enableTip = YES;
}


- (void)setupSliderControl {
    UIImage *mainThumbImage = [UIImage imageNamed:@"bg.jpg"];
    
    /* 基于UIControl封装的CJSliderControl */
    UIImage *trackImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
    trackImage = [trackImage resizableImageWithCapInsets:UIEdgeInsetsMake(3, 7, 3, 7) resizingMode:UIImageResizingModeStretch];
    
    self.sliderControl1.thumbMoveMinXMargin = 30;
    [self.sliderControl1 setupViewWithCreateTrackViewBlock:^UIView *{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor cyanColor];
        imageView.layer.masksToBounds = YES;
        [imageView setImage:trackImage];
        return imageView;
        
    } createMinimumTrackViewBlock:nil createMaximumTrackViewBlock:nil];
//    [self.sliderControl1.trackView setBackgroundColor:[UIColor redColor]];
    [self.sliderControl1.minimumTrackView setBackgroundColor:[UIColor magentaColor]];
    [self.sliderControl1.maximumTrackView setBackgroundColor:[UIColor clearColor]];
    
    self.sliderControl1.minValue = 0.0f;        //设置滑竿的最小值
    self.sliderControl1.maxValue = 100.0f;      //设置滑竿的最大值
    self.sliderControl1.value = 10;
    
    self.sliderControl1.delegate = self;                             //设置代理对象，用于接收滑竿滑动后值得改变
    [self.sliderControl1.mainThumb setImage:mainThumbImage forState:UIControlStateNormal];
    self.sliderControl1.mainThumb.alpha = 0.5;
    //self.sliderControl1.valueAccoringType = CJSliderValueAccoringTypeThumbMinX;
    self.sliderControl1.popoverType = CJSliderPopoverDispalyTypeNum; //设置popover显示的类型,百分比或者纯数字显示
    
    self.sliderControlValueLabel1.text = [NSString stringWithFormat:@"选取的值是: %.1f",self.sliderControl1.value];
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    if (slider == self.sliderControl1) {
        self.sliderControlValueLabel1.text = [NSString stringWithFormat:@"选取的值是: %.2f", value];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
