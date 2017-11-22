//
//  CJSectionDataModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJSectionDataModel : NSObject<NSCopying, NSMutableCopying> {
    
}
@property (nonatomic, assign) NSInteger type;           /**< section的类型 */
@property (nonatomic, copy) NSString *theme;            /**< section的名字 */
@property (nonatomic, strong) NSMutableArray *values;   /**< section的数据 */

@property (nonatomic, assign, getter=isSelected) BOOL selected;  /**< section是否选中 */ //比较少用，常用比如打开section

@end
