//
//  TPBaseRequestEntity.h
//  Transn
//
//  Created by 姜政 on 2020/3/10.
//  Copyright © 2020年 Transn. All rights reserved.
//

#define TRURLErrorBadURL -1000

#import <Foundation/Foundation.h>
#import "OMPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPBaseRequestEntity : NSObject

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *cacheKey;
@property(nonatomic,strong)NSDictionary *cacheData;
@property(nonatomic,strong)OMPageModel *pageModel;

@end

NS_ASSUME_NONNULL_END
