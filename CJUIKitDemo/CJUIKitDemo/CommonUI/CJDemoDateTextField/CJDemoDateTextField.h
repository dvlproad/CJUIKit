//
//  CJDemoDateTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/3.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoDateTextField : CJTextField {
    
}
@property (nonatomic, readonly) NSDate *currentDate;

/**
 *  用来选择日期的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param defaultDate          defaultDate
 *  @param confirmCompleteBlock confirmCompleteBlock
 */
- (instancetype)initWithDefaultDate:(NSDate *)defaultDate
               confirmCompleteBlock:(void(^)(NSDate *seletedDate, NSString *seletedDateString))confirmCompleteBlock;

@end

NS_ASSUME_NONNULL_END
