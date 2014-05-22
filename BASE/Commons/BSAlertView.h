//
//  BSAlertView.h
//  BASE
//
//  Created by EndoTsuyoshi on 2014/05/14.
//  Copyright (c) 2014年 Takkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BSAlertView : NSObject<UIAlertViewDelegate>{
    void (^clickedButtonAtIndex_)(UIAlertView* alertView, NSInteger buttonIndex);
    void (^cancel_)(UIAlertView* alertView);
}

@property(nonatomic,copy) void (^clickedButtonAtIndex)(UIAlertView* alertView,
NSInteger buttonIndex);
@property(nonatomic,copy) void (^cancel)(UIAlertView* alertView);

+(void) alertWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle
          clickedBlock:(void (^)(UIAlertView* alertView, NSInteger buttonIndex))clickedButtonAtIndex cancelBlock:(void (^)(UIAlertView* alertView))cancel
     otherButtonTitles:(NSString*)titles,...;
-(id)initWithClickedBlock:(void (^)(UIAlertView* alertView, NSInteger buttonIndex))clickedButtonAtIndex cancelBlock:(void (^)(UIAlertView* alertView))cancel;

@end