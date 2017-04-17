//
//  CJTextField.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTextField : UITextField

@property (nonatomic, copy) void (^textChangeBlock)(CJTextField *textField);  /**< 文本改变的通知事件 */
@property (nonatomic, assign) BOOL hideMenuController;  /**< 是否隐藏弹出菜单(一般为选择、复制、粘贴) */
@property (nonatomic, assign) BOOL hideCursor;          /**< 是否隐藏光标(默认NO),隐藏光标的时候最好同时禁止手动输入 */

- (void)commonInit;

@end
