//
//  MainViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeButton.h"
#import "UIControlFactory.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //隐藏系统的tabbar
        [self.tabBar setHidden:YES];
    }
    return self;
}
- (void)initViewController
{
    _homeVc = [[HomeViewController alloc]init];
    MessageViewController *messageVc = [[MessageViewController alloc]init];
    ProfileViewController *proVc = [[ProfileViewController alloc]init];
    DiscoverViewController *disVc = [[DiscoverViewController alloc]init];
    MoreViewController     *moreVc = [[MoreViewController alloc]init];
    
    NSArray *vcArray = @[_homeVc,messageVc,proVc,disVc,moreVc];
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithCapacity:5];
    for (UIViewController* vc in vcArray) {
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
        nav.delegate = self;
        [viewControllers addObject:nav];
        [nav release];
    }
    self.viewControllers = viewControllers;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:view];//这个就是控制器有了view的对象所有权
    [view release];
}
- (void)showTabbarView:(BOOL)bShow
{
    [UIView animateWithDuration:0.35 animations:^{
        if (bShow) {
            self.tabbarView.left = 0;
        }
        else
        {
            self.tabbarView.left = -ScreenWidth;
        }
    }];
    
   
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (bShow) {
                subView.height = ScreenHeight - 20 -49;
            }
            else
            {
                subView.height = ScreenHeight - 20;
            }
        }
    }
    
}
#pragma mark - UINavigationController delegate -
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int count = navigationController.viewControllers.count;
    if (count == 1) {
        [self showTabbarView:YES];
    }
    else
    {
        [self showTabbarView:NO];
    }
}
- (void)initTabbarView
{
//    自定义tabbar  因为ddmenu的y坐标是从20开始 所以要减去20
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49-20, ScreenWidth, 49)];

    UIImageView *imageView = [UIControlFactory createImageView:@"tabbar_background.png"];
    imageView.frame = _tabbarView.bounds;
    [_tabbarView addSubview:imageView];
    [self.view addSubview:_tabbarView];
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *highlightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for(int i =0 ;i<backgroud.count;i++)
    {
        NSString *backImage = backgroud[i];
        NSString *highlightImage = highlightBackground[i];
        //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button = [UIControlFactory createButton:backImage highlighted:highlightImage];
      
        button.frame = CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag = i;
     
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    _slideImageView = [UIControlFactory createImageView:@"tabbar_slider.png"];
    _slideImageView.frame = CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_slideImageView];
    _slideImageView.backgroundColor = [UIColor clearColor];
}
- (void)selectedTab:(UIButton*)btn
{


    float x = btn.frame.origin.x + (btn.frame.size.width-_slideImageView.frame.size.width)/2;

    CGRect rc = CGRectMake(x, _slideImageView.frame.origin.y, _slideImageView.frame.size.width, _slideImageView.frame.size.height);
    [UIView animateWithDuration:0.2 animations:^{
        _slideImageView.frame = rc;
    }];
    if (btn.tag == self.selectedIndex && btn.tag == 0) {
        // 刷新
       UINavigationController* nav = [self.viewControllers objectAtIndex:0];
        HomeViewController *homeVc = [nav.viewControllers objectAtIndex:0];
        [homeVc autoRefreshData];
    }
    self.selectedIndex = btn.tag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViewController];
    [self initTabbarView];
    NSLog(@"main view = %@",NSStringFromCGRect(self.view.bounds));
    //获取更新的微博数目
    [NSTimer  scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}

- (void)timerAction:(NSTimer*)time
{
    [self updateData];
}
//获取未读微博的数据
- (void)updateData
{
    AppDelegate  *appDelegate = [UIApplication sharedApplication].delegate;
    SinaWeibo  *sinaWeibo = appDelegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"remind/unread_count.json"
                       params:nil
                   httpMethod:@"GET"
                        block:^(id restult) {
                            [self updateNoReadCount:restult];
    }];
}
- (void)updateNoReadCount:(NSDictionary*)dic
{
    NSNumber *noRead = [dic objectForKey:@"status"];
   // NSLog(@"not reade count = %@",noRead);
    if (_badgeView == nil) {
        _badgeView = [UIControlFactory createImageView:@"main_badge.png"];
        _badgeView.frame = CGRectMake(44, 2, 20, 20);
        [self.tabbarView addSubview:_badgeView];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:_badgeView.bounds];
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.tag = 100;
        [_badgeView addSubview:label];
    }
    UILabel *label = (UILabel*)[_badgeView viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%@",noRead];
    if([noRead intValue] > 0)
    {
        [_badgeView setHidden:NO];
    }
    else
    {
        [_badgeView setHidden:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - sinaweibo delegate -

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_homeVc loadWeiboData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"login error = %@",error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
     NSLog(@"accesstoken error = %@",error);
}
@end
