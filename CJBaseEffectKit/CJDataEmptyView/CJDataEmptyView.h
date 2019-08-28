//
//  CJDataEmptyView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/2/6.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface CJDataEmptyView : UIView {
    
}
@property (nonatomic, assign) CGFloat distancBetweenTitleAndImage; /**< title和图片距离 */
@property (nonatomic, assign) CGFloat distancBetweenButtonAndImage; /**< 按钮和图片距离 */

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CGSize imageSize;

@property (nonatomic, copy) NSString *title;    /**< 标题 */
@property (nonatomic) UIColor *titleColor;      /**< 标题颜色 */
@property (nonatomic) UIFont *titleFont;        /**< 标题字体大小 */

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic) CGSize buttonSize;
@property (nonatomic, assign) BOOL showReloadButton;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, copy) void(^reloadBlock)(CJDataEmptyView *m_emptyView);

@end
