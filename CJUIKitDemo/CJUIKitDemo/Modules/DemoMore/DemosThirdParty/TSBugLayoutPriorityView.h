//
//  TSBugLayoutPriorityView.h
//  CJUIKitDemo
//
//  Created by qian on 2021/4/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBugLayoutPriorityView : UIView {
    
}

- (void)updateName:(NSString *)name withRecognizePass:(BOOL)isRecognizePass;

#pragma mark - Class Method
+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
