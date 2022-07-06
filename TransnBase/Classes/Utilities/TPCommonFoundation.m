//
//  TPCommonFoundation.m
//  woordee
//
//  Created by 姜政 on 2021/9/2.
//  Copyright © 2021 Transn. All rights reserved.
//

#import "TPCommonFoundation.h"

///nib文件，cell复用时使用
UINib *tr_nibWithClass(Class aClass){
    return [UINib nibWithNibName:NSStringFromClass(aClass) bundle:[NSBundle mainBundle]];
}

///即时加载，解析nib对象数组中的view对象
__kindof NSObject * _Nullable tr_loadNibClass(Class aClass){
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(aClass) owner:nil options:nil] lastObject];
}

UIStoryboard * _Nullable tr_storyboardWithName(NSString *storyName){
    return   [UIStoryboard storyboardWithName:storyName bundle:[NSBundle mainBundle]];
}

__kindof UIViewController * tr_instantiateViewControllerWithClass(NSString *storyName,Class aClass){
    return tr_instantiateViewControllerWithIdentifier(storyName, NSStringFromClass(aClass));
}

__kindof UIViewController * tr_instantiateViewControllerWithIdentifier(NSString *storyName,NSString *identifier){
    UIStoryboard *story = tr_storyboardWithName(storyName);
    return [story instantiateViewControllerWithIdentifier:identifier];
}

__kindof UIViewController * tr_initWithNibClass(Class aClass){
    return [[aClass alloc] initWithNibName:NSStringFromClass(aClass) bundle:nil];
}

void tr_registerTableCell(UITableView *tableView,Class aClass){
    [tableView registerNib:tr_nibWithClass(aClass) forCellReuseIdentifier:NSStringFromClass(aClass)];
}

__kindof UITableViewCell * _Nullable tr_reusableTableCell(UITableView *tableView,Class aClass){
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];
}

void tr_collectionVRegisterCell(UICollectionView *collectionV,Class aClass){
    [collectionV registerNib:tr_nibWithClass(aClass) forCellWithReuseIdentifier:NSStringFromClass(aClass)];
}

__kindof UICollectionViewCell * tr_collectionVReusableCell(UICollectionView *collectionV,Class aClass,NSIndexPath *indexPath){
    return [collectionV dequeueReusableCellWithReuseIdentifier:NSStringFromClass(aClass) forIndexPath:indexPath];
}

#define CollectionVReusableCell(x,y)

@implementation TPCommonFoundation

@end
