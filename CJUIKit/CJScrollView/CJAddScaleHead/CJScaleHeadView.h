//
//  CJScaleHeadView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

//添加图片下拉放大功能。原理：其实是利用UIScrollView的contentInset，在UIScrollView上添加一个view。通过监听UIScrollView的contentOffset来改变所添加view的frame，对于view上的图片的contentMode必须设置为UIViewContentModeScaleAspectFill， 这样才能保证图片在放大的过程中高和宽是同时放大的
//因为需要添加UIScrollView的contentOffset的监听，而有添加，则代表也要有删除监听，监听的位置一般为视图释放时候，但是我们为了避免不在类目中重写父类方法，所以我们采用通过在子视图中获取父视图，并在子视图类中进行监听，以此来避免在类目中重写父类方法而引起一些你无法预料到的错误。尤其这里还是监听一个系统的属性contentOffset

//其他转屏可参考：https://github.com/CharlinFeng/CorePullScale
@interface CJScaleHeadView : UIView {
    
}
@property (nonatomic, assign, readonly) CGFloat pullUpMinHeight;  /**< 在上推缩小的过程中能推到的最小高度(默认0) */

@property (nonatomic, assign) CGFloat originHeight;  /**< 初始高度 */

- (void)commonInit;

/**
 *  设置视图下拉、上推所根据的滚动视图和该滚动视图是否是依附在导航栏上的BOOL值
 *
 *  @param scrollView           下拉、上推所根据的滚动视图和该滚动视图
 *  @param attachNavigationBar  滚动视图是否会依附在导航栏上(如果依附的话，则view的最小大小为navigationBarHeight + statusBarHeight，否则为0)
 */
- (void)pullScaleByScrollView:(UIScrollView *)scrollView withAttachNavigationBar:(BOOL)attachNavigationBar;

/**
 *  重新获取NavigationBar的高度（在屏幕旋转的时候必须用到）
 */
- (void)resetNavigationBarHeight;

@end
