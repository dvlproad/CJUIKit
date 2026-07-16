//
//  CQTSTestMethodLeftButton.h
//  CQDemoKit
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CJVerticalTextButtonStyle) {
    CJVerticalTextButtonStyleRotated,  ///< 文字旋转90度（从下往上阅读）
    CJVerticalTextButtonStyleVertical, ///< 竖排显示，每行一个字
};

/// 支持旋转90度或竖排显示的按钮
@interface CQTSTestMethodLeftButton : UIButton

@property (nonatomic, assign) CJVerticalTextButtonStyle verticalStyle;

#pragma mark - Config
- (void)configTitle:(NSString *)verticalTitle;

@end

NS_ASSUME_NONNULL_END
