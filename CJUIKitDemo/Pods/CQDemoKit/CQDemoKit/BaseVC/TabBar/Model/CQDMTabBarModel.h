//
//  CQDMTabBarModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CQDMTabBarModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
//①控制器
@property (nonatomic, assign) Class classEntry;     /**< 点击后进入的控制器 */
@property (nonatomic, assign) BOOL isCreateByXib;   /**< 控制器是否要由interface来生成 */

@property (nonatomic, assign) NSDictionary *userInfo;   /**< 该模块的其他信息 */
@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

@end
