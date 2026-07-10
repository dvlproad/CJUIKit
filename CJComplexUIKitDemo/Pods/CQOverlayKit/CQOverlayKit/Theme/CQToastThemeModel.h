//
//  CQToastThemeModel.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Toast 主题
@interface CQToastThemeModel : NSObject {
    
}
@property (nonatomic) UIColor *textColor;               /** 文字的颜色 */
@property (nonatomic) UIColor *bezelViewColor;          /** 文字所在背景框的颜色*/
@property (nonatomic, assign) CGFloat hideAfterDelay;   /** 文字多少秒后自动消失(默认2秒)*/


@end



