//
//  TRPresentationController.m
//  Pods-TRKit_Example
//
//  Created by 姜政 on 2021/8/26.
//

#import "TRPresentationController.h"

@implementation TRPresentationController

-(UIVisualEffectView *)visualView{
    if (!_visualView) {
        //使用UIVisualEffectView实现模糊效果
        UIBlurEffect *blur  = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
        _visualView.alpha = 0.0;
        _visualView.backgroundColor  = [UIColor blackColor];
    }
    return _visualView;
}

//presentationTransitionWillBegin 是在呈现过渡即将开始的时候被调用的。我们在这个方法中把
- (void) presentationTransitionWillBegin
{
    
 
    self.visualView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.visualView];

    //一旦要自定义动画，必须自己手动添加控制器
    //设置尺寸(在动画中注意调整尺寸)
//    self.presentedView.frame = CGRectInset(self.containerView.bounds, 40, 60);
//     添加到containerView 上
    [self.containerView addSubview:self.presentedView];
    
    // 与过渡效果一起执行背景 View 的淡入效果
    __weak typeof(self) weakSelf = self;
    [[self.presentingViewController transitionCoordinator] animateAlongsideTransitionInView:_visualView  animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        weakSelf.visualView.alpha = 0.4;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}


//presentationTransitionDidEnd: 是在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成。在我们的例子中，我们可以使用它在过渡效果已结束但没有完成时移除半透明的黑色背景 View。
-(void)presentationTransitionDidEnd:(BOOL)completed {
    
    // 如果呈现没有完成，那就移除背景 View
    __weak typeof(self) weakSelf = self;
    if (!completed) {
        [weakSelf.visualView removeFromSuperview];
        
    }
    
}


//以上就涵盖了我们的背景 View 的呈现部分，我们现在需要给它添加淡出动画并且在它消失后移除它。正如你预料的那样，dismissalTransitionWillBegin 正是我们把它的 alpha 重新设回0的地方。
-(void)dismissalTransitionWillBegin {
    __weak typeof(self) weakSelf = self;
    [[self.presentingViewController transitionCoordinator] animateAlongsideTransitionInView:_visualView animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.visualView.alpha = 0.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
    
}


//我们还需要在消失完成后移除背景 View。做法与上面 presentationTransitionDidEnd: 类似，我们重载 dismissalTransitionDidEnd: 方法
-(void)dismissalTransitionDidEnd:(BOOL)completed{
    
    
    if (completed) {
        [self.visualView removeFromSuperview];
    }
}


//还有最后一个方法需要重载。在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，而是很小的一个矩形。被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
- (CGRect)frameOfPresentedViewInContainerView
{
    
//    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
//
//    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;
//
//    self.presentedView.frame = CGRectMake(0, windowH - 300, windowW, 300);
    return self.presentedView.frame;
}

@end
