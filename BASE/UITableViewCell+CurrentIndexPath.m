//
//  UITableViewCell+CurrentIndexPath.m
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/21.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "UITableViewCell+CurrentIndexPath.h"
#import <objc/runtime.h>

static char kCurrentIndexPathKey;

// currentIndexPathプロパティの実装
@implementation UITableViewCell (CurrentIndexPath)

// getter
- (NSIndexPath *)currentIndexPath
{
    return objc_getAssociatedObject(self, &kCurrentIndexPathKey);
}

// setter
- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    objc_setAssociatedObject(self, &kCurrentIndexPathKey, currentIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end