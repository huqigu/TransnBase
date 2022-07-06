//
//  TPNoneDataView.m
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import "TPNoneDataView.h"
#import "RCDCommonDefine.h"
#import "TransnKitReasource.h"
#import <Masonry/Masonry.h>
@implementation TPNoneDataView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.state = TPViewModelSateRequest;
        
        [self commitUI];
    }
    return self;
}

- (void)commitUI {
    [self addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-120);
        make.width.height.offset(80);
    }];
    
    [self addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.imageV.mas_bottom).offset(23);
    }];
    
    [self addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(140);
        make.height.offset(40);
        make.centerX.offset(0);
        make.top.equalTo(self.contentL.mas_bottom).offset(32);
    }];
    
    [self addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

#pragma mark - Getter Methods
- (UILabel *)contentL {
    if (!_contentL) {
        _contentL = [[UILabel alloc] init];
        _contentL.textColor = RGBA(170, 170, 170, 1);
        _contentL.font = DEF_FONT(14);
    }
    return _contentL;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] init];
    }
    return _activityView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitle:TRString(@"刷新") forState:0];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:0];
        [_actionButton.titleLabel setFont:DEF_FONT(14)];
        [_actionButton setBackgroundColor:APP_Color];
        [_actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _actionButton.layer.cornerRadius = 20;
    }
    return _actionButton;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithImage:[TransnKitReasource imageNamed:@"easy_task_kt"]];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
}

#pragma mark - Setter Methods
-(void)setState:(TPViewModelSate)state{
    _state = state;
    if (TPViewModelSateRequest == state) {
        [self.activityView startAnimating];
        self.contentL.hidden = YES;
        self.actionButton.hidden = YES;
        self.imageV.hidden = YES;
        
    }else if(TPViewModelSateNoneData == state|| TPViewModelSateDataReturn ==state){
        [self.activityView stopAnimating];
        self.contentL.hidden = NO;
        self.actionButton.hidden = YES;
        self.imageV.hidden = NO;
        self.imageV.image = [TransnKitReasource imageNamed:@"easy_task_kt"];
        self.contentL.text = self.noneDataTip?:TRString(@"没有数据");
    }else if(TPViewModelSateNetError == state){
        [self.activityView stopAnimating];
        self.contentL.hidden = NO;
        self.actionButton.hidden = NO;
        self.imageV.hidden = NO;
        self.imageV.image = [TransnKitReasource imageNamed:@"common_noneNet"];
        self.contentL.text = self.errorTip?:TRString(@"网络开小差了 T^T");
        [self.actionButton setTitle:TRString(@"刷新") forState:0];
        [self.actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(IBAction)actionButtonClick:(id)sender{
    if (self.refreshBlock) {
        self.refreshBlock(@1);
    }
}
@end
