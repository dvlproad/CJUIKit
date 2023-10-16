//
//  CQHorizontalAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQHorizontalAlertView : UIView {
    
}

#pragma mark - Init
- (instancetype)initWithImage:(nullable UIImage *)image
                        title:(NSString *)title
             operateEventText:(NSString *)operateEventText
            operateEventBlock:(void(^)(void))operateEventBlock
                   closeImage:(UIImage *)closeImage
                  closeHandle:(void(^)(void))closeHandle;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Update
/// topAlert有时候会公用（比如选择不同类型表信息/里信息，顶部alert更新对应数据）
- (void)updateWithImage:(nullable UIImage *)image
                  title:(NSString *)title
       operateEventText:(NSString *)operateEventText
      operateEventBlock:(void(^)(void))operateEventBlock
             closeImage:(UIImage *)closeImage
            closeHandle:(void(^)(void))closeHandle;

@end

NS_ASSUME_NONNULL_END
