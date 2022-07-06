//
//  TPBaseViewModel.m
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import "TPBaseViewModel.h"
#import <MJExtension/MJExtension.h>

@implementation TPBaseViewModel
#pragma mark getter
-(TPBaseRequestEntity *)requestEntity{
    if (!_requestEntity) {
        if (self.requestClass) {
            _requestEntity = [self.requestClass new];
        }else{
            _requestEntity = [[TPBaseRequestEntity alloc] init];
        }
    }
    return _requestEntity;
}
-(NSMutableArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc] init];
    }
    return _sourceArray;
}
-(BOOL)showNoneDataView{
    return self.state == TPViewModelSateNetError
        || self.state == TPViewModelSateNoneData
        || self.state == TPViewModelSateRequest;
}
-(BOOL)isDataReturn{
    return self.state == TPViewModelSateNoneData
            ||self.state == TPViewModelSateDataReturn;
}

-(void)requestData:(TPBaseRequestEntity *)entity success:(TPSuccessBlock)success failure:(TPFailureBlock)failure completion:(TPCompletionBlock)completion{
#ifdef DEBUG
    NSAssert(0, @"Warning 这个方法，调用进入了父类");
#else
#endif
}


-(NSArray *)parseList:(NSArray *)list tagetClass:(Class)aClass{
    if (list.count ==0 && self.sourceArray.count == 0) {
        self.state = TPViewModelSateNoneData;
    }else{
        self.state = TPViewModelSateDataReturn;
    }

    if (aClass == nil ||[aClass isEqual:[NSDictionary class]]) {
        return list;
    }else{
        return [aClass mj_objectArrayWithKeyValuesArray:list];
    }
}

-(NSObject *)parseData:(NSDictionary *)dict tagetClass:(Class)aClass{
    if (dict.allValues.count ==0) {
        self.state = TPViewModelSateNoneData;
    }else{
        self.state = TPViewModelSateDataReturn;
    }
//    NSObject *ob = [aClass new];
//    [ob setValuesForKeysWithDictionary:dict];
    if (aClass) {
        return [aClass mj_objectWithKeyValues:dict];
    }else{
        return dict;
    }
}

-(void)parseResponse:(NSDictionary *)response tagetClass:(Class)aClass sourceArray:(NSMutableArray *)sourceArray success:(TPSuccessBlock)success completion:(TPCompletionBlock)completion{
    if (!response) {
        self.state = TPViewModelSateNoneData;
        if (completion) {
            completion();
        }
        return;
    }
        if (!aClass) {
            aClass = self.modelClass;
        }
        if ([response isKindOfClass:[NSString class]]) {
            self.state = TPViewModelSateDataReturn;
            if (success) {
                success(response);
            }
            if (completion) {
                completion();
            }
            return;
        }
        id data = response;
        BOOL responseIsArray = false;
        NSArray *list;
        if ([data isKindOfClass:[NSArray class]]) {
            responseIsArray = YES;
            list = data;
        }else if([data isKindOfClass:[NSDictionary  class]]){
            if  (class_respondsToSelector(aClass, NSSelectorFromString(@"responseContainList"))) {
                responseIsArray =  FALSE;
            }else{
                if ([self.class respondsToSelector:@selector(tr_replacedKeyFromPropertyName)]) {
                    list = data[[self class].tr_replacedKeyFromPropertyName[@"list"]];
                }else{
                    list = data[@"list"];
                }
                if (list && [list isKindOfClass:[NSArray class]]) {
                    responseIsArray = YES;
                }
            }
        }
        if  (class_respondsToSelector(aClass, NSSelectorFromString(@"responseIsNotArray"))) {
            responseIsArray =  FALSE;
        }
        if (responseIsArray) {
            if (!sourceArray) {
                sourceArray = self.sourceArray;
            }
            if (sourceArray == self.sourceArray) {
                _isDefaultSource = YES;
            }
            if (self.pageModel.curr == 1 && sourceArray.count!=0) {
                [sourceArray removeAllObjects];
            }
            if (_isDefaultSource) {
                if (responseIsArray&& [data isKindOfClass:[NSDictionary class]]) {
                      if (data[@"total"]) {
                          self.pageModel.total = [data[@"total"] integerValue];
                      }
                }
             }
            [sourceArray addObjectsFromArray:[self parseList:list tagetClass:aClass]];
              if (sourceArray.count<self.pageModel.total) {
                  self.pageModel.curr +=1;
                  self.enableFooterRefresh = YES;
              }else{
                  self.enableFooterRefresh = YES;
              }
            if (success) {
                success(sourceArray);
            }
        }else{
            self.resultEntity = [self parseData:data tagetClass:aClass];
            if (success) {
                success(self.resultEntity);
            }
        }
        if (completion) {
            completion();
        }
}
-(void)parseError:(NSError *)error failure:(TPFailureBlock)failure completion:(TPCompletionBlock)completion{
    self.state = TPViewModelSateNetError;
    if (failure) {
        failure(error);
    }
    if (completion) {
        completion();
    }
}

-(void)clearData{
    self.state = TPViewModelSateRequest;
    [self.sourceArray removeAllObjects];
    self.resultEntity = nil;
}

-(OMPageModel *)pageModel{
    if (!_pageModel) {
        _pageModel = [[OMPageModel alloc] init];
    }
    return _pageModel;
}
-(BOOL)hasMore{
    return self.pageModel.total>self.sourceArray.count;
}
@end
