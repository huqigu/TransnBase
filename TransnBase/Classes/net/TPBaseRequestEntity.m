//
//  TPBaseRequestEntity.m
//  Transn
//
//  Created by 姜政 on 2020/3/10.
//  Copyright © 2020年 Transn. All rights reserved.
//
#import "TPBaseRequestEntity.h"
#import "TPConstants.h"

@implementation TPBaseRequestEntity

-(NSString *)userId{
         NSString *trId = [[NSUserDefaults standardUserDefaults] objectForKey:@"trId"];
    return trId;
//    return [TPConfig sharedManager].currentUserInfo.userId;
}
-(OMPageModel *)pageModel{
    if (!_pageModel) {
        _pageModel = [[OMPageModel alloc] init];
    }
    return _pageModel;
}
-(NSString *)cacheKey{
    ///userName唯一的，userId不确定存在性
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:TPUserUserName];
    return [NSString stringWithFormat:@"%@_%@",NSStringFromClass(self.class),userName];
}

-(NSDictionary *)cacheData{
    if (!_cacheData) {
        _cacheData  = [[NSUserDefaults standardUserDefaults] objectForKey:self.cacheKey];
    }
    return _cacheData;
}
@end
