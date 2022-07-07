//
//  TPConfig.m
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import "TPConfig.h"

@interface TPConfig(){
    
}

@end

@implementation TPConfig
+(instancetype)sharedManager{
    static TPConfig *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
-(NSMutableDictionary *)webViewCacheDic{
    if (!_webViewCacheDic) {
        _webViewCacheDic = [[NSMutableDictionary alloc] init];
    }
    return _webViewCacheDic;
}

-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidLogin) name:TPUserInvalidLogin object:nil];
    }
    return self;
}
-(void)invalidLogin{
    if (self.didInvalidLogin) {
        self.didInvalidLogin();
    }
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
