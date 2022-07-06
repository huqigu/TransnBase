//
//  OMPageModel.h
//  yipai
//
//  Created by 姜政 on 2019/12/19.
//  Copyright © 2019 姜政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OMPageModel : NSObject


@property(nonatomic,assign)NSInteger curr;
@property(nonatomic,assign)NSInteger limit;
@property(nonatomic)NSInteger total;

-(OMPageModel *)increaseCopyOne;
@end

NS_ASSUME_NONNULL_END
