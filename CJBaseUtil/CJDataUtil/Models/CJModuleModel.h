//
//  CJModuleModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJModuleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, copy) NSString *normalImageUrl;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) NSIndexPath *indexPath;   /**< 该模块所在的位置 */

/// 以下三个方法只会执行一个，检查顺序依次为 actionBlock -> selector -> classEntry
//①控制器
@property (nonatomic, assign) Class classEntry;             /**< 点击后进入的控制器 */
@property (nonatomic, assign) BOOL isCreateByXib;           /**< 控制器是否要由interface来生成 */
@property (nullable, nonatomic, strong) NSBundle *xibBundle;/**< 控制器由interface生成时候所在的bundle（默认nil，表示是xib的时候，该xib在mainBundle中） */
@property (nonatomic, copy) NSString *xibBundleName;        /**< bundle名字(xibBundle为nil时候，才会使用这个值) */

//②③事件
@property (nonatomic, assign) SEL   selector;           /**< 点击后执行的方法 */
@property (nonatomic, copy) void(^actionBlock)(void);   /**< 点击后执行的方法 */

@property (nonatomic, assign) NSDictionary *userInfo;   /**< 该模块的其他信息 */
@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

@end

NS_ASSUME_NONNULL_END
