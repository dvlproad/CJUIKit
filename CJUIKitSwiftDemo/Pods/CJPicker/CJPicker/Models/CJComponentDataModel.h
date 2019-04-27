//
//  CJComponentDataModel.h
//  AllScrollViewDemo
//
//  Created by dvlproad on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDataModelSample.h"

/**
 *  类似于CJSectionDataModel（不同的是这边是按component）
 */
@interface CJComponentDataModel : NSObject {
    
}
@property (nonatomic, assign) NSInteger componentIndex; /**< 这是第几个component */
@property (nonatomic, assign) NSInteger type;           /**< section的类型 */
@property (nonatomic, copy) NSString *theme;            /**< section的名字 */
@property (nonatomic, strong) NSMutableArray *values;   /**< section的数据 */


@property (nonatomic, strong) CJDataModelSample *selectedDataModel;
@property (nonatomic, assign) NSInteger selectedIndex;


@property(nonatomic, copy) NSString *dataModelTextKey;
@property(nonatomic, copy) NSString *dataModelMembersKey;


@end
