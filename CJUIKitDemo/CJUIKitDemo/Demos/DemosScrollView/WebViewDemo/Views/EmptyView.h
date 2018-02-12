//
//  EmptyView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIView {
    
}
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UIButton *button;

@property (nonatomic, copy) void(^reloadBlock)(void);

- (void)showEmptyViewWithFailureMessage:(NSString *)failureMessage;

@end
