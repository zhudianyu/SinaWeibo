//
//  MessageViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "WeiboTableView.h"
@interface MessageViewController : BaseViewController<UITableViewEventDeletate>

@property (nonatomic,assign) WeiboTableView  *tableView;
@end
