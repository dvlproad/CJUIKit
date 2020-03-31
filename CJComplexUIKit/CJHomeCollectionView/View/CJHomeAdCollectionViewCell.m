//
//  CJHomeAdCollectionViewCell.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJHomeAdCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface CJHomeAdCollectionViewCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *activityView;

@end



@implementation CJHomeAdCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
        [self createAutoLayout];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview: self.activityView];
}

- (void)createAutoLayout {
    __weak __typeof(self)myself = self;
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(myself).with.insets(UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f));
    }];
    
}

#pragma mark - 数据渲染
- (void)setAdDataModels:(NSArray<CJHomeAdDataModel *> *)adDataModels {
    _adDataModels = adDataModels;
    
    NSMutableArray *imageNames = [[NSMutableArray alloc] init];
    for (CJHomeAdDataModel *adDataModel in adDataModels) {
        [imageNames addObject:adDataModel.imageName];
    }
    self.activityView.localizationImageNamesGroup = imageNames;
    self.activityView.autoScroll = self.adDataModels.count > 1 ? YES : NO;
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (index < self.adDataModels.count) {
        CJHomeAdDataModel *posModel = self.adDataModels[index];
        if (self.activityClickBlock) {
            self.activityClickBlock(posModel, index);
        }
    }
}

#pragma mark - lazy init
@synthesize activityView = _activityView;
-(SDCycleScrollView *)activityView {
    if (_activityView == nil) {
        _activityView = [[SDCycleScrollView alloc] init];
        _activityView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _activityView.currentPageDotColor = [UIColor whiteColor];
        _activityView.autoScrollTimeInterval = 3.0f;
        _activityView.backgroundColor = [UIColor whiteColor];
        _activityView.delegate = self;
        //_activityView.placeholderImage = [UIImage imageNamed: iPhoneX ?@"home_pic_iPhoneX" : @"home_default_pic"];
        _activityView.currentPageDotImage = [UIImage imageNamed:@"pageControl_select_icon"];
        _activityView.pageDotImage = [UIImage imageNamed:@"pageControl_normal_icon"];
        for (UIView * view in _activityView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                view.contentMode = UIViewContentModeScaleToFill;
                break;
            }
        }
    }
    return _activityView;
}


@end
