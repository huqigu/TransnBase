//
//  TransnKitReasource.m
//  TransnKit
//
//  Created by 姜冲 on 2022/7/6.
//

#import "TransnKitReasource.h"

@implementation TransnKitReasource

+ (NSBundle *)currentBundle {
    NSBundle *bundle = [NSBundle bundleForClass: [self class]];
    NSString *path = [bundle pathForResource:@"TransnBase" ofType:@"bundle"];
    return [NSBundle bundleWithPath:path];
}

+ (UIImage *)imageNamed:(NSString *)imageName {
//    UIImage *image = [UIImage imageNamed:imageName
//    inBundle:[self currentBundle]
//           compatibleWithTraitCollection:nil];
    return [UIImage imageNamed:imageName];
}

@end
