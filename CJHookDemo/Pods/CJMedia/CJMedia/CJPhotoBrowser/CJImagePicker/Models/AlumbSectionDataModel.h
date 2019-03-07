//
//  AlumbSectionDataModel.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlumbSectionDataModel : NSObject

@property (nonatomic, assign) NSInteger type;           /**< section的类型 */
@property (nonatomic, copy) NSString *theme;            /**< section的名字 */
@property (nonatomic, strong) NSMutableArray *values;   /**< section的数据 */

@property (nonatomic, assign, getter=isSelected) BOOL selected;  /**< section是否选中 */ //比较少用，常用比如打开section

@end
