//
//  DetailViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CommentTableView.h"
@class WeiboView;
@class WeiboModel;
@interface DetailViewController : BaseViewController<UITableViewEventDeletate>
{
    
}
@property (retain, nonatomic)  WeiboModel *weiboModel;
@property (retain, nonatomic)  CommentTableView *tableView;
@property (nonatomic, retain)  NSArray        *data;
@property (nonatomic, retain)  NSMutableArray *weiboDataArray;
@property (nonatomic, copy)    NSString       *topWeiboId;
@property (nonatomic, copy)    NSString       *lastWeiboId;
@end
