//
//  BaseViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface BaseViewController : UIViewController
@property(nonatomic, assign) BOOL isBackBtn;
@property(nonatomic, retain) MBProgressHUD *hud;
- (SinaWeibo*)sinaWeibo;
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
- (void)hiddenHUD;
- (void)showHUDCompelete:(NSString *)title;
- (AppDelegate *)appdelegate;
@end
