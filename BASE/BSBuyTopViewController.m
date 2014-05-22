//
//  BSViewController.m
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/20.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "BSBuyTopViewController.h"

@interface BSBuyTopViewController ()

@end

@implementation BSBuyTopViewController{
@private
    //バッググラウンド
    UIImageView *backgroundImageView;
    
    int selectedIndex;
    int maxIndex;
    
    
    
    BSCategoryView *categoryView;
    BSMainPagingScrollView *mainScrollView;
    
    CGRect fullScreenFrame;
    
    UIActivityIndicatorView *centerLoadingIndicator;
    UIView *smallMenuView;
    UINavigationBar *navBar;
    
    int visibleMainPageIndex;
    
    NSString *imageRootUrl;
    
    
    //お気に入りorかごリスト
    UIView *listView;
    
    //吹き出しの三角の部分
//    Triangle *triView;
    
    BOOL favoriteIsShowed;
    BOOL cartIsShowed;
    
    UIButton *favoriteBtn;
    UIButton *cartBtn;
    UIScrollView *cartlistScroll;
    UIScrollView *favoritelistScroll;
    NSArray *shop2;
    
    NSMutableArray *favoriteImageIdArray;
    NSMutableArray *favoriteImageNameArray;
    
    NSMutableArray *cartImageIdArray;
    NSMutableArray *cartImageNameArray;
    
    //取得したカテゴリー情報
    NSArray *categoryArray;
    
    //s3のurl
    NSString *s3Url;
    
    UILabel *pvNumber;
    UILabel *orderNumberLabel;
    
    NSString *apiUrl;
    
    //NSMutableArray *categoryInfo;
    
    BOOL categoryScrolled;
    
    BOOL isFullView;
    
    
    BOOL isAlerting;//アラート表示中フラグ
    
    
    //ios7parts
    UINavigationBar *categoryBar;
    
    BSItemListView *itemListView;
    BSTopFooterView *footerView;
    BOOL isOpenedFavoriteView;
    
    BOOL isOffSetToTop;
    float categoryViewOffSetY;
    
    //ホームテーブル
    UITableView *homeTable;
    
    //テーブルビューの動き
    BOOL isLeftMove;
    
    int numberOfShopTables;
    
    NSArray *followShopInfo;
    NSMutableArray *AllFollowShopInfo;
    
    NSString *logoUrl;
    NSString *followItemImageName;
    NSString *maxPage;
    
    BOOL isfinishedLoading;
    
    NSString *apnTokenId;
    
    UIActivityIndicatorView *curationLoadingIndicator;
    UILabel *recommendFollowMessage;
    
    NSMutableArray *shopTableViewContentOffsetYArray;
}


