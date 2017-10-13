//
//  ModuleModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModuleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) Class classEntry;

//@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

@end
