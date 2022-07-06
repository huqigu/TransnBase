//
//  TPConfig.h
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TPConstants.h"

typedef void (^ TPUserBlock) (NSString *userId, NSString *token,  NSString*errMsg,int code);


@interface TPConfig : NSObject
+(instancetype)sharedManager;
///当前用户
///webview的缓存
@property(nonatomic,strong)NSMutableDictionary *webViewCacheDic;



///刷新用户token
@property (nonatomic, copy) void(^didRefreshUser)(TPUserBlock userBlock);

@property (nonatomic, copy) void(^didInvalidLogin)(void);

@property (nonatomic, copy) void(^didLogin)(void);

///需要添加，sdk内部未实现下拉刷新( ps 只需要加载更多的功能)
@property (nonatomic, copy) void(^addRefreshEventHandler)(UIScrollView *scrollView,id target,SEL headerAction,SEL footerAction);

@end

