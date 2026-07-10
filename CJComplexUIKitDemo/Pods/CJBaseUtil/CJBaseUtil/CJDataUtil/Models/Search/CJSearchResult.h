//
//  CJSearchResult.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJSearchResult : NSObject

@property (nonatomic, strong) NSMutableArray *selfs;    /**< 在本身中搜索的结果 */
@property (nonatomic, strong) NSMutableArray *members;  /**< 在成员中搜索的结果 */

@end
