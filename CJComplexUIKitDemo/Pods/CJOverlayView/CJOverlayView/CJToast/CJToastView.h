//
//  CJToastView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJToastView : UIView {
    
}

#pragma mark - Init
- (instancetype)initWithMessage:(NSString *)message NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Class Method
/// 计算 toastView 的大小
+ (CGSize)sizeWithMessage:(NSString *)message
          messageMaxWidth:(CGFloat)messageMaxWidth;

@end

NS_ASSUME_NONNULL_END
