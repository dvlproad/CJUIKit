//
//  SwitchSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SwitchSliderViewController.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"
#import "UIColor+CJHex.h"

#import "BBXShimmeringSwitchSlider.h"
#import "BusShimmeringSwitchSlider.h"

@interface SwitchSliderViewController () {
    
}

@end

@implementation SwitchSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"SwitchSliderViewController", nil);
    
    /* ①、sliderControl3 */
    /*
    CGRect baseSliderFrame = self.sliderControl3.frame;
    baseSliderFrame.size.height = 40;
    self.sliderControl3.frame = baseSliderFrame;
    self.sliderControl3.backgroundColor = [UIColor greenColor];
    */
    UIImage *trackImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
    trackImage = [trackImage resizableImageWithCapInsets:UIEdgeInsetsMake(3, 7, 3, 7) resizingMode:UIImageResizingModeStretch];
    
    [self.sliderControl3 setupViewWithCreateTrackViewBlock:^UIView *{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.layer.masksToBounds = YES;
        
        return imageView;
        
    } createMinimumTrackViewBlock:nil createMaximumTrackViewBlock:nil];
    
    UIImageView *trackView = (UIImageView *)self.sliderControl3.trackView;
    [trackView setImage:trackImage];
    
    self.sliderControl3.mainThumb.alpha = 0.3;
    self.sliderControl3.trackHeight = 30;
    self.sliderControl3.thumbSize = CGSizeMake(60, 30);
    self.sliderControl3.thumbMoveMaxXMargin = -self.sliderControl3.thumbSize.width;
    UIImage *mainThumbImage = [UIImage imageNamed:@"bg.jpg"];
    UIImage *image3 = [mainThumbImage cj_transformImageToSize:CGSizeMake(160, 80)];
    [self.sliderControl3.mainThumb setImage:image3 forState:UIControlStateNormal];
    self.sliderControl3.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.70 toValue:0],
                                        [[CJAdsorbModel alloc] initWithMin:0.7 max:1 toValue:1]];
    self.sliderControl3.delegate = self;
    
    
    
    
    /* ②、switchSlider */
    self.switchSlider.switchAnimatedType = CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView;
    [self commonSetupToSwitchSlider:self.switchSlider];
    
    
    
    
    /* ③、shimmeringSwitchSlider1、shimmeringSwitchSlider2、shimmeringSwitchSlider3 */
    CJSwitchSlider *s_switchSlider1 = self.shimmeringSwitchSlider1.switchSlider;
    self.shimmeringSwitchSlider1.layer.masksToBounds = YES; //收边
    self.shimmeringSwitchSlider1.layer.cornerRadius = 15;
    s_switchSlider1.moveType = CJSliderMoveTypeMaximumTrackImageViewWidthAspectFit;
    s_switchSlider1.switchAnimatedType = CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView;
    [self commonSetupToSwitchSlider:s_switchSlider1];
    [s_switchSlider1 reloadSlider];
    
    
    
    
    
    
    CJSwitchSlider *s_switchSlider2 = self.shimmeringSwitchSlider2.switchSlider;
    
    s_switchSlider2.moveType = CJSliderMoveTypeMaximumTrackImageViewWidthNoChange;
    s_switchSlider2.switchAnimatedType = CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView;
    [self commonSetupToSwitchSlider:s_switchSlider2];
    [s_switchSlider2 reloadSlider];
    
    
    
    CJSwitchSlider *s_switchSlider3 = self.shimmeringSwitchSlider3.switchSlider;
    
    s_switchSlider3.moveType = CJSliderMoveTypeMaximumTrackImageViewWidthAspectFit;
    s_switchSlider3.switchAnimatedType = CJSwitchAnimatedTypeCurrentStepInTrackImageView;
    [self commonSetupToSwitchSlider:s_switchSlider3];
    [s_switchSlider3 reloadSlider];
    
    
    
    NSMutableArray *busSliderStatusModels = [self getBusSliderStatusModels];
    BusShimmeringSwitchSlider *busShimmeringSwitchSlider = [[BusShimmeringSwitchSlider alloc] init];
    busShimmeringSwitchSlider.statusModels = busSliderStatusModels;
    [self.view addSubview:busShimmeringSwitchSlider];
    [busShimmeringSwitchSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-110);
        make.height.mas_equalTo(60);
    }];
    
    NSMutableArray *bbxSliderStatusModels = [self getBBXSliderStatusModels];
    BBXShimmeringSwitchSlider *bbxShimmeringSwitchSlider = [[BBXShimmeringSwitchSlider alloc] init];
    bbxShimmeringSwitchSlider.statusModels = bbxSliderStatusModels;
    [self.view addSubview:bbxShimmeringSwitchSlider];
    [bbxShimmeringSwitchSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.bottom.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(40);
    }];
}




- (void)commonSetupToSwitchSlider:(CJSwitchSlider *)switchSlider {
    [self commonSetupUIToSwitchSlider:switchSlider];
    [self commonSetupDataToSwitchSlider:switchSlider];
}

