//
//  UserInfoView.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UserInfoView.h"
#import "TTButton.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "FriendShipViewController.h"
#define INFO_BUTTON_WIDTH 70
#define INFO_BUTTON_HEIGHT 57
@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)dealloc
{
    self.userImage = nil;
    self.nickLabel = nil;
    self.addrLabel = nil;
    self.userIntroLabel = nil;
    self.attentionBtn = nil;
    self.fansBtn = nil;
    self.infomationBtn = nil;
    self.moreBtn = nil;
    [super dealloc];
}
- (void)initView
{
    _userImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    _nickLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _addrLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _userIntroLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _totalLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    
    _attentionBtn = [[TTButton alloc]initWithFrame:CGRectZero];
    _fansBtn = [[TTButton alloc]initWithFrame:CGRectZero];
    _infomationBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    _moreBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    
    [self addSubview:_userImage];
  
    [self addSubview:_nickLabel];
  
    [self addSubview:_addrLabel];
   
    [self addSubview:_userIntroLabel];
    
    [self addSubview:_totalLabel];
    
    
    [self addSubview:_attentionBtn];
   
    [self addSubview:_fansBtn];
  
    [self addSubview:_infomationBtn];
   
    [self addSubview:_moreBtn];
  
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _userImage.frame = CGRectMake(0, 5, 80, 80);
    NSString *urlStr = self.user.avatar_large;
    [_userImage setImageWithURL:[NSURL URLWithString:urlStr]];
    
    _nickLabel.frame = CGRectMake(85, 5, 200, 20);
    [_nickLabel setText:self.user.screen_name];
    
    
    _addrLabel.frame = CGRectMake(85, 30, 200, 20);
    NSString *sex = self.user.gender;
    if ([sex isEqualToString:@"m"]) {
        sex = @"男 ";
    }
    else
    {
        sex = @"女 " ;
    }
    NSString *location = nil;
    if (self.user.location.length == 0) {
       location = @"";
    }
    else
    {
        location = self.user.location;
    }
    [_addrLabel setText:[NSString stringWithFormat:@"%@%@",sex,location]];
    
    _userIntroLabel.frame = CGRectMake(85, 55, 200, 25);
 
    NSString *info = self.user.description;
    info = [NSString stringWithFormat:@"%@",info];
    [_userIntroLabel setText:info];
    _addrLabel.font = [UIFont systemFontOfSize:14.0];
    _userIntroLabel.font = [UIFont systemFontOfSize:14.0];
   
    _userIntroLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_userIntroLabel sizeToFit];

    
    _attentionBtn.frame = CGRectMake(5, 90, INFO_BUTTON_WIDTH, INFO_BUTTON_HEIGHT);
    NSNumber *attCount = self.user.friends_count;
    [_attentionBtn setTitle:[attCount stringValue]];
    [_attentionBtn setSubTitle:@"关注"];
    [_attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _fansBtn.frame = CGRectMake(5+INFO_BUTTON_WIDTH+10, 90, INFO_BUTTON_WIDTH, INFO_BUTTON_HEIGHT);
    NSNumber *fansCount = self.user.followers_count;
    NSString *fansStr = nil;
    long f = [fansCount floatValue];
    if (f>10000) {
        fansStr = [NSString stringWithFormat:@"%ld万",f/10000];
    }
    else
    {
        fansStr = [NSString stringWithFormat:@"%@",fansCount];
    }
    [_fansBtn setTitle:fansStr];
    [_fansBtn setSubTitle:@"粉丝"];
    [_fansBtn addTarget:self action:@selector(fansBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _infomationBtn.frame = CGRectMake(5+(INFO_BUTTON_WIDTH+10)*2, 90, INFO_BUTTON_WIDTH, INFO_BUTTON_HEIGHT);
    [_infomationBtn setTitle:@"资料" forState:UIControlStateNormal];
    [_infomationBtn setBackgroundImage:[UIImage imageNamed:@"userinfo_apps_background"] forState:UIControlStateNormal];
    _infomationBtn.titleLabel.textColor = [UIColor blackColor];
    
    _moreBtn.frame = CGRectMake(5+(INFO_BUTTON_WIDTH+10)*3, 90, INFO_BUTTON_WIDTH, INFO_BUTTON_HEIGHT);
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];

    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"userinfo_apps_background"] forState:UIControlStateNormal];
    _moreBtn.titleLabel.textColor = [UIColor blackColor];
    _totalLabel.frame = CGRectMake(0, 150, ScreenWidth, 20);
    [_totalLabel setText:[NSString stringWithFormat:@"共%@条微博",self.user.statuses_count]];
   

    
}
- (void)fansBtnAction
{
    FriendShipViewController *friendShipVc = [[FriendShipViewController alloc]init];
    friendShipVc.userModel = self.user;
    friendShipVc.type = Fans;
    [self.uiviewController.navigationController pushViewController:friendShipVc animated:YES];
    [friendShipVc release];
}
- (void)attentionAction:(UIButton *)btn
{
    FriendShipViewController *friendShipVc = [[FriendShipViewController alloc]init];
    friendShipVc.userModel = self.user;
    friendShipVc.type = Attention;
    [self.uiviewController.navigationController pushViewController:friendShipVc animated:YES];
    [friendShipVc release];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
