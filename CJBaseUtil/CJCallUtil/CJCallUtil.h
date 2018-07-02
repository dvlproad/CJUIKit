//
//  CJCallUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

///调用系统服务的类(包括拨打电话等)
@interface CJCallUtil : NSObject

+ (void)callPhoneWithNum:(NSString *)phoneNum atView:(UIView *)atView;

@end
