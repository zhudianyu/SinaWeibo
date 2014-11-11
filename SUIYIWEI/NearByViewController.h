//
//  NearByViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-7.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
typedef void(^SelectBlock)(NSDictionary *dic);
@interface NearByViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    
}
@property (copy, nonatomic)  SelectBlock selectBlock;
@property (retain, nonatomic) NSArray  *locationData;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
