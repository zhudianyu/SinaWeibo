//
//  MoreViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeViewController.h"
#import "ImgeBrowseViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"More", @"更多");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //tableView 设置委托和数据源
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

#pragma mark - tableView delegate -

#pragma mark - UITableViewDataSource -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"主题";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"图片浏览模式";
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ThemeViewController *themeCtrl = [[ThemeViewController alloc]init];
        [self.navigationController pushViewController:themeCtrl animated:YES];
    
        [themeCtrl release];
    }
    else if (indexPath.row == 1)
    {
        ImgeBrowseViewController *imageCtrl = [[ImgeBrowseViewController alloc]init];
        [self.navigationController pushViewController:imageCtrl animated:YES];
        [imageCtrl release];
    }
}
@end
