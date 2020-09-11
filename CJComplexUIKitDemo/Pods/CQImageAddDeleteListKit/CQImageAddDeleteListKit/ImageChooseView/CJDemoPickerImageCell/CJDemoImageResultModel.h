//
//  CJDemoImageResultModel.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJDemoImageResultModel : NSObject

@property (nonatomic, assign) BOOL success;           /**< 是否识别成功 */
@property (nonatomic, assign) NSString *resultString; /**< 识别的结果文字 */
//@property (nonatomic, assign, readonly) UIImage *resultImage;   /**< 识别的结果图片 */

@end
