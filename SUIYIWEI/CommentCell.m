//
//  CommentCell.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "UserInfoViewController.h"
@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}
-(void)dealloc
{
    [_commentModel release];
    [_userView release];
    [_timeLabel release];
    [_nickLabel release];
    [_commentLabel release];
    [super dealloc];
}
- (void)initView
{
    _userView = (ZDYImageView*)[self viewWithTag:100];
    if (_userView == nil) {
        _userView = [[ZDYImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        _userView.tag = 100;
        _userView.layer.cornerRadius = 5;
        _userView.layer.masksToBounds = YES;
        [self addSubview:_userView];
        
    }
    
    _timeLabel = (UILabel*)[self viewWithTag:101];
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 100, 20)];
        _timeLabel.tag = 101;
        [self addSubview:_timeLabel];
        
    }
    
    _nickLabel = (UILabel*)[self viewWithTag:102];
    if (_nickLabel == nil) {
        _nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
        _nickLabel.tag = 102;
        [self addSubview:_nickLabel];
        
    }
    
    _commentLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    _commentLabel.font = [UIFont systemFontOfSize:14.0f];
    _commentLabel.delegate = self;
    _commentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    _commentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color" ];
    [self.contentView addSubview:_commentLabel];
    
}
- (void)setCommentModel:(CommentModel *)commentModel
{
    if (_commentModel != commentModel) {
        [_commentModel release];
        _commentModel = [commentModel retain];
    }
    __block CommentCell *this = self;
    //防止循环引用
    _userView.imageBlock = ^{
        NSString *nickName = self.commentModel.user.screen_name;
        UserInfoViewController *userVc = [[UserInfoViewController alloc]init];
        userVc.nickName = nickName;
        [this.uiviewController.navigationController pushViewController:userVc animated:YES];
        [userVc release];
    };
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *urlString = self.commentModel.user.profile_image_url;
    [_userView setImageWithURL:[NSURL URLWithString:urlString]];
    
    _nickLabel.text = self.commentModel.user.screen_name;
    _timeLabel.text = [UIUtils fomateString:self.commentModel.created_at];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    _timeLabel.font = [UIFont systemFontOfSize:14.0];
    [_nickLabel sizeToFit];
    
    NSString *commentText = self.commentModel.text;
    commentText = [UIUtils parseTextWithRegex:commentText];
    _commentLabel.text = commentText;
    
    
    _commentLabel.height = [_commentLabel optimumSize].height;
    
    _commentLabel.frame = CGRectMake(_userView.right + 10, _nickLabel.bottom +10, 240, 200);
    
}

+(float)getCommentHeight:(CommentModel *)commentModel
{
    RTLabel *rt = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font = [UIFont systemFontOfSize:14.0];
    rt.text = commentModel.text;
    return rt.optimumSize.height +10;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - rtlabel delegate -
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
}
@end
