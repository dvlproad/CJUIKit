//
//  CJDemoImagesChooseTableViewCell1.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDemoAttributedTexHelper.h"
#import "CJDemoImageChooseView1.h"

@interface CJDemoImagesChooseTableViewCell1 : UITableViewCell {
    
}
@property (nonatomic, strong) CJDemoImageChooseView1 *imageChooseView1;
@property (nonatomic, strong) CJDemoImageChooseView1 *imageChooseView2;

#pragma mark - Class Method
+ (CGFloat)cellHeight;

@end
