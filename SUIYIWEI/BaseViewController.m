//
//  BaseViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "UIControlFactory.h"
#import "ThemeButton.h"
#import "ThemeLabel.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isBackBtn = YES;
    }
    return self;
}
- (void)dealloc
{
    [self.hud release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count>1&&self.isBackBtn) {
        
        ThemeButton *backButton = [UIControlFactory createButton:@"navigationbar_back.png" highlighted:@"navigationbar_back_highlighted.png"];
        backButton.frame = CGRectMake(0, 0, 24, 24);
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = barBtnItem;
        [barBtnItem release];
    }    
	// Do any additional setup after loading the view.
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - overwrite title -
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    ThemeLabel *lable = [UIControlFactory createThemeLabel:kNavigationBarTitleLabel];
    lable.text = title;
    lable.font = [UIFont boldSystemFontOfSize:18.f];
    lable.backgroundColor = [UIColor clearColor];
    [lable sizeToFit];
    
    self.navigationItem.titleView = lable;
    
}

- (SinaWeibo*)sinaWeibo
{
    AppDelegate  *appDelegate = [UIApplication sharedApplication].delegate;
    SinaWeibo  *sinaWeibo = appDelegate.sinaWeibo;
    return sinaWeibo;
}

- (AppDelegate *)appdelegate
{
     AppDelegate  *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate;
}
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}
- (void)hiddenHUD
{
    [self.hud hide:YES];
}

- (void)showHUDCompelete:(NSString *)title
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.customView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]]autorelease];
    self.hud.labelText = title;
    [self.hud hide:YES afterDelay:2.0];
}

@end
