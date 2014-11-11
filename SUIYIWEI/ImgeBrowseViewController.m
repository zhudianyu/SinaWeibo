//
//  ImgeBrowseViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-2.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ImgeBrowseViewController.h"

@interface ImgeBrowseViewController ()

@end

@implementation ImgeBrowseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row == 0) {
   
        cell.textLabel.text = @"大图";
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"小图";
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int mode = -1;
    if (indexPath.row == 0) {
        mode = LARGE_BROWSE;
    }
    else if (indexPath.row == 1)
    {
        mode = SMALL_BROWSE;
    }
    
    [[NSUserDefaults standardUserDefaults]setInteger:mode forKey:kImageMode];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationImageBrowse object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
