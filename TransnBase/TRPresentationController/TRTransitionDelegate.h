//
//  TRTransitionDelegate.h
//  TRKit
//
//  Created by 姜政 on 2021/8/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRAnimatedTransition.h"
#import "TRPresentationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TRTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

///这个必须是单例
+ (instancetype)sharedTransition;
@property(nonatomic)TRAnimatedTransitionStyle animateStyle;
@end

NS_ASSUME_NONNULL_END
