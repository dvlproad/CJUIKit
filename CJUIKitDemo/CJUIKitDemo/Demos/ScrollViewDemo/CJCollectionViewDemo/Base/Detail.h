//
//  Detail.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoInfo.h"

@class Detail;
@protocol DetailDelegate <NSObject>

- (void)goCancel:(Detail *)vc;
- (void)goOK:(Detail *)vc;

@end


@interface Detail : UIViewController

@property(nonatomic, strong) DemoInfo *info;
@property(nonatomic, strong) id <DetailDelegate> delegate;

@end
