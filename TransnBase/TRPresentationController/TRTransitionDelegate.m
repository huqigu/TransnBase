//
//  TRTransitionDelegate.m
//  TRKit
//
//  Created by 姜政 on 2021/8/26.
//

#import "TRTransitionDelegate.h"
@implementation TRTransitionDelegate



+ (instancetype)sharedTransition
{
    static TRTransitionDelegate *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[[self class] alloc] init];
    });
    return _instace;
}

#pragma mark - UIViewControllerTransitioningDelegate
//设置继承自UIPresentationController 的自定义类的属性
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return [[TRPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

//控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //创建实现UIViewControllerAnimatedTransitioning协议的类（命名为AnimatedTransitioning）
    TRAnimatedTransition *animatedTransition = [[TRAnimatedTransition alloc] init];
    animatedTransition.animateStyle = self.animateStyle;
      //将其状态改为出现
    animatedTransition.presented  = YES;
    return animatedTransition;
}

//控制器销毁执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    ////创建实现UIViewControllerAnimatedTransitioning协议的类（命名为AnimatedTransitioning）\    TRAnimatedTransition *animatedTransition = [[TRAnimatedTransition alloc] init];
    TRAnimatedTransition *animatedTransition = [[TRAnimatedTransition alloc] init];
    animatedTransition.animateStyle = self.animateStyle;
     //将其状态改为消失
    animatedTransition.presented = NO;
    return animatedTransition;
}
@end
