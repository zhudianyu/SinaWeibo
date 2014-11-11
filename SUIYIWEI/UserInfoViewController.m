//
//  UserInfoViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoView.h"
#import "UserModel.h"
#import "WeiboTableView.h"
#import "WeiboModel.h"
#import "UIControlFactory.h"
#import "ThemeButton.h"
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
    }
    return self;
}
- (void)dealloc
{
    [_userView release];
    _userView = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _requests = [[NSMutableArray alloc]initWithCapacity:10];
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20) style:UITableViewStylePlain];
    _userView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    
    UIButton *goHomeBtn = [UIControlFactory createButton:@"tabbar_home.png" highlighted:@"tabbar_home_highlighted.png"];
    goHomeBtn.frame = CGRectMake(0, 0, 34, 27);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:goHomeBtn];
    self.navigationItem.rightBarButtonItem = item;
    [goHomeBtn addTarget:self  action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tableView];
    [self.tableView setHidden:YES];
    _tableView.eventDelegate = self;
    [super showHUD:@"正在加载" isDim:YES];
    [self loadUserData];
    
    [self loadWeiboData];

}
- (void)goHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)pullDown:(BaseTableView*)tableView
{
    //模拟
    [self loadWeiboData];
    [self.tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
}
- (void)pullUp:(BaseTableView*)tableView
{
    //模拟
    [self loadWeiboData];
    [self.tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
    
}
#pragma mark - load data -
- (void)loadUserData
{
    if (self.nickName.length == 0) {
        NSLog(@"用户名为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.nickName forKey:@"screen_name"];
   SinaWeiboRequest *request = [self.sinaWeibo requestWithURL:@"users/show.json"
                            params:params
                        httpMethod:@"GET" block:^(id result) {
                            [self loadUserDataFinish:result];
                        }];
    [_requests addObject:request];
}
- (void)loadUserDataFinish:(NSDictionary *)dataDic
{
    UserModel *user = [[UserModel alloc]initWithDataDic:dataDic];
    _userView.user = user;
    _tableView.tableHeaderView = _userView;
    [self.tableView setHidden:NO];
    [super hiddenHUD];
}
#pragma mark - load weibo data -
- (void)loadWeiboData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.nickName forKey:@"screen_name"];
     SinaWeiboRequest *request = [self.sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                            params:params
                        httpMethod:@"GET" block:^(id result) {
                            [self loadWeiboDataFinish:result];
                        }];
    [_requests addObject:request];
}
- (void)loadWeiboDataFinish:(NSDictionary *)dataDic
{
    NSArray *status = [dataDic objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:status.count];
    
    for (NSDictionary *dic in status) {
        WeiboModel *weibo = [[WeiboModel alloc]initWithDataDic:dic];
        [weibos addObject:weibo];
        [weibo release];
    }
    
    self.tableView.data = weibos;
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    //取消网络请求
    [super viewWillDisappear:animated];
    for (SinaWeiboRequest *request in _requests) {
        [request disconnect];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
