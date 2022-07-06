//
//  TRConstants.h
//  woordee
//
//  Created by 姜政 on 2021/12/24.
//  Copyright © 2021 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *TPUserConstants NS_TYPED_ENUM;

extern TPUserConstants const TPUserInvalidLogin;  //登录信息失效
extern TPUserConstants const TPUserUserName;  //用户名
extern TPUserConstants const TPUserPassword;  //密码
NS_ASSUME_NONNULL_BEGIN

@interface TPConstants : NSObject

@end

NS_ASSUME_NONNULL_END
