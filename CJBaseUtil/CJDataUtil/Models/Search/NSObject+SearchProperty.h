//
//  NSObject+SearchProperty.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Search)

@property (nonatomic, assign) BOOL isSearchResult;  /**< 是否是搜索出来 */
@property (nonatomic, assign) BOOL isContainInSelf; /**< 搜索的字符串在本身包含 */
@property (nonatomic, assign) BOOL isContainInMembers;/**< 搜索的字符串在本身的成员中包含(如果有成员) */
@property (nonatomic, assign) NSMutableArray *containMembers;/**< 包含的内容 */

//@property (nonatomic, assign) NSMutableArray *comeFrom;/**< 包含的内容 */

@end
