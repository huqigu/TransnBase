//
//  UIViewController+TRPresentation.h
//  TRKit
//
//  Created by 姜政 on 2021/8/27.
//

#import <UIKit/UIKit.h>
#import "TRTransitionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TRPresentation)
-(void)trPresentViewController:(UIViewController *)viewController animateStyle:(TRAnimatedTransitionStyle)animateStyle animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
