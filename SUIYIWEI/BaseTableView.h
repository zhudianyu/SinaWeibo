//
//  BaseTableView.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-25.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;
@protocol UITableViewEventDeletate <NSObject>

@optional
- (void)pullDown:(BaseTableView*)tableView;
- (void)pullUp:(BaseTableView*)tableView;
- (void)tableView:(BaseTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>
{
    EGORefreshTableHeaderView    *_egoRefreshView;
    BOOL                          _reloading;
    UIButton                     *_moreButton;
}
@property (nonatomic,retain) NSArray   *data;
@property (nonatomic,assign) BOOL      isRefresh;
@property (nonatomic,assign) id<UITableViewEventDeletate> eventDelegate;
@property (nonatomic, assign)  BOOL           isMore;
- (void)doneLoadingTableViewData;
- (void)refreshData;

@end
