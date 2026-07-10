#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSString+CJAttributedString.h"
#import "NSString+CJCategory.h"
#import "NSString+CJCut.h"
#import "NSString+CJEncoding.h"
#import "NSString+CJEncryption.h"
#import "NSString+CJTextSize.h"
#import "NSString+CJValidate.h"

FOUNDATION_EXPORT double CJFoundationVersionNumber;
FOUNDATION_EXPORT const unsigned char CJFoundationVersionString[];

