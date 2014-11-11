//
//  ProfileViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserInfoViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"Profile", @"个人中心");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
     NSString* userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:userID forKey:@"uid"];
    [self.sinaWeibo requestWithURL:@"users/show.json" params:params httpMethod:@"GET" block:^(id result) {
        _nickName = [result objectForKey:@"screen_name"];
        UserInfoViewController *userVc = [[UserInfoViewController alloc]init];
        userVc.nickName = self.nickName;
        [self addChildViewController:userVc];
        [self.view addSubview:userVc.view];
        [userVc release];
    }];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
