//
//  CQTSTextFieldFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CJBaseUIKit/CJTextField.h>
#import <CJBaseUIKit/UIColor+CJHex.h>

@interface CQTSTextFieldFactory : NSObject {
    
}

/*
 *  含加减操作的的文本框
 *
 *  @param leftButtonHandle     左侧减-操作的事件
 *  @param rightButtonHandle    右侧加+操作的事件
 *
 *  @return 截取后的字符串长度
 */
+ (CJTextField *)textFieldWithMinusHandle:(void(^)(UIButton *button))leftButtonHandle
                                addHandle:(void(^)(UIButton *button))rightButtonHandle;

@end
