//
//  BSViewController.h
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/20.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BSTutorialViewController.h"
#import "BSDefaultViewObject.h"
#import "UICKeyChainStore.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <ImageIO/ImageIO.h>
#import <MapKit/MapKit.h>
#import "BSCategoryView.h"
#import "Reachability.h"
#import "BSTopFooterView.h"
#import "BSItemListView.h"
#import "FollowShopTableViewCell.h"
#import "BSMainPagingScrollView.h"

@interface BSBuyTopViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIScrollView *categoryScrollView;
@property(nonatomic) CGFloat beginScrollOffsetY;
//@property (nonatomic, retain) ShopTableViewCell *shopCell;
@property (nonatomic,retain) Reachability *reachability;
@property (nonatomic) BOOL isOnline;

@end
