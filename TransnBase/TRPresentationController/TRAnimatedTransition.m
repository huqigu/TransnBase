//
//  TRAnimatedTransition.m
//  TRKit
//
//  Created by 姜政 on 2021/8/26.
//

#import "TRAnimatedTransition.h"

@implementation TRAnimatedTransition

-(instancetype)init{
    if (self = [super init]) {
        _duration = 0.35;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    //动画执行时间
    return self.duration;
}

//实际动画效果（以后需要改的地方只有这里）
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.presented) {//创建控制器
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame = [UIScreen mainScreen].bounds;
        __block CGRect rect = toView.frame;
        if (self.animateStyle == TRAnimatedTransitionScale){
            toView.alpha = 0;
            toView.transform = CGAffineTransformMakeScale(0, 0);
        }else if(self.animateStyle == TRAnimatedTransitionPush){
            rect.origin.x = rect.size.width;
            toView.frame = rect;
        }else{
            rect.origin.y = rect.size.height;
            toView.frame = rect;
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if (self.animateStyle == TRAnimatedTransitionScale){
                toView.alpha = 1;
                toView.transform = CGAffineTransformIdentity;//2D动画
            }else if(self.animateStyle == TRAnimatedTransitionPush){
                rect.origin.x = 0;//注意同PresentationController设置的尺寸位置相关
                toView.frame = rect;
            }else{
                rect.origin.y = 0;
                toView.frame = rect;
            }
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{//销毁控制器
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        __block CGRect rect = fromView.frame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if (self.animateStyle == TRAnimatedTransitionScale){
                fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            }else if(self.animateStyle == TRAnimatedTransitionPush){
                rect.origin.x = rect.size.width;
                fromView.frame = rect;
            }else{
                rect.origin.y = rect.size.height;
                fromView.frame = rect;
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
