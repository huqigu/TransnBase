//
//  UIViewController+TRPresentation.m
//  TRKit
//
//  Created by 姜政 on 2021/8/27.
//

#import "UIViewController+TRPresentation.h"

@implementation UIViewController (TRPresentation)
-(void)trPresentViewController:(UIViewController *)viewController animateStyle:(TRAnimatedTransitionStyle)animateStyle animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion{
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [TRTransitionDelegate sharedTransition].animateStyle = animateStyle;
    viewController.transitioningDelegate = [TRTransitionDelegate sharedTransition];
    if (self.presentedViewController && [self.presentingViewController respondsToSelector:NSSelectorFromString(@"NoneAutoDiss")]) {
        __weak typeof(self) weakSelf = self;
        [self dismissViewControllerAnimated:false completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf presentViewController:viewController animated:animated completion:completion];
        }];
    }else{
        [self presentViewController:viewController animated:animated completion:completion];
    }
}

@end
