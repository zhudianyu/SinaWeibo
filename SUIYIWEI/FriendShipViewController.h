//
//  FriendShipViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"
#import "FriendShipTableView.h"
typedef enum
{
    Attention = 100,
    Fans
}FriendShipType;
@interface FriendShipViewController : BaseViewController<UITableViewEventDeletate>

@property (nonatomic, retain) UserModel *userModel;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, copy) NSString *cursor;
@property (nonatomic, assign) NSInteger type;
@property (retain, nonatomic) IBOutlet FriendShipTableView *tableView;
@end
