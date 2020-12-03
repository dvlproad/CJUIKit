//
//  UIScrollView+CJTouch.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/12/4.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UIScrollView+CJTouch.h"

@implementation UIScrollView (CJTouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end
