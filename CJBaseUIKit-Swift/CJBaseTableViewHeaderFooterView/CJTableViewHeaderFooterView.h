//
//  CJTableViewHeaderFooterView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSInteger belongToSection;    /**< 当前header或footer属于哪个section下 */
@property (nonatomic, copy) void (^tapHandle)(NSInteger section);   /**< 当前视图的点击 */

@end
