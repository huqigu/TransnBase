//
//  WDViewController.m
//  TransnBase
//
//  Created by huqigu on 07/06/2022.
//  Copyright (c) 2022 huqigu. All rights reserved.
//

#import "WDViewController.h"
#import "WDHomeVC.h"
@interface WDViewController ()

@end

@implementation WDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.backgroundColor = [UIColor redColor];
    pushBtn.frame = CGRectMake(100, 100, 100, 100);
    [pushBtn addTarget:self action:@selector(clickPushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}

- (void)clickPushBtn {
    WDHomeVC *homeVC = [[WDHomeVC alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
    
//    [self showToast:@"我的tosat"];
    
//    [self showHUD:nil];
}

@end
