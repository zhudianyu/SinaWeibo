//
//  BaseTableView.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-25.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];

    }
    return self;    
}
- (void)dealloc
{
    [_moreButton release];

    [super dealloc];
}
- (void)awakeFromNib
{
    [self initView];
}
- (void)initView
{
    _egoRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _egoRefreshView.delegate = self;
    
    
    self.dataSource = self;
    self.delegate = self;
    self.isRefresh = YES;
    _egoRefreshView.backgroundColor = [UIColor clearColor];
    
    //上拉刷新
    _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    _moreButton.backgroundColor = [UIColor whiteColor];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIActivityIndicatorView *actiView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actiView.frame = CGRectMake(100, 10, 20, 20);
    [actiView stopAnimating];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton addSubview:actiView];
    actiView.tag = 2013;
    [actiView release];
    self.tableFooterView = _moreButton;

}
-(void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    if (_isRefresh) {
        [self addSubview:_egoRefreshView];
    }
    else
    {
        if ([_egoRefreshView superview]) {
            [_egoRefreshView removeFromSuperview];
        }
    }
}

- (void)refreshData
{
    [_egoRefreshView refreshLoading:self];
}
#pragma mark - 上拉 -
- (void)loadMoreAction
{
    [self startAnimating];
    [self.eventDelegate pullUp:self];
}
- (void)startAnimating
{
    UIActivityIndicatorView *actiView = (UIActivityIndicatorView*)[_moreButton viewWithTag:2013];
    [actiView startAnimating];
    
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    [_moreButton setEnabled:NO];
}
- (void)stopAnimating
{
    
    if (self.data.count > 0)
    {
        
        UIActivityIndicatorView *actiView = (UIActivityIndicatorView*)[_moreButton viewWithTag:2013];
        [actiView stopAnimating];
        
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        [_moreButton setEnabled:YES];
        [_moreButton setHidden:NO];
        if (!self.isMore)
        {
            [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
            [_moreButton setEnabled:NO];
        }
        
    }
    else
    {
        [_moreButton setHidden:YES];
    }


}
- (void)reloadData
{
    [super reloadData];
    [self stopAnimating];
}
#pragma mark - tableview datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [_eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData
{
	_reloading = NO;
	[_egoRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_egoRefreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	

	[_egoRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    
    if (!self.isMore) {
        return;
    }
    float offset = scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    float sub = contentHeight- offset;
    if (scrollView.height - sub >10) {
        [self startAnimating];
        if ([_eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [_eventDelegate pullUp:self];
        }
    }
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    if ([_eventDelegate respondsToSelector:@selector(pullDown:)]) {
        
        [_eventDelegate pullDown:self];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


@end
