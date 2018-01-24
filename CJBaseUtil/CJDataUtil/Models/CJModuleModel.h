//
//  CJModuleModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJModuleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) NSIndexPath *indexPath;   /**< 该模块所在的位置 */
@property (nonatomic, assign) Class classEntry; /**< 点击后进入的控制器 */
@property (nonatomic, assign) SEL   selector;   /**< 点击后执行的方法（一般此值为空，所以检查时候优先检查这个） */

@property (nonatomic, assign) NSDictionary *userInfo;   /**< 该模块的其他信息 */
@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

@end
