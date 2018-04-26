//
//  CJAlertActionModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAlertActionModel : NSObject {
    
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(UIAlertAction *action);
@property (nonatomic, copy) void (^alertHandler)(CJAlertActionModel *action);

@end
