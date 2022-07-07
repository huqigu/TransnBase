//
//  TPBaseViewController.h
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPBaseViewModel.h"
#import "TPNoneDataView.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "TPBaseAgent.h"
//#import "TPUserInfo.h"
#import "RCDCommonDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPBaseViewController : UIViewController

//@property(nonatomic,strong)TPUserInfo *userInfo;
@property (nonatomic,strong)Class viewModelClass;
@property(nonatomic,strong)TPBaseViewModel *viewModel;
@property (nonatomic,strong)Class agentClass;
@property(nonatomic,strong)TPBaseAgent *agent;

@property(nonatomic,strong)TPNoneDataView *noneDataView;

/// default is YES
@property (nonatomic)BOOL requestDataWhenAppears;

@property (nonatomic,strong)UIFont *navFont;
@property (nonatomic,strong)UIColor *navColor;
/// default is YES
@property (nonatomic)BOOL interactivePopGesture;
@property (nonatomic, copy) void(^actionBlock)(id data);//事件回调

-(void)commitUI;
-(void)addNotifications;
-(void)requestData;
///刷新视图和数据
-(void)reloadData;
///手动刷新
-(void)refreshView;

///配置下拉刷新
-(void)configRefresh:(UIScrollView *)srcollView;
///下拉刷新
-(void)refresh;
///上拉加载
-(void)loadMore;

///咪咕那边需要放到viewwillappear里面刷新
-(void)updateNavigationItems;
-(void)addEdgeInset:(UIEdgeInsets)inset subView:(UIView *)subView;

-(IBAction)popBack:(nullable id)sender;


-(void)showHUD:(nullable NSString *)text;
-(void)updateHUD:(nullable NSString *)text;
-(void)showAnnularDeterminateHud:(nullable NSString *)text;
-(void)updateHudProgress:(float)progress;

-(void)dismissHUD;


-(void)styleOfRequestData;
-(void)requestDataFailed;
-(void)requestDataSuccess;

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
