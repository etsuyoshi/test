//
//  UITableViewCell+CurrentIndexPath.h
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/21.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import <UIKit/UIKit.h>

// UITableViewCellクラスを拡張し、currentIndexPathプロパティを追加
@interface UITableViewCell (CurrentIndexPath)

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end