//
//  ImgeBrowseViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-2.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"

@interface ImgeBrowseViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
