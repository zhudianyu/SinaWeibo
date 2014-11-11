//
//  AppDelegate.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"

@implementation AppDelegate

- (void)dealloc
{
   
    [_window release];
    [super dealloc];
}
- (void)setTheme
{
    NSString* themeName = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    [[ThemeManager shareInstance]setThemeName:themeName];
}

- (void)initSinaWeibo
{

    _sinaWeibo = [[SinaWeibo alloc]initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_mainCtrl];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置主题
    [self setTheme];
    _mainCtrl = [[MainViewController alloc]init];
    LeftViewController *leftViewCtrl = [[LeftViewController alloc]init];
    RightViewController *rightViewCtrl = [[RightViewController alloc]initWithNibName:@"RightViewController" bundle:nil];
    
    _menuCtrl = [[DDMenuController alloc]initWithRootViewController:_mainCtrl];
    _menuCtrl.leftViewController = leftViewCtrl;
    _menuCtrl.rightViewController = rightViewCtrl;
    
    
    [self initSinaWeibo];
    self.window.rootViewController = _menuCtrl;
    
    
//    [leftViewCtrl release];  左右控制器此处不需要释放  因为控制器与menu一直存在 类内复写了set方法
//    [rightViewCtrl release];
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
