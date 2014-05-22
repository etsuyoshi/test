//
//  BSAlertView.m
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/14.
//  Copyright (c) 2014年 Takkun. All rights reserved.
//

#import "BSAlertView.h"


//ブロック構文を取り入れたアラートビュー
@implementation BSAlertView

@synthesize clickedButtonAtIndex = clickedButtonAtIndex_;
@synthesize cancel = cancel_;

+(void) alertWithTitle:(NSString*)title
               message:(NSString*)message
     cancelButtonTitle:(NSString*)cancelButtonTitle
          clickedBlock:(void (^)(UIAlertView* alertView,
                                 NSInteger buttonIndex))clickedButtonAtIndex
           cancelBlock:(void (^)(UIAlertView* alertView))cancel
     otherButtonTitles:(NSString*)titles,...;
{
    
    BSAlertView* myAlertView = [[BSAlertView alloc] initWithClickedBlock:clickedButtonAtIndex cancelBlock:cancel];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:myAlertView cancelButtonTitle:cancelButtonTitle otherButtonTitles:titles, nil];
    [alertView show];
}

-(id)initWithClickedBlock:(void (^)(UIAlertView* alertView, NSInteger buttonIndex))clickedButtonAtIndex cancelBlock:(void (^)(UIAlertView* alertView))cancel;{
    self = [super init];
    if (self) {
        self.clickedButtonAtIndex = clickedButtonAtIndex;
        self.cancel = cancel;
    }
    
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;{
    clickedButtonAtIndex_(alertView, buttonIndex);
}

-(void)alertViewCancel:(UIAlertView *)alertView;
{
    cancel_(alertView);
}
@end