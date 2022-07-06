//
//  TPBaseViewModel.h
//  Transn
//
//  Created by 姜政 on 2020/3/9.
//  Copyright © 2020年 Transn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPBaseRequestEntity.h"
//#import "TPHttpTool.h"
#import "OMPageModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TPSuccessBlock)( id _Nullable response);
typedef void(^TPFailureBlock)(NSError * _Nullable error);
typedef void(^TPCompletionBlock)(void);

typedef NS_ENUM(NSUInteger, TPViewModelSate) {
    ///请求中
    TPViewModelSateRequest = 0,
    ///网络问题
    TPViewModelSateNetError,
    ///请求成功，但是无数据
    TPViewModelSateNoneData,
    ///请求到数据
    TPViewModelSateDataReturn,
};


@interface TPBaseViewModel : NSObject
///当前的状态
@property(nonatomic)TPViewModelSate state;

@property(nonatomic,assign)BOOL showNoneDataView;

///请求的数据的模型
@property (nonatomic,strong)Class modelClass;
///请求的入参模型
@property(nonatomic,strong)TPBaseRequestEntity *requestEntity;
///请求的入参模型的类型
@property (nonatomic,strong)Class requestClass;

///无论是返回的数据为空，还是有数据返回都是YES,如果网络请求失败，则是NO
@property (nonatomic,readonly)BOOL isDataReturn;

///默认为YES
@property (nonatomic,readonly)BOOL isDefaultSource;

///返回数据解析的模型或者dict
@property(nonatomic,strong,nullable)id resultEntity;

///返回数据解析的数组模型
@property(nonatomic,strong,nullable)NSMutableArray *sourceArray;


@property(nonatomic,strong)OMPageModel *pageModel;
@property(nonatomic)BOOL hasMore;
@property(nonatomic,assign)BOOL enableFooterRefresh;

+(NSDictionary *)tr_replacedKeyFromPropertyName;
-(void)clearData;

-(void)requestData:(TPBaseRequestEntity *_Nullable)entity success:(TPSuccessBlock _Nullable)success
failure:(TPFailureBlock _Nullable)failure completion:(TPCompletionBlock _Nullable)completion;




/// 解析成功的数据
/// @param response 接口返回的数据，如果返回的是数组则解析成sourceArray，否则解析成resultEntity
/// @param aClass 需要解析成的model类
/// @param sourceArray 如果自定义接收数据的数组
/// @param success 成功的block
/// @param completion 完成的block
-(void)parseResponse:(NSDictionary *_Nullable)response tagetClass:(Class _Nullable)aClass sourceArray:(NSMutableArray *_Nullable)sourceArray success:(TPSuccessBlock _Nullable)success completion:(TPCompletionBlock _Nullable)completion;
-(void)parseError:(NSError *_Nullable)error failure:(TPFailureBlock _Nullable)failure completion:(TPCompletionBlock _Nullable)completion;
@end


NS_ASSUME_NONNULL_END