- (void)commonSetupUIToSwitchSlider:(CJSwitchSlider *)switchSlider {
    UIView * (^createTrackViewBlock)(void) = ^(void) {
        UILabel *label = [DemoLabelFactory whiteLabelWithCornerRadius:15];
        return label;
    };
    
    UIView * (^createMinimumTrackViewBlock)(void) = ^(void) {
        UILabel *label = [DemoLabelFactory whiteLabelWithCornerRadius:15];
        return label;
    };
    
    UIView * (^createMaximumTrackViewBlock)(void) = ^(void) {
        UILabel *label = [DemoLabelFactory whiteLabelWithCornerRadius:15];
        return label;
    };
    
    void(^updateMaximumTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        if (!isDragingStauts) {
            //UIImageView *c_maximumTrackView = (UIImageView *)maximumTrackView;
            //[c_maximumTrackView setImage:statusModel.normalImage];
            
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.normalText];
            [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
            
        } else {
//            //UIImageView *c_maximumTrackView = (UIImageView *)maximumTrackView;
//            //[c_maximumTrackView setImage:statusModel.dragingImage];
//
//            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
//            [c_maximumTrackView setText:statusModel.dragingText];
//            [c_maximumTrackView setBackgroundColor:statusModel.dragingColor];
        }
    };
    
    void(^updateTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        if (!isDragingStauts) {
            //UIImageView *c_maximumTrackView = (UIImageView *)maximumTrackView;
            //[c_maximumTrackView setImage:statusModel.normalImage];
            
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.normalText];
            [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
            
        } else {
            //UIImageView *c_maximumTrackView = (UIImageView *)maximumTrackView;
            //[c_maximumTrackView setImage:statusModel.dragingImage];
            
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.dragingText];
            [c_maximumTrackView setBackgroundColor:statusModel.dragingColor];
        }
    };
    [switchSlider setupViewWithCreateTrackViewBlock:createTrackViewBlock
                        createMinimumTrackViewBlock:createMinimumTrackViewBlock
                        createMaximumTrackViewBlock:createMaximumTrackViewBlock];
    [switchSlider setupUpdateTrackViewBlock:updateTrackViewBlock
                updateMinimumTrackViewBlock:nil
                updateMaximumTrackViewBlock:updateMaximumTrackViewBlock];
    
    switchSlider.thumbMoveMinXMargin = 20;
    switchSlider.criticalValue = 0.5;
    switchSlider.thumbSize = CGSizeMake(58, 31);
}


- (NSMutableArray *)getBusSliderStatusModels {
    NSMutableArray *sliderStatusModels = [[NSMutableArray alloc] init];
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        statusModel.normalText = NSLocalizedString(@"开始发车、2这里会自适应字体大小", nil);
        statusModel.normalColor = [UIColor cjColorWithHexString:@"#4288ff"];
        statusModel.goNextStepWhenSwitchEventOccur = NO;
        [sliderStatusModels addObject:statusModel];
    }
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        statusModel.normalText = @"";
        statusModel.normalColor = [UIColor cjColorWithHexString:@"#1D4A98"];
        [sliderStatusModels addObject:statusModel];
    }
    
    return sliderStatusModels;
}

- (NSMutableArray *)getBBXSliderStatusModels {
    NSMutableArray *sliderStatusModels = [[NSMutableArray alloc] init];
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        //statusModel.normalImage = [UIImage imageNamed:@"icon_ddlb_jd.png"];
        statusModel.normalText = @"接到乘客";
        statusModel.normalColor = [UIColor cjColorWithHexString:@"#00aaff"];
        
        //statusModel.dragingImage = nil;
        statusModel.dragingText = @"";
        statusModel.dragingColor = [UIColor cjColorWithHexString:@"#0a6fa2"];
        statusModel.goNextStepWhenSwitchEventOccur = YES;
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        //statusModel.normalImage = [UIImage imageNamed:@"icon_ddlb_hd.png"];
        statusModel.normalText = @"送完乘客";
        statusModel.normalColor = [UIColor cjColorWithHexString:@"#ff4343"];
        
        statusModel.dragingImage = nil;
        statusModel.dragingText = @"";
        statusModel.dragingColor = [UIColor cjColorWithHexString:@"#cd3737"];
        statusModel.goNextStepWhenSwitchEventOccur = YES;
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        //        statusModel.image = [UIImage cj_imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(30, 30)];
        [sliderStatusModels addObject:statusModel];
    }
    
    return sliderStatusModels;
}

- (void)commonSetupDataToSwitchSlider:(CJSwitchSlider *)switchSlider {
    NSMutableArray *sliderStatusModels = [self getBBXSliderStatusModels];
    switchSlider.statusModels = sliderStatusModels;
    
    UIImage *mainThumbImage = [UIImage imageNamed:@"btn_hd.png"];
    [switchSlider.mainThumb setImage:mainThumbImage forState:UIControlStateNormal];
    
    [switchSlider showStep:0];
    
    [switchSlider setSwitchEventOccuBlock:^(NSInteger execStep){
        NSLog(@"第%zd个步骤执行", execStep);
    }];
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    if (slider == self.sliderControl3) {
        self.sliderControlValueLabel3.text = [NSString stringWithFormat:@"选取的值是: %.2f", value];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
