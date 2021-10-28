//
//  NSObject+CJSearchProperty.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSObject+CJSearchProperty.h"

static NSString * const isSearchResultKey = @"isSearchResultKey";
static NSString * const isContainInSelfKey = @"isContainInSelfKey";
static NSString * const isContainInMembersKey = @"isContainInMembersKey";
static NSString * const containMembersKey = @"containMembersKey";

@implementation NSObject (Search)

#pragma mark - runtime

//isSearchResult
- (BOOL)cj_isSearchResult {
    return [objc_getAssociatedObject(self, &isSearchResultKey) boolValue];
}

- (void)setCj_isSearchResult:(BOOL)cj_isSearchResult {
    return objc_setAssociatedObject(self, &isSearchResultKey, @(cj_isSearchResult), OBJC_ASSOCIATION_ASSIGN);
}

//isContainInSelf
- (BOOL)cj_isContainInSelf {
    return [objc_getAssociatedObject(self, &isContainInSelfKey) boolValue];
}

- (void)setCj_isContainInSelf:(BOOL)cj_isContainInSelf {
    return objc_setAssociatedObject(self, &isContainInSelfKey, @(cj_isContainInSelf), OBJC_ASSOCIATION_ASSIGN);
}

//isContainInMembers
- (BOOL)cj_isContainInMembers {
    return [objc_getAssociatedObject(self, &isContainInMembersKey) boolValue];
}

- (void)setCj_isContainInMembers:(BOOL)cj_isContainInMembers {
    return objc_setAssociatedObject(self, &isContainInMembersKey, @(cj_isContainInMembers), OBJC_ASSOCIATION_ASSIGN);
}

//containMembers
- (NSMutableArray *)cj_containMembers {
    return objc_getAssociatedObject(self, &containMembersKey);
}

- (void)setCj_containMembers:(NSMutableArray *)cj_containMembers {
    return objc_setAssociatedObject(self, &containMembersKey, cj_containMembers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
