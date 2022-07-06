//
//  TransnKitReasource.h
//  TransnKit
//
//  Created by 姜冲 on 2022/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransnKitReasource : NSObject

+ (NSBundle *)currentBundle;

+ (UIImage *)imageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
