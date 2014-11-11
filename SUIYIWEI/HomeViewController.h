//
//  HomeViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WeiboTableView.h"
@class ThemeImageView;
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDeletate>
{
    ThemeImageView                     *_updateWeiboView;
}
@property (retain, nonatomic)  WeiboTableView *tableView;
@property (nonatomic, retain)  NSArray        *data;
@property (nonatomic, retain)  NSMutableArray *weiboDataArray;
@property (nonatomic, copy)    NSString       *topWeiboId;
@property (nonatomic, copy)    NSString       *lastWeiboId;

- (void)autoRefreshData;
- (void)loadWeiboData;
@end
