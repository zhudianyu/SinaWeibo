//
//  ThemeViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "UIControlFactory.h"
#define  TABLEVIEW_LABEL_TAG 1000
@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.themes = [[ThemeManager shareInstance].themePlistDic allKeys];
        self.title = @"主题切换";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_themes release];
    [_tableView release];
    [super dealloc];
}

#pragma mark - tableView delegate -
//切换主题
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *themeName = self.themes[indexPath.row];
    if ([themeName isEqualToString:@"default"]) {
        themeName = nil;
    }
    
    
    [ThemeManager shareInstance].themeName = themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationThemeChange object:themeName];
    
    //保存主题
    
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [tableView reloadData];
}
#pragma mark - UITableViewDataSource -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.themes.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    
        ThemeLabel *label = [UIControlFactory createThemeLabel:kThemeListLabel];
        label.tag = TABLEVIEW_LABEL_TAG;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.frame = CGRectMake(10, 10, 200, cell.frame.size.height-20);
        [cell.contentView addSubview:label];
    }
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:TABLEVIEW_LABEL_TAG];
    
    NSString * text = self.themes[indexPath.row];
    label.text = text;
    
    NSString *themeName = [ThemeManager shareInstance].themeName;
    if (themeName == nil) {
        themeName = @"default";
    }
    
    if ([themeName isEqualToString:text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}

@end
