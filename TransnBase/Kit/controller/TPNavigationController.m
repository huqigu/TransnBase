//
//  TPNavigationController.m
//  CPPCC
//
//  Created by 姜政 on 2020/6/15.
//  Copyright © 2020 Shunyi CPPCC. All rights reserved.
//

#import "TPNavigationController.h"

@interface TPNavigationController ()

@end

@implementation TPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationFullScreen;
}
-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.rt_topViewController;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    @try
    {
        if (self.rt_viewControllers.count==0&&![viewController isKindOfClass:[UITabBarController  class]]) {
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }
        if ([viewController respondsToSelector:NSSelectorFromString(@"notSupportedRepeatedPush")]) {
            if ([viewController.class isEqual:self.rt_topViewController.class]) {
                return;
            }
        }
        [super pushViewController:viewController animated:animated];
    }
    @catch (NSException *e)
    {
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
