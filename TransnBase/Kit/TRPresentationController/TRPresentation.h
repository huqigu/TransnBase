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

#import "TRAnimatedTransition.h"
#import "TRPresentationController.h"
#import "TRTransitionDelegate.h"
#import "UIViewController+TRPresentation.h"

FOUNDATION_EXPORT double TRPresentationControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char TRPresentationControllerVersionString[];

