//
//  UINavigationBar+Color.h
//  iOS-NavigationBar-Category
//
//  Created by 雷亮 on 16/7/29.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef LEOSYNTH_DYNAMIC_PROPERTY_OBJECT
#define LEOSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_:(_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
\
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

@interface UINavigationBar (leoAdd)

/**
 * @param color: 背景色
 */
- (void)leo_setBackgroundColor:(UIColor *)color;

/**
 * 移除navigationBar底部的横线
 */
- (void)leo_removeUnderline;

@end
