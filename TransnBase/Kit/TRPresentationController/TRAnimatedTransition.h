//
//  TRAnimatedTransition.h
//  TRKit
//
//  Created by 姜政 on 2021/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TRAnimatedTransitionPresented,
    TRAnimatedTransitionScale,
    TRAnimatedTransitionPush,
} TRAnimatedTransitionStyle;

@interface TRAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
// 用于记录控制器是创建还是销毁
@property (nonatomic, assign) BOOL          presented;
@property (nonatomic, assign) TRAnimatedTransitionStyle   animateStyle;
@property (nonatomic, assign) NSTimeInterval   duration;

@end

NS_ASSUME_NONNULL_END
