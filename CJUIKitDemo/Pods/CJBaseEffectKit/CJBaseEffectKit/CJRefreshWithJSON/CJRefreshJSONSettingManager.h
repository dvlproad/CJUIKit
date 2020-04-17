//
//  CJRefreshJSONSettingManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJRefreshJSONSettingManager : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *animationNamed;       /** Json动画文件名 */
@property (nonatomic, copy, readonly) NSBundle *animationBundle;    /** Json动画文件所在的bundle(如果是在MainBundle中，则可直接设为nil) */

@property (nonatomic, copy, readonly) NSString *headerIdleText;       /** 普通闲置状态：@"下拉刷新" */
@property (nonatomic, copy, readonly) NSString *headerPullingText;    /** 松开就可以进行刷新的状态：@"松开刷新" */
@property (nonatomic, copy, readonly) NSString *headerRefreshingText; /** 正在刷新中的状态：@"加载数据中" */

@property (nonatomic, copy, readonly) NSString *footerIdleText;       /** 普通闲置状态：@"上拉加载更多" */
@property (nonatomic, copy, readonly) NSString *footerPullingText;    /** 松开就可以进行刷新的状态：@"释放加载" */
@property (nonatomic, copy, readonly) NSString *footerRefreshingText; /** 正在刷新中的状态：@"加载中..." */
@property (nonatomic, copy, readonly) NSString *footerNoMoreDataText; /** 所有数据加载完毕，没有更多的数据了：@"没有更多数据了..." */


+ (CJRefreshJSONSettingManager *)sharedInstance;

#pragma mark - HEADER
/*
*  设置下拉刷新动画对应的json文件名（必须调用）
*
*  @param animationNamed    动画对应的json文件名
*  @param animationBundle   动画对应的json文件所在的bundle(如果是在MainBundle中，则可直接设为nil)
*/
- (void)configHeaderAnimationWithAnimationNamed:(NSString *)animationNamed
                                       inBundle:(NSBundle *)animationBundle;
- (void)updateHeaderStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText;

#pragma mark - FOOTER
- (void)updateFooterStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
                           noMoreDataText:(NSString *)noMoreDataText;

@end
