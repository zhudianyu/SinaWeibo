//
//  NearByViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-7.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "NearByViewController.h"
#import "UIImageView+WebCache.h"
#import "ZDYDataService.h"
@interface NearByViewController ()

@end

@implementation NearByViewController

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
    UIButton * cancleBtn = [UIControlFactory createNavigationBarButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(sendCancle)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
    [cancleBtn release];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    self.title = @"我在这里";
    CLLocationManager *locaMan = [[CLLocationManager alloc]init];
    locaMan.delegate = self;
    [locaMan setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locaMan startUpdatingLocation];
    
}
- (void)refreshUI
{
    [self.tableView reloadData];
}
- (void)loadNearbyDataFinish:(NSDictionary *)result
{
    NSArray *array = [result objectForKey:@"pois"];
    self.locationData = array;
    
    [self refreshUI];
}
- (void)sendCancle
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - location delegate -
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];//停止查找
    if (self.locationData == nil) {
        
        float longitude = newLocation.coordinate.longitude;
        float latitude = newLocation.coordinate.latitude;
        NSString *longitudeString = [NSString stringWithFormat:@"%f",longitude];//经度
        NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];//纬度
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitudeString,@"long",latitudeString,@"lat", nil];
//        [ZDYDataService requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"POST" completeBlock:^(id result) {
//            [self loadNearbyDataFinish:result];
//        }];
        [self.sinaWeibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"POST" block:^(id restult) {
            [self loadNearbyDataFinish:restult];
        }];
    }
    
}
#pragma mark - tableview delegate - 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.locationData[indexPath.row];
    _selectBlock(dic);
    Block_release(_selectBlock);
    [self sendCancle];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locationData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idIdentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idIdentify] autorelease];
    }
    NSDictionary *dic = self.locationData[indexPath.row];
    
    NSString *title = [dic objectForKey:@"title"];
    NSString *address = [dic objectForKey:@"address"];
    NSString *iconUrl = [dic objectForKey:@"icon"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = address;
    [cell.imageView setImageWithURL:[NSURL URLWithString:iconUrl]];
    return cell;
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
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
