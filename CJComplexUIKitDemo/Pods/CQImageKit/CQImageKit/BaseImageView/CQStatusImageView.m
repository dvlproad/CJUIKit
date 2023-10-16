//
//  CQStatusImageView.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQStatusImageView.h"
#import "UIImageView+CQBaseUtil.h"
#import "UIView+CQOverlayImageBanned.h"

@interface CQStatusImageView () {
    
}

@end



@implementation CQStatusImageView

#pragma mark - Init
/*
 *  初始化
 *
 *  @param bannedSize        被禁类型的大小
 *
 *  @return imageView
 */
- (instancetype)initWithBannedSize:(CQBannedSize)bannedSize {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self cq_configUIWithBannedSize:bannedSize];
    }
    return self;
}


#pragma mark - Update UI
/*
 *  更新被禁时候的违规标记视图的有、无及大小等
 *
 *  @param bannedSize        被禁类型的大小
 */
- (void)updateBannedSize:(CQBannedSize)bannedSize {
    [self cq_configUIWithBannedSize:bannedSize];
}

#pragma mark - Update Data
/*
 *  更新图片视图的数据和状态信息
 *
 *  @param imageModel       图片的信息（含网络地址、违规状态）
 *  @param imageUseType     图片的使用场景类型(常见于cell中)
 */
- (void)updateImageWithNetImageModel:(CQStatusImageModel *)imageModel imageUseType:(CQImageUseType)imageUseType {
    NSString *imageUrl = imageModel.imageUrl;           // 图片的网络地址
    CQImageStatus imageStatus = imageModel.imageStatus; // 图片的违规状态

    [self cq_updateImageStatus:imageStatus];
    [self cq_setImageWithUrl:imageUrl
                 imageStatus:imageStatus
                imageUseType:imageUseType
                    dealType:CQImageViewDealTypeDefault
                   completed:nil];
}

- (void)updateImage:(nullable UIImage *)image imageStatus:(CQImageStatus)imageStatus {
    [self cq_updateImageStatus:imageStatus];
    
    if (imageStatus == CQImageStatusBanned) {   // 如果是banned掉的就不要去使用之前图片了，即使加载得到
        [self _onlyUpdateImage:[UIImage imageNamed:@"img_error_default"]];
    } else {
        [self _onlyUpdateImage:image];
    }
}

#pragma mark - Private Method
/// 只更新图片，不更新状态（防止状态出错，只使用在子类中，其他方法不使用）
- (void)_onlyUpdateImage:(nullable UIImage *)image {
    if (image == nil) {    // 如果获取图片失败，则显示默认的失败图片
        UIImage *errorImage = [UIImage imageNamed:@"img_error_default"];
        image = errorImage;
    }
    self.image = image;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
