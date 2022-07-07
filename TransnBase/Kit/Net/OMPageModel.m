//
//  OMPageModel.m
//  yipai
//
//  Created by 姜政 on 2019/12/19.
//  Copyright © 2019 姜政. All rights reserved.
//

#import "OMPageModel.h"

@implementation OMPageModel

-(instancetype)init{
    if(self = [super init]){
        _limit = 20;
        _curr = 1;
    }
    return self;
}
-(OMPageModel *)increaseCopyOne{
    OMPageModel *page = [[OMPageModel alloc] init];
    page.limit = self.limit;
    page.curr = self.curr;
    return page;
}
@end
