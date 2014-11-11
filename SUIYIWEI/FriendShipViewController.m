//
//  FriendShipViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "FriendShipViewController.h"

@interface FriendShipViewController ()

@end

@implementation FriendShipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.type == Attention)
    {
        self.title = @"关注";
    }
    else if (self.type == Fans)
    {
        self.title = @"粉丝";
    }
    self.data = [[NSMutableArray alloc]initWithCapacity:100];
    [self.tableView setEventDelegate:self];
    [self loadFriendShipData];
}

- (void)loadFriendShipData
{
    
    if (self.userModel.screen_name.length == 0) {
        NSLog(@"昵称为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.userModel.screen_name forKey:@"screen_name"];
    if (self.cursor != nil) {
        [params setObject:self.cursor forKey:@"cursor"];
    }
    NSString *urlString = nil;
    if (self.type == Attention) {
        
        urlString = @"friendships/friends.json";
    }
    else if(self.type == Fans)
    {
        urlString = @"friendships/followers.json";
    }
    [self.sinaWeibo requestWithURL:urlString params:params httpMethod:@"GET" block:^(id result) {
        [self loadFriendShipDataFinish:result];
    }];
}

- (void)loadFriendShipDataFinish:(NSDictionary *)result
{
    NSArray *usersArray = [result objectForKey:@"users"];
    NSMutableArray *array2D = nil;
    for (int i = 0; i<usersArray.count; i++) {
        //判断最后一个数组是否填满
        array2D = [self.data lastObject];
        if (array2D.count == 3||array2D == nil) {
            array2D = [NSMutableArray arrayWithCapacity:3];
            [self.data addObject:array2D];
        }
    NSDictionary *userDic = [usersArray objectAtIndex:i];
    
    UserModel *userModel = [[UserModel alloc] initWithDataDic:userDic];
    [array2D addObject:userModel];
    [userModel release];
    }
    
    if (usersArray.count<40)
    {
        self.tableView.isMore = NO;;
    }
    else
    {
        self.tableView.isMore = YES;
    }
    self.tableView.data = self.data;
    [self.tableView reloadData];
    //弹回下拉
    if (self.cursor == nil) {
        [self.tableView doneLoadingTableViewData];
    }
    //记录下一页的游标
    self.cursor = [[result objectForKey:@"next_cursor"] stringValue];
}
- (void)pullDown:(BaseTableView*)tableView
{
    self.cursor = nil;
    [self.data removeAllObjects];
    
    [self loadFriendShipData];
}
- (void)pullUp:(BaseTableView*)tableView
{
    [self loadFriendShipData];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_data release];
    [_userModel release];
    [_cursor release];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
