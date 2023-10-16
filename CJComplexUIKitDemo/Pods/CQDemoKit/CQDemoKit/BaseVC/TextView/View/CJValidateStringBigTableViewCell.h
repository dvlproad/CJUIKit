//
//  CJValidateStringBigTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  Cell视图【多行排列】的文本列表单元

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJValidateStringBigTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, assign) CGFloat fixTextViewHeight;  /**< 固定textView的视图高度（该值大于44才生效），默认固定为44 */

@property (nonatomic, copy) BOOL (^validateHandle)(CJValidateStringBigTableViewCell *mcell, BOOL isAutoExec);

@property (nonatomic, copy) void(^textDidChangeBlock)(NSString *bText); /**< 文本框内容变化的回调 */

/**
 *  cell执行既定操作
 *
 *  @param isAutoExec   是否是自动执行的
 */
- (void)validateEvent:(BOOL)isAutoExec;

@end

NS_ASSUME_NONNULL_END
