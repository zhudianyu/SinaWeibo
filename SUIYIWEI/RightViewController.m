//
//  RightViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "BaseNavigationViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            self.view.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendWeibo:(id)sender {
    SendViewController *sendVc = [[SendViewController alloc]init];
    BaseNavigationViewController *sendNav = [[BaseNavigationViewController alloc]initWithRootViewController:sendVc];
   
    [self.appdelegate.menuCtrl presentViewController:sendNav animated:YES completion:NULL];
}

- (IBAction)photo:(id)sender {
}
@end
