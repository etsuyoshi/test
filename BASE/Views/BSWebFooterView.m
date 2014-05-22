//
//  BSWebFooterView.m
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/13.
//  Copyright (c) 2014年 Takkun. All rights reserved.
//

#import "BSWebFooterView.h"

@implementation BSWebFooterView
@synthesize btnForward;
@synthesize btnBack;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        int iconSize = 15;
        int iconCenterX = self.bounds.size.height/2;//footer height
        //footerに戻るボタン
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //    [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
        self.btnBack.frame = CGRectMake(0, 0, iconSize, iconSize);
        self.btnBack.center = CGPointMake(iconCenterX, iconCenterX);
//        [self.btnBack addTarget:webView
//                    action:@selector(goBack)
//          forControlEvents:UIControlEventTouchUpInside];
        
        //    viewBack.userInteractionEnabled = YES;
        //    [viewBack addGestureRecognizer:
        //     [[UIGestureRecognizer alloc]initWithTarget:webView
        //                                         action:@selector(goBack)]];
        [self addSubview:btnBack];
        
        //footerに進むボタン
        btnForward = [UIButton buttonWithType:UIButtonTypeCustom];
        btnForward.frame = CGRectMake(self.bounds.size.width-iconSize, 0,
                                      iconSize, iconSize);
        btnForward.center = CGPointMake(self.bounds.size.width-iconCenterX, iconCenterX);
        //以下外部から直接実行してもらう
//        [btnForward addTarget:webView
//                       action:@selector(goForward)
//             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnForward];
        
        
        
        [self setGoBack:NO];//最初は戻ることはできないのでNO
        [self setGoForward:NO];//最初は進むことはできないのでNO
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)addBackTarget:(id)target
              action:(SEL)selector
    forControlEvents:(UIControlEvents)controlEvent{
    
    [self.btnBack addTarget:target
                     action:selector
           forControlEvents:controlEvent];
}

-(void)addForwardTarget:(id)target
                 action:(SEL)selector
       forControlEvents:(UIControlEvents)controlEvent{
    
    [self.btnForward addTarget:target
                        action:selector
              forControlEvents:controlEvent];
}

-(void)setGoBack:(BOOL)canGoBack{
    if(canGoBack){
        NSLog(@"戻るボタンをアクティブに");
        self.btnBack.enabled = YES;
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_black.png"] forState:UIControlStateNormal];
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_gray.png"] forState:UIControlStateHighlighted];
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_gray.png"] forState:UIControlStateSelected];
    }else{
        NSLog(@"戻るボタンを非アクティブに");
        self.btnBack.enabled = NO;
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_gray.png"] forState:UIControlStateNormal];
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_gray.png"] forState:UIControlStateHighlighted];
        [self.btnBack setImage:[UIImage imageNamed:@"type2_back_gray.png"] forState:UIControlStateSelected];
    }
    
}

-(void)setGoForward:(BOOL)canGoForward{
    
    
    
    if(canGoForward){
        NSLog(@"進むボタンをアクティブに");
        self.btnForward.enabled = YES;
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_black.png"] forState:UIControlStateNormal];
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_gray.png"] forState:UIControlStateHighlighted];
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_gray.png"] forState:UIControlStateSelected];
    }else{
        NSLog(@"進むボタンを非アクティブに");
        self.btnForward.enabled = NO;
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_gray.png"] forState:UIControlStateNormal];
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_gray.png"] forState:UIControlStateHighlighted];
        [self.btnForward setImage:[UIImage imageNamed:@"type2_next_gray.png"] forState:UIControlStateSelected];
    }

}


//ボタンの反応領域を広げる
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hit test");
    // "hidden", "userInteractionEnabled", "alpha" の値を考慮する
    //    if (self.button.isHidden || self.button.userInteractionEnabled == NO || self.button.alpha < 0.01) {
    if(self.btnBack.isHidden || self.btnBack.userInteractionEnabled == NO || self.btnBack.alpha < 0.01 ||
       self.btnForward.isHidden || self.btnForward.userInteractionEnabled == NO || self.btnForward.alpha < 0.01){
        
        NSLog(@"aaa");
        return [super hitTest:point withEvent:event];
    }
    
    // button のあたり判定 rect を作成
    CGRect rectBack = CGRectInset(self.btnBack.frame, -20, -10);
    // あたり判定 rect 内であれば、button を返し、button にイベントを受けられるようにする
    if (CGRectContainsPoint(rectBack, point)) {
        NSLog(@"戻るボタン：拡張");
        return self.btnBack;
    }
    
    CGRect rectForward = CGRectInset(self.btnForward.frame, -20, -10);
    if(CGRectContainsPoint(rectForward, point)){
        NSLog(@"進むボタン：拡張");
        return self.btnForward;
    }
    
    
    
    // button のあたり判定外だったら従来の挙動に任せる
    return [super hitTest:point withEvent:event];
}

@end
