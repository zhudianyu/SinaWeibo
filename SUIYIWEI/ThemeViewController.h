//
//  ThemeViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, retain) NSArray *themes;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
