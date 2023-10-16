//
//  CQActionImageCellContentContainerView.h
//  TSImageAddDeleteListDemo
//
//  Created by ciyouzen on 2020/9/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CQImageKit/CQImageEnum.h>

typedef NS_ENUM(NSUInteger, CQActionImageFlagType) {
    CQActionImageFlagTypeNone = 0,      /**< flag不显示 */
    CQActionImageFlagTypeHighight,      /**< flag高亮(用于还没添加的时候，起到一个强调提示的作用) */
    CQActionImageFlagTypeNormal,        /**< flag不高亮(用于还没添加的时候，起到一个普通提示的作用) */
};


NS_ASSUME_NONNULL_BEGIN

@interface CQActionImageCellContentContainerView : UIView {
    
}
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UIImageView *cjImageView;

@property (nonatomic, assign) CQActionImageFlagType flagType;

///// 只调用一次暂时不放在初始化方法里
//- (void)configUIWithBannedSize:(CQBannedSize)bannedSize;

@end

NS_ASSUME_NONNULL_END
