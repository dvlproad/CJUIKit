//
//  CountDownTimeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTimeManager.h"

@interface CountDownTimeViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *countDownTimeButton1;  /**< 倒计时按钮 */

@property (nonatomic, strong) IBOutlet UILabel *countDownTimeLabel1;  /**< 倒计时按钮 */
@property (nonatomic, strong) IBOutlet UILabel *countDownTimeLabel2;  /**< 倒计时按钮 */

@property (nonatomic, strong) IBOutlet UIButton *countDownTimeButton2;  /**< 倒计时按钮 */

@end
