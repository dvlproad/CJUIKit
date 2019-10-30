//
//  NSString+CJCut.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJCut.h"

@implementation NSString (CJCut)

- (NSArray<NSString *> *)removeSeprateCharacterWithStart:(NSString *)startCharacter
                                                     end:(NSString *)endCharacter
{
    
    
    NSArray<NSString *> *tempArray1 = [self componentsSeparatedByString:startCharacter];
    if (tempArray1.count <= 1) {
        return @[self];
    }
    
    NSString *string1 = @"";
    NSString *string2 = @"";
    NSString *string3 = @"";
    string1 = tempArray1[0];
    
    string2 = tempArray1[1];
    NSArray<NSString *> *tempArray2 = [string2 componentsSeparatedByString:endCharacter];
    if (tempArray2.count > 1) {
        string2 = tempArray2[0];
    
        string3 = tempArray2[1];
    }
    //NSLog(@"string1 = %@, string2 = %@, string3 = %@", string1, string2, string3);
    
    return @[string1, string2, string3];
}

@end
