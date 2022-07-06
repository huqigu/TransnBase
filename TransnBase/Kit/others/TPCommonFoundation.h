//
//  TPCommonFoundation.h
//  woordee
//
//  Created by 姜政 on 2021/9/2.
//  Copyright © 2021 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///nib文件，cell复用时使用
FOUNDATION_EXPORT   UINib *tr_nibWithClass(Class aClass);
///即时加载，解析nib对象数组中的view对象
FOUNDATION_EXPORT   __kindof NSObject * _Nullable tr_loadNibClass(Class aClass);

FOUNDATION_EXPORT   UIStoryboard * _Nullable tr_storyboardWithName(NSString *storyName);

FOUNDATION_EXPORT   __kindof UIViewController * tr_instantiateViewControllerWithClass(NSString *storyName,Class aClass);


FOUNDATION_EXPORT   __kindof UIViewController * tr_instantiateViewControllerWithIdentifier(NSString *storyName,NSString *identifier);

FOUNDATION_EXPORT   __kindof UIViewController * tr_initWithNibClass(Class aClass);

FOUNDATION_EXPORT   void tr_registerTableCell(UITableView *tableView,Class aClass);

FOUNDATION_EXPORT   __kindof UITableViewCell * _Nullable tr_reusableTableCell(UITableView *tableView,Class aClass);

FOUNDATION_EXPORT   void tr_collectionVRegisterCell(UICollectionView *collectionV,Class aClass);

FOUNDATION_EXPORT  __kindof UICollectionViewCell * tr_collectionVReusableCell(UICollectionView *collectionV,Class aClass,NSIndexPath *indexPath);
@interface TPCommonFoundation : NSObject

@end

NS_ASSUME_NONNULL_END
