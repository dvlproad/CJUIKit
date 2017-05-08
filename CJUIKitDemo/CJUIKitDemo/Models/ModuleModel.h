//
//  ModuleModel.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/4/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleModel : NSObject

@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) Class classEntry;

//@property (nonatomic, assign) NSInteger unReadNumber;   /**< 未读消息数 */

@end
