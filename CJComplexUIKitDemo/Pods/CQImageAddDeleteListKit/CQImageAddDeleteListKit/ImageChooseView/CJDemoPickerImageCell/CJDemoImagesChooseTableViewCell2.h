//
//  CJDemoImagesChooseTableViewCell2.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDemoAttributedTexHelper.h"
#import "CJDemoImageChooseView2.h"

@interface CJDemoImagesChooseTableViewCell2 : UITableViewCell {
    
}
@property (nonatomic, strong) UILabel *promptTitleLable;
@property (nonatomic, strong) CJDemoImageChooseView2 *imageChooseView1;
@property (nonatomic, strong) CJDemoImageChooseView2 *imageChooseView2;
@property (nonatomic, assign) BOOL allowPickImage;  /**< 是否允许选择图片(修改状态下才能允许选择) */

+ (CGFloat)cellHeight;

@end
