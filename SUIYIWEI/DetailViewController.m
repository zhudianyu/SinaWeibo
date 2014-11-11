//
//  DetailViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "DetailViewController.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "CommentModel.h"
#import "UserInfoViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initView
{
//    [_tableView setDelegate:self];
//    [_tableView setDataSource:self];
    UIView *tableViewHeaderView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)] autorelease];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    UIView *tabbarView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)]autorelease];
    //用户图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [imageView setImageWithURL:[NSURL URLWithString:_weiboModel.user.profile_image_url]];
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    
    //昵称
    UILabel *nickLael = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 40)];
    nickLael.text = _weiboModel.user.screen_name;
    [nickLael sizeToFit];
    //箭头
    UIImageView *markView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 18, (60-13)/2, 8, 13)];
    markView.image = [UIImage imageNamed:@"sendevent_tips_failed_arrow"];
    //分割线
    UIImageView *seperateView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, ScreenWidth, 1)];
  
    seperateView.image = [UIImage imageNamed:@"userinfo_header_separator"];
   
    //添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap:)];
    [tableViewHeaderView addGestureRecognizer:gesture];
    [gesture release];
   //微博视图
    float h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:YES];
    WeiboView *weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(10, tabbarView.height+10, ScreenWidth - 20, h)];
    weiboView.isDetail = YES;
    weiboView.weiboModel = _weiboModel;
    

    [tabbarView addSubview:seperateView];
    [seperateView release];
    [tabbarView addSubview:markView];
    [markView release];
    [tabbarView addSubview:imageView];
    [imageView release];
    [tabbarView addSubview:nickLael];
    [nickLael release];
    [tableViewHeaderView addSubview:tabbarView];
    [tabbarView release];
    [tableViewHeaderView addSubview:weiboView];
    [weiboView release];
    tableViewHeaderView.height += (h+10);
    tableViewHeaderView.height += 60;
    self.tableView = [[CommentTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44) style:UITableViewStylePlain];
    self.tableView.tableHeaderView = tableViewHeaderView;
    [self.view addSubview:self.tableView];
}
- (void)headerTap:(UITapGestureRecognizer *)gesture
{
    UserInfoViewController *userVc = [[UserInfoViewController alloc]init];
    userVc.nickName = _weiboModel.user.screen_name;
    [self.navigationController pushViewController:userVc animated:YES];
    [userVc release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self loadCommentData];
    self.tableView.eventDelegate = self;
}

- (void)loadCommentData
{
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:weiboId forKey:@"id"];
    [self.sinaWeibo requestWithURL:@"comments/show.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(NSDictionary *ret){
                                 [self loadDataFinish:ret];
    }];
}
- (void)loadDataFinish:(NSDictionary *)ret
{
    NSArray *array = [ret objectForKey:@"comments"];
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
       CommentModel  *model = [[CommentModel alloc] initWithDataDic:dic];
        [comments addObject:model];
        [model release];
    }
    if (comments.count>0) {
        CommentModel *topModel = [comments objectAtIndex:0];
        NSNumber *topId = topModel.id;
        self.topWeiboId = [topId stringValue];
        
        CommentModel *lastModel = [comments lastObject];
        NSNumber *lastId = lastModel.id;
        self.lastWeiboId = [lastId stringValue];
    }
    if (comments.count>=20) {
        self.tableView.isMore = YES;
    }
    else
    {
        self.tableView.isMore = NO;
    }
    self.tableView.data = comments;
    self.weiboDataArray = comments;
    self.tableView.commentModel = ret;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
#pragma mark - pulldown data -
- (void)pullDownDataFinish:(id)result
{
    NSArray *statues = [result objectForKey:@"comments"];
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        CommentModel *weibo =[[CommentModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    // 拼接刷新的数据到微博的数组
    [weibos addObjectsFromArray:self.weiboDataArray];
    if (statues.count>0) {
        
        
        CommentModel *weibo = [weibos objectAtIndex:0];
        self.topWeiboId = [weibo.id stringValue];
        NSLog(@"topweiboId = %d",[self.topWeiboId integerValue]);
        
        
    }
    self.weiboDataArray = weibos;
    self.tableView.data = weibos;
    //刷新
    [self.tableView reloadData];
    [self.tableView doneLoadingTableViewData];
    
    NSLog(@"更新微博数 %d",statues.count);
   // [self upDateWeiboCount:statues.count];
}

- (void)pullDownData
{
    //重新获取数据
    if (self.topWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:weiboId,@"id",@"20",@"count",self.topWeiboId,@"since_id", nil];
    [self.sinaWeibo requestWithURL:@"comments/show.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result) {
                                 [self pullDownDataFinish:result];
                             }];
}
#pragma mark - pull up data -
- (void)pullUpDataFinish:(NSDictionary*)result
{
    NSArray *statues = [result objectForKey:@"comments"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        CommentModel *weibo =[[CommentModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    // 拼接刷新的数据到微博的数组
    [self.weiboDataArray addObjectsFromArray:weibos];
    self.tableView.data = self.weiboDataArray;
    if (statues.count>=50) {
        self.tableView.isMore = YES;
    }
    else
    {
        self.tableView.isMore = NO;
    }
    if (statues.count>0) {
        CommentModel *weibo = [weibos lastObject];
        self.lastWeiboId = [weibo.id stringValue];
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
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:weiboId,@"id",@"20",@"count",self.lastWeiboId,@"max_id", nil];
    [self.sinaWeibo requestWithURL:@"comments/show.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result) {
                                 [self pullUpDataFinish:result];
                             }];
}
#pragma mark - BaseTableView delegaate -
- (void)pullDown:(BaseTableView*)tableView
{
    [self pullDownData];
}
- (void)pullUp:(BaseTableView*)tableView
{
    [self pullUpData];
}
- (void)tableView:(BaseTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
