//
//  HomeViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboTableView.h"
#import "BaseTableView.h"
#import "UIControlFactory.h"
#import "ThemeImageView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainViewController.h"
#import "DetailViewController.h"
#import "DDMenuController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", @"主页");
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"home frame = %@",NSStringFromCGRect(self.view.frame));
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    
    //注销按钮
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [logoutItem autorelease];
    
    
    
    _tableView = [[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -20 - 44 -49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView setEventDelegate:self];

    if (self.sinaWeibo.isAuthValid) {
        [self loadWeiboData];
    }
    else
    {
        [self.sinaWeibo logIn];
    }
}
- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

- (void)loadWeiboData
{
    [super showHUD:@"正在加载" isDim:NO];
    [_tableView setHidden:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:params
                        httpMethod:@"GET" delegate:self];

}

- (void)bindAction:(UIButton*)button
{
    [self.sinaWeibo logIn];
}

- (void)logoutAction:(UIButton*)button
{
    [self.sinaWeibo logOut];
    
    [self.sinaWeibo logIn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self appdelegate].menuCtrl setEnableGesture:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self appdelegate].menuCtrl setEnableGesture:NO];
}
#pragma mark - sina request delegate -
- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    
}
//更新网络数据
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{

    [self hiddenHUD];
    [_tableView setHidden:NO];
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        WeiboModel *weibo =[[WeiboModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    self.tableView.data = weibos;
    self.weiboDataArray = weibos;
    if (weibos.count>=20) {
        self.tableView.isMore = YES;
    }
    else
    {
        self.tableView.isMore = NO;
    }
    if (weibos.count>0) {
        WeiboModel *weibo = [weibos objectAtIndex:0];
        self.topWeiboId = [weibo.weiboId stringValue];
        
        WeiboModel *lastWeibo = [weibos lastObject];
        self.lastWeiboId = [lastWeibo.weiboId stringValue];
        NSLog(@"topweiboId = %d",[self.topWeiboId integerValue]);
    }
    [self.tableView reloadData];
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}
#pragma mark - ui -
- (void)upDateWeiboCount:(int)count
{
    if (_updateWeiboView == nil)
    {
        _updateWeiboView = [UIControlFactory createImageView:@"timeline_new_status_background.png"];
        UIImage *image = [_updateWeiboView.image stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        _updateWeiboView.image = image;
        _updateWeiboView.leftCapWidth = 1;
        _updateWeiboView.topCapHeight = 5;
        [self.view addSubview:_updateWeiboView];
        _updateWeiboView.frame = CGRectMake(5, -40, ScreenWidth - 10, 40);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16.0];
        label.textColor = [UIColor whiteColor];
        label.tag = 124;
        [_updateWeiboView addSubview:label];
        [label release];
    }
    if (count > 0) {
        
        UILabel *textLabel = (UILabel*)[_updateWeiboView viewWithTag:124];
        textLabel.text = [NSString stringWithFormat:@"%d条新微博",count];
        [textLabel sizeToFit];
        textLabel.origin = CGPointMake((_updateWeiboView.width - textLabel.width)/2.0, (_updateWeiboView.height - textLabel.height)/2.0);
        
        [UIView animateWithDuration:0.6 animations:^{
            _updateWeiboView.top = 5;
        } completion:^(BOOL finished) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:1];
            [UIView setAnimationDuration:0.6];
            _updateWeiboView.top = -40;
            [UIView commitAnimations];
        }];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((CFURLRef)fileUrl, &soundId);
        AudioServicesPlaySystemSound(soundId);
        
    }
    
    MainViewController *mainVc = (MainViewController*)self.tabBarController;
    [mainVc.badgeView setHidden:YES];

}
- (void)autoRefreshData
{
    [self.tableView refreshData];
    //更新数据
    [self pullDownData];
}
#pragma mark - pulldown data -
- (void)pullDownDataFinish:(id)result
{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        WeiboModel *weibo =[[WeiboModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
// 拼接刷新的数据到微博的数组
    [weibos addObjectsFromArray:self.weiboDataArray];
    if (statues.count>0) {
        WeiboModel *weibo = [weibos objectAtIndex:0];
        self.topWeiboId = [weibo.weiboId stringValue];
        NSLog(@"topweiboId = %d",[self.topWeiboId integerValue]);
    }
    self.weiboDataArray = weibos;
    self.tableView.data = weibos;
    //刷新
    [self.tableView reloadData];
    [self.tableView doneLoadingTableViewData];
    
    NSLog(@"更新微博数 %d",statues.count);
    [self upDateWeiboCount:statues.count];
}

- (void)pullDownData
{
    //重新获取数据
    if (self.topWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.topWeiboId,@"since_id", nil];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          block:^(id result) {
                              [self pullDownDataFinish:result];
                          }];
}
#pragma mark - pull up data -
- (void)pullUpDataFinish:(NSDictionary*)result
{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        WeiboModel *weibo =[[WeiboModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    // 拼接刷新的数据到微博的数组
    [self.weiboDataArray addObjectsFromArray:weibos];
    self.tableView.data = self.weiboDataArray;
    if (statues.count>=20) {
        self.tableView.isMore = YES;
    }
    else
    {
        self.tableView.isMore = NO;
    }
    if (statues.count>0) {
        WeiboModel *weibo = [weibos lastObject];
        self.lastWeiboId = [weibo.weiboId stringValue];
        [weibos removeObjectAtIndex:0];
       // NSLog(@"lastWeiboId = %d",[self.topWeiboId integerValue]);
    }
    
    [self.tableView reloadData];
}
- (void)pullUpData
{
    //重新获取数据
    if (self.lastWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.lastWeiboId,@"max_id", nil];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result) {
                                 [self pullUpDataFinish:result];
                             }];
}
#pragma mark - tableViewEvent Delegate -
- (void)pullDown:(BaseTableView*)tableView
{
    NSLog(@"pulldown");
    //下拉 刷新 
    [self pullDownData];
}

- (void)pullUp:(BaseTableView*)tableView
{
    NSLog(@"pull up");
    [self pullUpData];
}

- (void)tableView:(BaseTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    detailVc.weiboModel = [self.weiboDataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

@end
