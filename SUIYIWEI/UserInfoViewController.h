//
//  UserInfoViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
@class UserInfoView;
@class WeiboTableView;
@interface UserInfoViewController : BaseViewController<UITableViewEventDeletate>
{
    UserInfoView   *_userView;
    NSMutableArray *_requests;
}
@property (nonatomic, assign) WeiboTableView *tableView;
@property (nonatomic, copy) NSString *nickName;
@end
