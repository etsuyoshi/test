//
//  BSWebFooterView.h
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/13.
//  Copyright (c) 2014年 Takkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSWebFooterView : UIView
@property (nonatomic) UIButton *btnBack;
@property (nonatomic) UIButton *btnForward;


-(void)setGoBack:(BOOL)canGoBack;
-(void)setGoForward:(BOOL)canGoBack;
-(void)addBackTarget:(id)target
              action:(SEL)selector
    forControlEvents:(UIControlEvents)controlEvent;
-(void)addForwardTarget:(id)target
                 action:(SEL)selector
       forControlEvents:(UIControlEvents)controlEvent;
@end
