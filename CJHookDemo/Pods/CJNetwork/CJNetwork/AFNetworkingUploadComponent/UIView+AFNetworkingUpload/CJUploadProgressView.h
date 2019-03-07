//
//  CJUploadProgressView.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/8/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  图片等上传时候，为了显示进度而添加的视图
 */
@interface CJUploadProgressView : UIView {
    
}
@property (nonatomic, copy) void(^cjReUploadHandle)(UIView *uploadProgressView);


/**
 *  更新上传状态的提示文字和进度
 *
 *  @param progressText     该上传状态的提示文字
 *  @param progressValue    该上传状态的进度值[0-100]
 */
- (void)updateProgressText:(NSString *)progressText progressVaule:(CGFloat)progressValue;

@end
