//
//  CQBaseAddDeleteContainerView.h
//  CQAddDeleteDemo
//
//  Created by ciyouzen on 2017/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 视图的操作类型（添加、删除、浏览）
typedef NS_ENUM(NSUInteger, CQAddDeleteContainerViewActionType) {
    CQAddDeleteContainerViewActionTypeUnknow = 0,   /**< 未知 */
    CQAddDeleteContainerViewActionTypeAdd,          /**<  点击“加号”进行添加 */
    CQAddDeleteContainerViewActionTypeDelete,       /**< 点击“减号”进行删除 */
    CQAddDeleteContainerViewActionTypeBrowse,       /**< 浏览 */
};

/* //子类建议使用delegate 来实现各点击事件
@class CQBaseAddDeleteContainerView;
@protocol CQAddDeleteContainerViewDelegate <NSObject>

- (void)cqBase_addDeleteContainerView:(CQBaseAddDeleteContainerView *)addDeleteContainerView
                  containerActionType:(CQAddDeleteContainerViewActionType)actionType
                   containerDataModel:(nullable id)cardTypeControlModel;

@end
*/

@interface CQBaseAddDeleteContainerView : UIView {
    
}
@property (nonatomic, strong, readonly) UIView *contentContainerView;
@property (nonatomic, assign, readonly) CGFloat containerMarginToTopRight;  /**< container离视图顶部和右侧的间距（因为container不一定是紧贴视图顶部的(右上角删除号才是紧贴)，所以UI上的距离看到是离container的时候，记得减去这个值） */
//@property (nullable, nonatomic, weak) id<CQAddDeleteContainerViewDelegate> delegate;    /**< 设置各个点击执行事件的协议(子类建议使用 delegate 来实现各点击事件) */

#pragma mark - Init
/*
 *  初始化
 *
 *  @param addIconImage                 加号icon（加号大小会取图片大小）
 *  @param addContainerViewBGColor      加号视图的背景色(此颜色和加号icon共同构成加号视图，圆角与contentContainerView一致)
 *  @param deleteIconImage              删除icon
 *  @param containerMarginToTopRight    container离视图顶部和右侧的间距
 *  @param contentContainerView         内容视图的容器（常为UIImage或者其他组合视图，如由一些视图组成的卡片视图）
 *
 *  @return 视图
 */
- (instancetype)initWithAddIconImage:(UIImage *)addIconImage
             addContainerViewBGColor:(UIColor *)addContainerViewBGColor
                     deleteIconImage:(UIImage *)deleteIconImage
           containerMarginToTopRight:(CGFloat)containerMarginToTopRight
                contentContainerView:(UIView *)contentContainerView;
/*
 *  初始化
 *
 *  @param addContainerView             加号视图的容器(常见为直接是一个UIImageView，也可能是一个内部包含加号icon图片的自定义视图)
 *  @param deleteIconImage              删除icon
 *  @param containerMarginToTopRight    container离视图顶部和右侧的间距
 *  @param contentContainerView         内容视图的容器（常为UIImage或者其他组合视图，如由一些视图组成的卡片视图）
 *
 *  @return 视图
 */
- (instancetype)initWithAddContainerView:(UIView *)addContainerView
                         deleteIconImage:(UIImage *)deleteIconImage
               containerMarginToTopRight:(CGFloat)containerMarginToTopRight
                    contentContainerView:(UIView *)contentContainerView NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


#pragma mark - Config
/*
 *  设置各个点击的执行事件（//子类建议使用delegate 来实现各点击事件）
 *
 *  @param addHandle        点击“加号”进行添加
 *  @param deleteHandle     点击“减号”进行删除
 *  @param browseHandle     点击"内容"进行查看(可以为nil,为ni的时候不会添加browseTapGR，防止无脑添加盖住了某些视图本身的tap操作)
 */
- (void)configAddHandle:(void(^)(void))addHandle
           deleteHandle:(void(^)(void))deleteHandle
           browseHandle:(void(^ _Nullable)(void))browseHandle;


/// 显示成没有数据时候只有的加号UI
- (void)showNoDataUI:(BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
