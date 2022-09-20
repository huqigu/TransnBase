//
//  TPBaseViewController.m
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import "TPBaseViewController.h"
#import "RCDCommonDefine.h"
#import "UIView+TRExtension.h"
#import "TPProgressHUD.h"
#import "TPConfig.h"
#import "RCDUIBarButtonItem.h"

#import "TransnKitReasource.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>
//#import <RTRootNavigationController/RTRootNavigationController.h>
//#import "TPConfig.h"
@interface TPBaseViewController (){
    TPProgressHUD *hud;
}

@end

@implementation TPBaseViewController
#pragma mark getter
 
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
//    return UIStatusBarStyleDefault;
}

-(TPBaseAgent *)agent{
    if (!_agent) {
        if (self.agentClass) {
           _agent = [self.agentClass new];
        }else{
            _agent = [TPBaseAgent new];
        }
    }
    return _agent;
}

-(TPBaseViewModel *)viewModel{
    if (!_viewModel) {
        if (self.viewModelClass) {
           _viewModel = [self.viewModelClass new];
        }else{
            _viewModel = [[TPBaseViewModel alloc] init];
        }
    }
    return _viewModel;
}
-(BOOL)requestDataWhenAppears{
    return YES;
}
-(BOOL)interactivePopGesture{
    return YES;
}

-(TPNoneDataView *)noneDataView{
    if (!_noneDataView) {
        _noneDataView = [[TPNoneDataView alloc] init];
        __weak typeof(self) weakSelf = self;
        _noneDataView.refreshBlock = ^(id  _Nonnull data) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf refreshView];
        };
    }
    return _noneDataView;
}
-(UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationFullScreen;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotifications];
    // Do any additional setup after loading the view.
    [self commitUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateNavigationItems];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.requestDataWhenAppears) {
        if (!self.viewModel.isDataReturn) {
            [self requestData];
        }
    }
    [[ALBBMANPageHitHelper getInstance] pageAppear:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ALBBMANPageHitHelper getInstance] pageDisAppear:self];
}
-(UIFont *)navFont{
    if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
        return DEF_BFONT(16);
    }else {
        ///黑色状态栏+白色导航栏+深色标题
        return  DEF_NoneAutoFONT(16);
    }
}
-(UIColor *)navColor{
    if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
        return  APP_NAV_Color;
    }else {
        ///黑色状态栏+白色导航栏+深色标题
        return   [UIColor whiteColor];
    }
}


-(void)commitUI{
    self.rt_disableInteractivePop = FALSE;
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    if (self.navigationController) {
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        UIFont *font = self.navFont;
        UIColor *titleColor;
        UIColor *navColor = self.navColor;
        UIImage *tmpImage;
        if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
            titleColor = [UIColor whiteColor];
            tmpImage = [TransnKitReasource imageNamed:@"navigator_btn_back"];
        }else if(self.preferredStatusBarStyle == UIStatusBarStyleDefault){
            ///黑色状态栏+白色导航栏+深色标题
            titleColor = [UIColor blackColor];
            tmpImage = [TransnKitReasource imageNamed:@"nav_icon_back_black"];
        }
        
        
        NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName :titleColor};
        NSDictionary *textAttributes2 = @{NSFontAttributeName : DEF_NoneAutoFONT(16), NSForegroundColorAttributeName :titleColor};

        ///白色状态栏+深色导航栏+白色标题
        if (@available(iOS 15.0, *)) {
               UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
               barApp.backgroundColor = navColor;
               barApp.shadowColor = navColor;
               barApp.titleTextAttributes = textAttributes;
                navigationBar.scrollEdgeAppearance = barApp;
                navigationBar.standardAppearance = barApp;
        }else{
            [navigationBar setTitleTextAttributes:textAttributes];
            UIImage *image = [[TransnKitReasource imageNamed:@"square_bg_nav"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [navigationBar setBarTintColor:titleColor];
            [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            [navigationBar setTintColor:navColor];
        }
        
        CGSize newSize = CGSizeMake(10, 17);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0f);
        [tmpImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *backButtonImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       
        [navigationBar setBackIndicatorImage:backButtonImage];
        [navigationBar setBackIndicatorTransitionMaskImage:backButtonImage];
        navigationBar.translucent = NO;
        
        UIBarButtonItem *tzBarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self.navigationController class]]];
        tzBarItem.tintColor = [UIColor whiteColor];
        [tzBarItem setTitleTextAttributes:textAttributes2 forState:UIControlStateNormal];
        [tzBarItem setBackButtonTitlePositionAdjustment:UIOffsetMake(2, 1)
                                                               forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
   
}




- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIImage *image = [[TransnKitReasource imageNamed:@"navigator_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIColor *color = self.preferredStatusBarStyle == UIStatusBarStyleLightContent?[UIColor whiteColor]:UIColorFromRGB(0x666666);
    
    return [[RCDUIBarButtonItem alloc] initContainImage:image imageViewFrame:CGRectMake(10, 3, 10, 17) buttonTitle:nil  titleColor:color titleFrame:CGRectZero buttonFrame:CGRectMake(-10, 0, 95, 23) target:self action:@selector(popBack:)];

}
-(void)updateNavigationItems{

}

-(void)addEdgeInset:(UIEdgeInsets)inset subView:(UIView *)subView{
    [self.view addEdgeInset:inset subView:subView];
}
-(void)requestData{
    
}
-(void)addNotifications{
    
}

/*
 self.navigationItem.title = @"my title"; sets navigation bar title.
 self.tabBarItem.title = @"my title"; sets tab bar title.
 self.title = @"my title"; sets both of these.
 */
-(void)setTitle:(NSString *)title{
    self.navigationItem.title = title;
}


-(void)refreshView{
    if (self.viewModel.state == TPViewModelSateRequest)return;
     [self.viewModel clearData];
     [self requestData];
}
-(void)reloadData{
    
}
-(void)configRefresh:(UIScrollView *)srcollView{
    SEL headerAction =@selector(refresh);
    BOOL hasMore =[(TPBaseViewModel *)self.viewModel hasMore];
    SEL footerAction = hasMore?@selector(loadMore):nil;
    if ([TPConfig sharedManager].addRefreshEventHandler) {
        [TPConfig sharedManager].addRefreshEventHandler(srcollView,self,headerAction, footerAction);
    }
}

-(void)refresh{
    self.viewModel.pageModel.curr = 1;
    TPBaseRequestEntity * requestEntity = (TPBaseRequestEntity *)[(TPBaseViewModel *)self.viewModel requestEntity];
    [requestEntity setPageModel:self.viewModel.pageModel];
    [self requestData];
}
-(void)loadMore{
    OMPageModel *pageModel =  [self.viewModel.pageModel increaseCopyOne];
    TPBaseRequestEntity * requestEntity = (TPBaseRequestEntity *)[(TPBaseViewModel *)self.viewModel requestEntity];
    [requestEntity setPageModel:pageModel];
    [self requestData];
}
-(IBAction)popBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if (self.presentedViewController == viewControllerToPresent) return;
    if (self.presentedViewController && [self.presentingViewController respondsToSelector:NSSelectorFromString(@"NoneAutoDiss")]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [super presentViewController:viewControllerToPresent animated:flag completion:completion];
        }];
    }else {
        [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}
-(void)showHUD:(nullable NSString *)text{
    hud = [TPProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
    [hud showAnimated:YES];
}
-(void)showAnnularDeterminateHud:(nullable NSString *)text{
    hud = [TPProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = TPProgressHUDModeAnnularDeterminate;
    hud.tintColor = APP_Color;
    hud.label.text = text;
    hud.progress = 0;
}
-(void)updateHudProgress:(float)progress{
    hud.progress = progress;
}
-(void)updateHUD:(nullable NSString *)text{
    hud.label.text = text;
}
-(void)dismissHUD{
    [hud hideAnimated:YES];
}

-(void)styleOfRequestData{
    [self.view addSubview:self.noneDataView];
}
-(void)requestDataFailed{
    [self.view addSubview:self.noneDataView];
    self.noneDataView.frame = self.view.bounds;
     self.viewModel.state = TPViewModelSateNetError;
    self.noneDataView.state = self.viewModel.state;
}
-(void)requestDataSuccess{
    self.noneDataView.state = self.viewModel.state;
    [self.noneDataView removeFromSuperview];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
