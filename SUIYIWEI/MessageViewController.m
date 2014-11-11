//
//  MessageViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "MessageViewController.h"
#import "UIFaceView.h"
#import "UIFaceScrollView.h"
#import "WeiboModel.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
         self.title = NSLocalizedString(@"Message", @"消息");
    }
    return self;
}
- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    _tableView = [[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44-49)];
    [self.view addSubview:_tableView];
    _tableView.eventDelegate = self;
    [self loadAtWeiboData];
}

-(void)initView
{
    NSArray *messageBtn = [NSArray arrayWithObjects:@"navigationbar_mentions.png",@"navigationbar_comments.png",
                           @"navigationbar_messages.png",@"navigationbar_notice.png", nil];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    for (int i = 0; i<messageBtn.count; i++) {
        NSString *imageName = [messageBtn objectAtIndex:i];
        UIButton *btn = [UIControlFactory createButton:imageName highlighted:imageName];
        btn.showsTouchWhenHighlighted = YES;
        btn.frame = CGRectMake(50*i , 10, 22, 22);
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
    }
    self.navigationItem.titleView = [titleView autorelease];
}
- (void)messageAction:(UIButton*)btn
{
    if (btn.tag == 100)
    {
        //@me
        [self loadAtWeiboData];
    }
    else if (btn.tag == 101)
    {
        //评论
    }
    else if (btn.tag == 102)
    {
        //消息
        
    }
    else
    {
        //系统通知
        
    }
}
#pragma mark - load at data -
- (void)loadAtWeiboData
{
    [self.sinaWeibo requestWithURL:@"statuses/mentions.json" params:nil httpMethod:@"GET" block:^(id result) {
        [self loadAtWeiboDataFinish:result];
    }];
}

- (void)loadAtWeiboDataFinish:(NSDictionary *)result
{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statusDic in statues) {
        WeiboModel *weibo =[[WeiboModel alloc]initWithDataDic:statusDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    _tableView.data = weibos;
    [_tableView reloadData];
}

- (void)pullDown:(BaseTableView*)tableView
{
    
}
- (void)pullUp:(BaseTableView*)tableView
{
    
}
- (void)tableView:(BaseTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
