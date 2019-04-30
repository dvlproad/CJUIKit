//
//  NSObject+SearchProperty.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSObject+SearchProperty.h"

static NSString * const isSearchResultKey = @"isSearchResultKey";
static NSString * const isContainInSelfKey = @"isContainInSelfKey";
static NSString * const isContainInMembersKey = @"isContainInMembersKey";
static NSString * const containMembersKey = @"containMembersKey";

@implementation NSObject (Search)

#pragma mark - runtime

//isSearchResult
- (BOOL)isSearchResult {
    return [objc_getAssociatedObject(self, &isSearchResultKey) boolValue];
}

- (void)setIsSearchResult:(BOOL)isSearchResult {
    return objc_setAssociatedObject(self, &isSearchResultKey, @(isSearchResult), OBJC_ASSOCIATION_ASSIGN);
}

//isContainInSelf
- (BOOL)isContainInSelf {
    return [objc_getAssociatedObject(self, &isContainInSelfKey) boolValue];
}

- (void)setIsContainInSelf:(BOOL)isContainInSelf {
    return objc_setAssociatedObject(self, &isContainInSelfKey, @(isContainInSelf), OBJC_ASSOCIATION_ASSIGN);
}

//isContainInMembers
- (BOOL)isContainInMembers {
    return [objc_getAssociatedObject(self, &isContainInMembersKey) boolValue];
}

- (void)setIsContainInMembers:(BOOL)isContainInMembers {
    return objc_setAssociatedObject(self, &isContainInMembersKey, @(isContainInMembers), OBJC_ASSOCIATION_ASSIGN);
}

//containMembers
- (NSMutableArray *)containMembers {
    return objc_getAssociatedObject(self, &containMembersKey);
}

- (void)setContainMembers:(NSMutableArray *)containMembers {
    return objc_setAssociatedObject(self, &containMembersKey, containMembers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
