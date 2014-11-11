//
//  WeiboCell.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-22.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "ThemeButton.h"
#import "UIControlFactory.h"
#import "UserInfoViewController.h"
@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        // Initialization code
    }
    return self;
}
- (void)initView
{
    _userImage = [[ZDYImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor  = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;
    _userImage.layer.borderWidth = .5;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nickLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    //转发数
    _repostCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.font = [UIFont systemFontOfSize:12.0];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    //回复数
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.font = [UIFont systemFontOfSize:12.0];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    
    //微博来源

    _sourceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.font = [UIFont systemFontOfSize:12.0];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    //发布时间
    _createLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.font = [UIFont systemFontOfSize:12.0];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    //设置cell的选中背景颜色
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    selectView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator"]];
    self.selectedBackgroundView = selectView;
    [selectView release];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString* userImageUrl = _weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    //昵称
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weiboModel.user.screen_name;
    
    //微博视图
    _weiboView.weiboModel = _weiboModel;
    float h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom+10, kWeibo_Width_List, h);
    //是微博view重新布局 兼容5.1的模拟器
    
    [_weiboView setNeedsLayout];
    
    
    NSString *weiboDate = _weiboModel.createDate;
    //Sat Jan 12 11:50:16 +0800 2013
    //E M d HH:mm:ss Z yyyy
    if (weiboDate != nil) {
        _createLabel.hidden = NO;
        NSDate *createDate = [UIUtils dateFromFomate:weiboDate formate:@"E M d HH:mm:ss Z yyyy"];
        NSString *stringFormat  = [UIUtils stringFromFomate:createDate formate:@"MM-dd mm:ss"];
        _createLabel.text = stringFormat;
        _createLabel.frame = CGRectMake(50, self.height-20, 100, 20);
        [_createLabel sizeToFit];
    }
    else
    {
        _createLabel.hidden = YES;
    }
    //微博来源
    NSString *source = _weiboModel.source;
    NSString *ret = [self parseSource:source];
    if (ret != nil) {
        _sourceLabel.text = [NSString stringWithFormat:@"来源%@",ret];
        _sourceLabel.frame = CGRectMake(_createLabel.right+8, _createLabel.top, 100, 20);
        [_sourceLabel sizeToFit];
        [_sourceLabel setHidden:NO];
    }
    else
    {
        [_sourceLabel setHidden:YES];
    }
    
    //评论数
    NSNumber *commentsCount = _weiboModel.commentsCount;
    NSString *commentStr = [NSString stringWithFormat:@"%@",commentsCount];
    _commentLabel.text = commentStr;
    _commentLabel.frame = CGRectMake(self.width -30, _nickLabel.top, 10, 10);
    [_commentLabel sizeToFit];
    ThemeButton *commentButton = [UIControlFactory createButton:@"timeline_comment_count_icon.png" highlighted:@"timeline_comment_count_icon.png"];
    commentButton.frame = CGRectMake(_commentLabel.left-12, _commentLabel.top, 12, 12);
    
    [self addSubview:commentButton];
    //转发
    NSNumber *repostCount = _weiboModel.repostsCount;
    NSString *repostStr = [NSString stringWithFormat:@"%@",repostCount];
    _repostCountLabel.text = repostStr;
    _repostCountLabel.frame = CGRectMake(commentButton.left -30, _nickLabel.top, 10, 10);
    [_repostCountLabel sizeToFit];
    //timeline_retweet_count_icon
    ThemeButton *repostButton = [UIControlFactory createButton:@"timeline_retweet_count_icon.png" highlighted:@"timeline_retweet_count_icon.png"];

    repostButton.frame = CGRectMake(_repostCountLabel.left-12, _repostCountLabel.top, 12, 12);
    [self addSubview:repostButton];
    

}
- (void)setWeiboModel:(WeiboModel *)weiboModel
{
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    __block WeiboCell *this = self;
    //防止循环引用
    _userImage.imageBlock = ^{
        NSString *nickName = self.weiboModel.user.screen_name;
        UserInfoViewController *userVc = [[UserInfoViewController alloc]init];
        userVc.nickName = nickName;
        [this.uiviewController.navigationController pushViewController:userVc animated:YES];
        [userVc release];
    };
}
//解析源地址
- (NSString*)parseSource:(NSString *)source
{
    NSString *regex = @">\\w+<";
    NSArray *array = [source componentsMatchedByRegex:regex];
    if (array.count>0) {
        NSString* str = [array objectAtIndex:0];
        NSRange range ;
        range.location = 1;
        range.length = str.length -2;
        NSString * resultStr = [str substringWithRange:range];
        return resultStr;
    }
    return nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
