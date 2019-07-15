//
//  WelcomeView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/7/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, WelcomeImageType) {
    WelcomeImageTypeStatic = 0,     /**< 静图 */
    WelcomeImageTypeGif,            /**< 动图 */
};

@interface WelcomeView : UIImageView {
    
}
@property (nonatomic, copy) NSString *copyright;    /**< 版权文字 */
@property (nonatomic, copy) NSString *welcomeText;  /**< 欢迎的文字 */
@property (nonatomic) UIColor *welcomeTextColor;    /**< 欢迎的文字颜色 */


/**
 *  初始化
 *
 *  @param imageURL             图片地址
 *  @param imageType            图片类型(静图png/jpg、动图gif)
 *  @param movieURL             视频地址
 *  @param isImageFirst         是否图片优先
 *
 *  @return 欢迎页
 */
- (instancetype)initWithImageURL:(NSURL *)imageURL
                       imageType:(WelcomeImageType)imageType
                        movieURL:(NSURL *)movieURL
                    isImageFirst:(BOOL)isImageFirst;

/**
 *  显示欢迎页
 *
 *  @param duration             欢迎页展示的期望时长
 *  @param showCompleteBlock    欢迎页展示完毕的回调
 */
- (void)showWithDuration:(NSInteger)duration
       showCompleteBlock:(void(^)(void))showCompleteBlock;

@end

