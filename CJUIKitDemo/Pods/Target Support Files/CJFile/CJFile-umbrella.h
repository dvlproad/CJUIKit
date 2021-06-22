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

#import "CJFileManager+CalculateFileSize.h"
#import "CJFileManager+DeleteCleanFile.h"
#import "CJFileManager+GetCreatePath.h"
#import "CJFileManager+SaveFileData.h"
#import "CJFileManager.h"
#import "CJPathFileModel.h"

FOUNDATION_EXPORT double CJFileVersionNumber;
FOUNDATION_EXPORT const unsigned char CJFileVersionString[];

