//
//  TransnKitManager.m
//  TransnKit
//
//  Created by 姜冲 on 2022/7/6.
//

#import "TransnKitManager.h"

@implementation TransnKitManager

+ (instancetype)defaultManager {
    static TransnKitManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end
