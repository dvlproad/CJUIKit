//
//  CJSwitchSlider.m
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSwitchSlider.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"

#import "CJSliderStatusModel.h"

@interface CJSwitchSlider () <CJSliderControlDelegate>

@end


@implementation CJSwitchSlider

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    /*
     CGRect baseSliderFrame = self.operateSliderControl.frame;
     baseSliderFrame.size.height = 40;
     self.operateSliderControl.frame = baseSliderFrame;
     self.operateSliderControl.backgroundColor = [UIColor greenColor];
     */
    self.thumbCannotBeyongXType = CJSliderControlThumbCannotBeyongXTypeAllX;
    self.trackHeight = 30;
    self.mainThumbImage = [[UIImage imageNamed:@"btn_hd.png"] cj_transformImageToSize:CGSizeMake(87, 46)];
    self.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.70 toValue:0],
                                              [[CJAdsorbModel alloc] initWithMin:0.71 max:1 toValue:1]];
    
    self.delegate = self;
    
    
    self.sliderStatusModels = [[NSMutableArray alloc] init];
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"bgCar.jpg"];
        statusModel.imageInMax = [UIImage imageNamed:@"bgSky.jpg"];
        [self.sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"bgSky.jpg"];
        statusModel.imageInMax = [UIImage imageNamed:@"header.jpg"];
        [self.sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"header.jpg"];
        statusModel.imageInMax = [UIImage cj_imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(30, 30)];
        [self.sliderStatusModels addObject:statusModel];
    }
    
    
    self.currentStep = 0;
    CJSliderStatusModel *statusModel = [self.sliderStatusModels objectAtIndex:self.currentStep];
    self.maximumTrackImage = statusModel.image;
    self.minimumTrackImage = statusModel.imageInMax;
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
//    if (slider == self.operateSliderControl) {
//        self.operateSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的值是: %.1f", value];
//    }
}

- (void)slider:(CJSliderControl *)slider adsorbToValue:(CGFloat)value {
    NSLog(@"slider adsorbToValue %1.2f",value);
    if (value >= 1.0) {
        self.currentStep ++;
        
        if (self.currentStep == self.sliderStatusModels.count -1) {
            self.mainThumbAlpha = 0.0;
            self.userInteractionEnabled = NO;
        } else {
            CJSliderStatusModel *statusModel = [self.sliderStatusModels objectAtIndex:self.currentStep];
            self.maximumTrackImage = statusModel.image;
            self.minimumTrackImage = statusModel.imageInMax;
            
            self.value = 0.0;
        }
    }
}

@end