@synthesize beginScrollOffsetY;
//@synthesize shopCell;
@synthesize reachability;
@synthesize isOnline;





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setBackgroundView];
    
    [self setCategoryView];
    
    [self setNavigationBar];
    
    [self setFooterView];
    
    
    
    
    UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 500)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    [self.view bringSubviewToFront:blueView];
    
    
    
    
    
    
    NSLog(@"height = %f", self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setShopTable:(int)numOfShops{
    
    //フッターとヘッダーだけサイズを調整する必要
    mainScrollView =
    [[BSMainPagingScrollView alloc]
     initWithFrame:CGRectMake(0, 0,
                              self.view.bounds.size.width,
                              self.view.bounds.size.height)];
    
    mainScrollView.contentSize =
    CGSizeMake(self.view.bounds.size.width*numOfShops,
               self.view.bounds.size.height);
    
    mainScrollView.pagingEnabled = YES;
    
    
}

-(void)setBackgroundView{
    
    //バッググラウンド
    backgroundImageView = [BSDefaultViewObject setBackground];
    if ([BSDefaultViewObject isMoreIos7]) {
        fullScreenFrame = CGRectMake(0, -64, backgroundImageView.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
        backgroundImageView.image = nil;
        backgroundImageView.frame = CGRectMake(0, -64, backgroundImageView.frame.size.width, [[UIScreen mainScreen] bounds].size.height + 64);
        self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    }else{
        backgroundImageView = [BSDefaultViewObject setBackground];
        fullScreenFrame = CGRectMake(0, -64, backgroundImageView.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
        backgroundImageView.frame = fullScreenFrame;
    }
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
}

-(void)setCategoryView{
    
    if ([BSDefaultViewObject isMoreIos7]) {
        
        //カテゴリーのスライド
        //-----カテゴリーメニューの作成
        categoryView = [[BSCategoryView alloc] initWithFrame:CGRectMake(0,63,320,40)];
        categoryView.backgroundColor = [UIColor clearColor];
        categoryView.clipsToBounds = YES;
        categoryView.hidden = NO;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
        [categoryView addGestureRecognizer:tap];
        
        self.categoryScrollView = [[UIScrollView alloc] init];
        self.categoryScrollView.frame = CGRectMake(0,0.0f,320.0f,40.0f);
        self.categoryScrollView.pagingEnabled = YES;
        self.categoryScrollView.showsVerticalScrollIndicator = NO;
        self.categoryScrollView.showsHorizontalScrollIndicator = NO;
        self.categoryScrollView.bounces = YES;
        self.categoryScrollView.alwaysBounceHorizontal = YES;
        self.categoryScrollView.alwaysBounceVertical = NO;
        self.categoryScrollView.backgroundColor = [UIColor clearColor];
        self.categoryScrollView.delegate = self;
        self.categoryScrollView.scrollsToTop = NO;
        self.categoryScrollView.tag = 1;
        self.categoryScrollView.scrollEnabled = YES;
        
        self.navigationController.navigationBar.hidden = NO;
        categoryView.categoryScrollView = self.categoryScrollView;
        
        
        //ios7カテゴリーバー
        categoryBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        categoryBar.translucent = YES;
        categoryBar.alpha = 0.0;
        categoryBar.barTintColor = [UIColor colorWithRed:251.0f/255.0f green:251.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
        [categoryView addSubview:categoryBar];
        
    }else{
        //カテゴリーのスライド
        //-----カテゴリーメニューの作成
        categoryView = [[BSCategoryView alloc] initWithFrame:CGRectMake(0,-self.navigationController.navigationBar.frame.size.height,320,44)];
        categoryView.backgroundColor = [UIColor clearColor];
        categoryView.clipsToBounds = YES;
        categoryView.hidden = NO;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
        [categoryView addGestureRecognizer:tap];
        
        self.categoryScrollView = [[UIScrollView alloc] init];
        self.categoryScrollView.frame = CGRectMake(0,0.0f,320.0f,40.0f);
        self.categoryScrollView.pagingEnabled = YES;
        self.categoryScrollView.showsVerticalScrollIndicator = NO;
        self.categoryScrollView.showsHorizontalScrollIndicator = NO;
        self.categoryScrollView.bounces = YES;
        self.categoryScrollView.alwaysBounceHorizontal = YES;
        self.categoryScrollView.alwaysBounceVertical = NO;
        self.categoryScrollView.backgroundColor = [UIColor clearColor];
        self.categoryScrollView.delegate = self;
        self.categoryScrollView.scrollsToTop = NO;
        self.categoryScrollView.tag = 1;
        self.categoryScrollView.scrollEnabled = YES;
        
        self.navigationController.navigationBar.hidden = NO;
        categoryView.categoryScrollView = self.categoryScrollView;
        
        UIImage *categroyImage = [UIImage imageNamed:@"buy_category"];
        UIImageView *categoryImageView = [[UIImageView alloc] initWithImage:categroyImage];
        [categoryView addSubview:categoryImageView];
    }
    
    [categoryView addSubview:self.categoryScrollView];
    
}

-(void)setNavigationBar{
    
    //ナビゲーションバー
    //navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    //UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"BASE"];
    if ([BSDefaultViewObject isMoreIos7]) {
        
        
        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 44);
        
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_7_header.png"]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    }else{
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header.png"]];
    }
    
    //[self.view addSubview:navBar];
    [self.view insertSubview:categoryView belowSubview:self.navigationController.navigationBar];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    if ([BSDefaultViewObject isMoreIos7]) {
        leftButton.frame = CGRectMake(-20.0f, 0, 50, 42);
        leftButton.backgroundColor = [UIColor clearColor];
        
        [leftButton setImage:[UIImage imageNamed:@"icon_7_info.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(aboutApp) forControlEvents:UIControlEventTouchDown];
        UIView * leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50, 40.0f)];
        leftButtonView.backgroundColor = [UIColor clearColor];
        leftButton.tag = 1;
        [leftButtonView addSubview:leftButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
        //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_7_info.png"] style:UIBarButtonItemStylePlain target:self action:@selector(aboutApp)];
        //[self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"icon_7_info.png"]];
    }else{
        leftButton.frame = CGRectMake(0, 0, 50, 42);
        [leftButton setImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(aboutApp) forControlEvents:UIControlEventTouchDown];
        UIView * leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 50, 40.0f)];
        leftButtonView.backgroundColor = [UIColor clearColor];
        leftButton.tag = 1;
        [leftButtonView addSubview:leftButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    }
    
    /*
     [leftButton addTarget:self action:@selector(aboutApp) forControlEvents:UIControlEventTouchUpInside];
     UIView * leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 50, 40.0f)];
     leftButtonView.backgroundColor = [UIColor clearColor];
     leftButton.tag = 1;
     [leftButtonView addSubview:leftButton];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
     */
    
    
    /*
     UIBarButtonItem *rightItemButton = [[UIBarButtonItem alloc] initWithTitle:@"売る" style:UIBarButtonItemStyleBordered target:self action:@selector(goSell)];
     navItem.rightBarButtonItem = rightItemButton;
     */
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.backgroundColor = [UIColor clearColor];
    if ([BSDefaultViewObject isMoreIos7]) {
        menuButton.frame = CGRectMake(10, 0, 70, 42);
        menuButton.backgroundColor = [UIColor clearColor];
        [menuButton setImage:[UIImage imageNamed:@"icon_7_myshop.png"] forState:UIControlStateNormal];
        
    }else{
        menuButton.frame = CGRectMake(0, 0, 50, 42);
        [menuButton setImage:[UIImage imageNamed:@"icon_myshop.png"] forState:UIControlStateNormal];
        
    }
    [menuButton addTarget:self action:@selector(goSell) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * menuButtonView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 50, 40.0f)];
    menuButtonView.backgroundColor = [UIColor clearColor];
    menuButtonView.userInteractionEnabled = YES;
    [menuButtonView addSubview:menuButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButtonView];
    
}

-(void)setFooterView{
    NSLog(@"set footer view");
    if ([BSDefaultViewObject isMoreIos7]) {
        
        NSLog(@"is more ios7");
        footerView = [BSTopFooterView setView];
        footerView.frame = CGRectMake(0, self.view.frame.size.height - footerView.frame.size.height, footerView.frame.size.width, footerView.frame.size.height);
        [self.view addSubview:footerView];
        
        itemListView = [BSItemListView setView];
        itemListView.frame = CGRectMake(0, self.view.frame.size.height, itemListView.frame.size.width, itemListView.frame.size.height);
        [self.view addSubview:itemListView];
        
        [[footerView.favoriteButton layer] setBorderWidth:0.25f];
        [[footerView.favoriteButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        [[footerView.cartButton layer] setBorderWidth:0.25f];
        [[footerView.cartButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        
        [footerView.favoriteButton addTarget:self
                                      action:@selector(showFavoriteIOS7:) forControlEvents:UIControlEventTouchUpInside];
        [footerView.cartButton addTarget:self
                                  action:@selector(showCartIOS7:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        NSLog(@"is less ios7");
        
        // TODO: footerViewの配置を表示
        
        //左下のメニュー
        smallMenuView = [[UIView alloc] init];
        smallMenuView.frame = CGRectMake(5,[[UIScreen mainScreen] bounds].size.height - 100,90,35);
        smallMenuView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.70f];
        smallMenuView.layer.cornerRadius = 2;
        smallMenuView.layer.masksToBounds = YES;
        [self.view addSubview:smallMenuView];
        
        //吹き出しの三角
//        triView = [[Triangle alloc] initWithFrame:CGRectMake(18, [[UIScreen mainScreen] bounds].size.height - 70, 20, 10)];
//        triView.alpha = 0.0;
//        [self.view addSubview:triView];
        
        //お気に入りorかごのリスト
        listView = [[UIView alloc] init];
        listView.frame = CGRectMake(5,[[UIScreen mainScreen] bounds].size.height - 125,310,55);
        listView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.70f];
        listView.layer.cornerRadius = 2;
        listView.layer.masksToBounds = YES;
        listView.alpha = 0.0;
        [self.view addSubview:listView];
        
        
        
        //スクロール
        favoritelistScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(5,0,300,55)];
        favoritelistScroll.contentSize = CGSizeMake(460,55);
        favoritelistScroll.scrollsToTop = NO;
        favoritelistScroll.hidden = YES;
        [listView addSubview:favoritelistScroll];
        
        
        //スクロール
        cartlistScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(5,0,300,55)];
        cartlistScroll.contentSize = CGSizeMake(460,55);
        cartlistScroll.scrollsToTop = NO;
        cartlistScroll.hidden = YES;
        [listView addSubview:cartlistScroll];
        
        
        
        
        centerLoadingIndicator = [[UIActivityIndicatorView alloc] init];
        centerLoadingIndicator.frame = CGRectMake(0, 0, 50, 50);
        centerLoadingIndicator.center = self.view.center;
        centerLoadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.view addSubview:centerLoadingIndicator];
        [centerLoadingIndicator startAnimating];  // アニメーションを開始させたい時に呼ぶ
        
        
        
        
        UIImage *starImage = [UIImage imageNamed:@"icon_f_buy_star"];
        favoriteBtn = [[UIButton alloc]
                       initWithFrame:CGRectMake(0, 0, 45, 35)];
        [favoriteBtn setImage:starImage forState:UIControlStateNormal];
        [favoriteBtn addTarget:self
                        action:@selector(showFavorite:) forControlEvents:UIControlEventTouchUpInside];
        favoriteBtn.tag = 1;
        favoriteBtn.backgroundColor = [UIColor clearColor];
        [smallMenuView addSubview:favoriteBtn];
        
        
        UIImage *cartImage = [UIImage imageNamed:@"icon_f_buy_cart"];
        cartBtn = [[UIButton alloc]
                   initWithFrame:CGRectMake(45, 0, 45, 35)];
        [cartBtn setImage:cartImage forState:UIControlStateNormal];
        [cartBtn addTarget:self
                    action:@selector(showCart:) forControlEvents:UIControlEventTouchUpInside];
        cartBtn.tag = 1;
        //cartBtn.backgroundColor = [UIColor blueColor];
        [smallMenuView addSubview:cartBtn];
    }
}

-(void)labelTapped:(id)sender{
    
    NSLog(@"labeltapped:%@", sender);
}

-(void)showFavoriteIOS7{
    
}


-(void)showCartIOS7{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;//cell作成して返す
}
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//スクロールが停止したらフッターとヘッダーの位置を見える位置に持っていく＆mainScrollViewの位置を見える位置
//-(void)animateMainScrollView:(UIScrollView *)scrollView
//コンテンツの最初の位置はヘッダーの位置だけ下にずらす


//スクロールし始めたら(scrollViewWillBeginDragging)フッターとヘッダーを見えない位置に配置



@end
