//
//  MyCycleADViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/12.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface MyCycleADViewController : UIViewController <SDCycleScrollViewDelegate> {
    
}
@property (nonatomic, strong) NSMutableArray *adDataModels;
@property (nonatomic, strong) SDCycleScrollView *adScrollView;

@end
