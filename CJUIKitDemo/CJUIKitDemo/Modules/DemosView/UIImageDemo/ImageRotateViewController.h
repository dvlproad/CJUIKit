//
//  ImageRotateViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/6/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  图片旋转

#import <UIKit/UIKit.h>

@interface ImageRotateViewController : UIViewController {
    
}
@property (nonatomic, weak) IBOutlet UIImageView *imageView1;
@property (nonatomic, weak) IBOutlet UIImageView *imageView2;
@property (nonatomic, weak) IBOutlet UIImageView *imageView3;

@property (nonatomic, weak) IBOutlet UILabel *sliderValueLabel; /**< 旋转的角度值 */
@property (nonatomic, weak) IBOutlet UISlider *slider;          /**< 设置旋转角度的滑块 */

@end
