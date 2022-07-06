//
//  TPNoneDataView.h
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPNoneDataView : UIView

@property (strong, nonatomic) UILabel *contentL;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UIButton *actionButton;
@property (strong, nonatomic) UIImageView *imageV;

@property(nonatomic,copy,nullable)NSString *errorTip;
@property(nonatomic,copy,nullable)NSString *noneDataTip;

@property (nonatomic, copy) void(^refreshBlock)(id data);

@property(nonatomic)TPViewModelSate state;

@end

NS_ASSUME_NONNULL_END
