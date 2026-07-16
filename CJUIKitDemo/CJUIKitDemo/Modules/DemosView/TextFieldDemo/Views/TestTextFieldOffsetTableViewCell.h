//
//  TestTextFieldOffsetTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  测试 CJTextField 的 offset 的设置（offset 的加减使用 <CQDemoKit/CQTSTextFieldFactory.h> 来操作）

#import <UIKit/UIKit.h>
#import <CJBaseUIKit/CJTextField.h>

@interface TestTextFieldOffsetTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) UILabel *changeExplainLabel;
@property (nonatomic, strong) CJTextField *textField;
@property (nonatomic, strong) UILabel *extraResultLabel;


@end
