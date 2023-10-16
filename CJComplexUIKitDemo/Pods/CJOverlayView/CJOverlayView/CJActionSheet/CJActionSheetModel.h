//
//  CJActionSheetModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetModel : NSObject {
    
}
@property (nonatomic, assign) BOOL isDangerOperation;   /**< 是否是危险操作(UI文字颜色等会不一样，默认NO) */
@property (nullable, nonatomic, strong) UIImage *image;
@property (nonnull, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *subTitle;

@end

NS_ASSUME_NONNULL_END
