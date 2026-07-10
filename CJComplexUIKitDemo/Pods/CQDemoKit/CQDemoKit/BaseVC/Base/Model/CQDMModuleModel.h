//
//  CQDMModuleModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQDMModuleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger contentLines;
@property (nullable, nonatomic, strong) UIImage *normalImage;
@property (nullable, nonatomic, strong) UIImage *selectedImage;
@property (nullable, nonatomic, copy) NSString *imageUrl;       /**< 有网络图片时候，优先使用网络图片 */

@property (nullable, nonatomic, strong) NSIndexPath *indexPath; /**< 该模块所在的位置 */

/// 以下三个方法只会执行一个，检查顺序依次为 actionBlock -> selector -> classEntry
//①控制器
@property (nullable, nonatomic, assign) Class classEntry;       /**< 点击后进入的控制器 */
@property (nonatomic, assign) BOOL isCreateByXib;               /**< 控制器是否要由interface来生成 */
@property (nullable, nonatomic, strong) NSBundle *xibBundle;    /**< 控制器由interface生成时候所在的bundle（默认nil，表示是xib的时候，该xib在mainBundle中） */
@property (nullable, nonatomic, copy) NSString *xibBundleName;  /**< bundle名字(xibBundle为nil时候，才会使用这个值) */

// 视图（如果要测试 SwiftUI ,请参考主工程中的 TSTSSwiftUIView.swift 先将 swiftui 的 view 转成 UIView/UIViewController )
@property (nullable, nonatomic, copy) UIView*(^viewGetterHandle)(void);       /**< 点击后进入的控制器 里面显示的视图 */


//②③事件
@property (nullable, nonatomic, assign) SEL   selector;         /**< 点击后执行的方法 */
@property (nullable, nonatomic, copy) void(^actionBlock)(void); /**< 点击后执行的方法 */

@property (nullable, nonatomic, assign) NSDictionary *userInfo; /**< 该模块的其他信息 */
@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

- (void)updateContent:(NSString *)content;


#pragma mark - Util
/// 获取测试的视图（如果要测试整个viewController，建议使用 classEntry ）
+ (UIViewController *)viewControllWithTitle:(NSString *)title tsview:(UIView *)tsview;

@end

NS_ASSUME_NONNULL_END
