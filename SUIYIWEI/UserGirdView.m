//
//  UserGirdView.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UserGirdView.h"
#import "UIButton+WebCache.h"
#import "UserInfoViewController.h"
@implementation UserGirdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}
-(void)initView
{
    UIView *gridView = [[[NSBundle mainBundle] loadNibNamed:@"UserGirdView" owner:self options:nil]lastObject];
    [self addSubview:gridView];
    self.size = gridView.size;
    gridView.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:@"profile_button3_1"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = self.bounds;
    
    [self insertSubview:imageView atIndex:0];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //昵称
    self.nickLabel .text = _userModel.screen_name;
    //粉丝数目
    NSNumber *fansCount = self.userModel.followers_count;
    NSString *fansStr = nil;
    long f = [fansCount floatValue];
    if (f>10000) {
        fansStr = [NSString stringWithFormat:@"%ld万",f/10000];
    }
    else
    {
        fansStr = [NSString stringWithFormat:@"%@",fansCount];
    }
    self.fansLabel.text = fansStr;
    //用户头像url
    NSString *urlString = self.userModel.profile_image_url;
    
    [self.userImageBtn setImageWithURL:[NSURL URLWithString:urlString]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_userImageBtn release];
    [_nickLabel release];
    [_fansLabel release];
    [super dealloc];
}
- (IBAction)userImageAction:(id)sender
{
    UserInfoViewController *userinfoVc = [[UserInfoViewController alloc]init];
    userinfoVc.nickName = self.userModel.screen_name;
    [self.uiviewController.navigationController pushViewController:userinfoVc animated:YES];
    [userinfoVc release];
}
@end
