//
//  BaseNavigationViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "ThemeManager.h"
@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:kNotificationThemeChange object:nil];
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadThemeImage];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [self.view addGestureRecognizer:gesture];
    [gesture release];
  
	// Do any additional setup after loading the view.
}
- (void)swipeAction:(UISwipeGestureRecognizer*)gesture
{
    if (self.viewControllers.count>0) {
        [self popToRootViewControllerAnimated:YES];
    }
}
-(void)loadThemeImage
{
    float version = ZDYOSVersion();
    if (version >= 5.0) {
    
       UIImage* image = [[ThemeManager shareInstance] getThemeImage:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationBar setNeedsDisplay];
    }
    
    
    
}

#pragma mark - notiofication -
- (void)notificationAction:(NSNotification*)notiofication
{
    [self loadThemeImage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
