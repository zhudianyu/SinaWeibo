//
//  AppDelegate.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SinaWeibo;
@class MainViewController;
@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) SinaWeibo *sinaWeibo;
@property (nonatomic, retain) MainViewController *mainCtrl;
@property (nonatomic, retain) DDMenuController *menuCtrl;
@end
