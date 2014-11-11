//
//  FriendShipTableViewCell.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "FriendShipTableViewCell.h"
#import "UserGirdView.h"
@implementation FriendShipTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)initViews
{
    for (int i = 0; i<3; i++) {
        int tag = 2013+i;
        UserGirdView *girdView = [[UserGirdView alloc]initWithFrame:CGRectZero];
        girdView.tag = tag;
        [self.contentView addSubview:girdView];
        [girdView release];
    }
}
- (void)setData:(NSArray *)data
{
    if (_data != data) {
        [_data release];
        _data  = [data retain];
    }
    
    for (int i = 0; i<3; i++) {
        int tag = 2013+i;
        UserGirdView *view = (UserGirdView *)[self.contentView viewWithTag:tag];
        [view setHidden:YES];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.data.count; i++) {
        UserModel *userModel = [self.data objectAtIndex:i];
        int tag = 2013+i;
        UserGirdView *gridView = (UserGirdView *)[self.contentView viewWithTag:tag];
        gridView.frame = CGRectMake(100*i+12, 10, 96, 96);
        gridView.userModel = userModel;
        [gridView setHidden:NO];
        //复用view
        [gridView setNeedsLayout];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
