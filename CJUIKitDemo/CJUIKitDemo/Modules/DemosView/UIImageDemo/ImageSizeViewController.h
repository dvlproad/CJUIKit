//
//  ImageSizeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  图片压缩示例,可参考[iOS 图片压缩限制大小最优解](https://www.jianshu.com/p/99c3e6a6c033)

#import "CJUIKitBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageSizeViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) IBOutlet UIImageView *imageView1_old;
@property (nonatomic, strong) IBOutlet UIImageView *imageView1_new;
@property (nonatomic, strong) IBOutlet UILabel *pathLabel1;

@end

NS_ASSUME_NONNULL_END
