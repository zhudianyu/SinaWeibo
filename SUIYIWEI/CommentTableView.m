//
//  CommentTableView.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
@implementation CommentTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - tableview datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    
    }
    CommentModel *model = [self.data objectAtIndex:indexPath.row];
    cell.commentModel =  model;

  
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)] autorelease];
    
    view.backgroundColor = [UIColor whiteColor];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableview_sectionheader_bacground"]];
    
    UILabel *commentCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    commentCountLabel.font = [UIFont systemFontOfSize:14.0];
    NSNumber *num = [self.commentModel objectForKey:@"total_number"];
    NSString *commentStr = [NSString stringWithFormat:@"评论数：%@",num];
    commentCountLabel.text = commentStr;
    [view addSubview:commentCountLabel];
    [commentCountLabel release];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, ScreenWidth, 1)];
    imageView.image = [UIImage imageNamed:@"userinfo_header_separator"];
    [view addSubview:imageView];
    [imageView release];
    return view;
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel *model = [self.data objectAtIndex:indexPath.row];
 
    float h = [CommentCell getCommentHeight:model];

    return h+40;
}
@end
