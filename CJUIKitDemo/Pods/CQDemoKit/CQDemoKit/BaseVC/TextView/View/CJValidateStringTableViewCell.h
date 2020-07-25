//
//  CJValidateStringTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface CJValidateStringTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, copy) BOOL (^validateHandle)(CJValidateStringTableViewCell *mcell, BOOL isAutoExec);

/**
 *  cell执行既定操作
 *
 *  @param isAutoExec   是否是自动执行的
 */
- (void)validateEvent:(BOOL)isAutoExec;

@end
