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

#import "ZQShareCode.h"
#import "NSObject+ZQAdd.h"
#import "NSString+ZQSafe.h"
#import "NSTimer+ZQBlock.h"
#import "UIView+ZQExten.h"
#import "ZQMacros.h"
#import "ZQSingleton.h"

FOUNDATION_EXPORT double ZQFoundationVersionNumber;
FOUNDATION_EXPORT const unsigned char ZQFoundationVersionString[];

