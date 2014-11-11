//
//  WeiboView.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-22.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "WeiboView.h"
#import "UIControlFactory.h"
#import "ThemeImageView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "UserInfoViewController.h"
#import "WebViewController.h"
@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    
    _textLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0];
    
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color" ];
    [self addSubview:_textLabel];
    
    //微博图片
    _image = [[UIImageView alloc]initWithFrame:CGRectZero];
    _image.backgroundColor = [UIColor clearColor];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:_image];
    
    //转发微博
    _repostBackgroudView = [UIControlFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image = [_repostBackgroudView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10    ];
    _repostBackgroudView.image = image;
    _repostBackgroudView.leftCapWidth = 25;
    _repostBackgroudView.topCapHeight = 10;
    _repostBackgroudView.backgroundColor = [UIColor clearColor];
    
    [self insertSubview:_repostBackgroudView atIndex:0];
    _parseText = [[NSMutableString alloc] init];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel
{
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        _repostView.isDetail = self.isDetail;
        [self addSubview:_repostView];
    }
    [self parseLink];
}
#pragma mark - 解析超链接 -
- (void)parseLink
{
    [_parseText setString:@""];
    //判断是否转发
    if (_isRepost) {
        //拼接原微博的作者
        NSString *nickName = _weiboModel.user.screen_name;
        NSString *endcoingName = [nickName URLEncodedString];
        NSString *urlName = [NSString stringWithFormat:@"<a href='user'://%@'>%@</a>:",endcoingName,nickName];
        [_parseText appendString:urlName];
    }
    NSString *linkText = _weiboModel.text;

    linkText = [UIUtils parseTextWithRegex:linkText];
    [_parseText appendString:linkText];
}
- (void)renderLabel
{
    _textLabel.frame = CGRectMake(0, 0, self.width, 20);
    
    if (self.isRepost) {
        _textLabel.frame = CGRectMake(10, 10, self.width-20, 0);
    }
    
    _textLabel.text = _parseText;
    CGSize textSize = _textLabel.optimumSize;
    _textLabel.height = textSize.height;
}
- (void)renderRepostView
{
    WeiboModel *repostWeibo = _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.hidden = NO;
        _repostView.weiboModel = repostWeibo;
        
        float height = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width, height);
        
    }
    else
    {
        _repostView.hidden = YES;
    }
}
- (void)renderWeiboImage
{
    if (self.isDetail)
    {
        //中等图
        NSString *middleImage = _weiboModel.bmiddleImage;
        if (middleImage != nil &&![@"" isEqualToString:middleImage]) {
            _image.hidden = NO;
            _image.frame = CGRectMake(10, _textLabel.bottom+10, 280, 200);
            [_image setImageWithURL:[NSURL URLWithString:middleImage]];
            
        }
        else
        {
            _image.hidden = YES;
        }
        
    }
    else
    {
        int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kImageMode];
        if (mode == LARGE_BROWSE)
        {
            NSString *bmiddleImage = _weiboModel.bmiddleImage;
            if (bmiddleImage != nil &&![@"" isEqualToString:bmiddleImage]) {
                _image.hidden = NO;
                _image.frame = CGRectMake(10, _textLabel.bottom+10, self.width - 20, 180);
                [_image setImageWithURL:[NSURL URLWithString:bmiddleImage]];
                
            }
            else
            {
                _image.hidden = YES;
            }
        }
        else
        {
        //缩略图
            NSString *thumbnailImage = _weiboModel.thumbnailImage;
            if (thumbnailImage != nil &&![@"" isEqualToString:thumbnailImage]) {
                _image.hidden = NO;
                _image.frame = CGRectMake(10, _textLabel.bottom+10, 70, 80);
                [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
                
            }
            else
            {
                _image.hidden = YES;
            }
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self renderLabel];
    
    
    
    //转发的微博视图

    [self renderRepostView];
    //微博视图的图片
    [self renderWeiboImage];
    
    //转发的视图微博背景
    if (self.isRepost) {
        _repostBackgroudView.frame = self.bounds;
        _repostBackgroudView.hidden = NO;
        
    }
    else
    {
        _repostBackgroudView.hidden = YES;
    }
}


//获取字体大小
+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost
{
    float fontSize = 14.0f;
    
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }
    else if(!isDetail && isRepost) {
        return LIST_REPOST_FONT;
    }
    else if(isDetail && !isRepost) {
        return DETAIL_FONT;
    }
    else if(isDetail && isRepost) {
        return DETAIL_REPOST_FONT;
    }
    
    return fontSize;
}

//获取微博视图的高度

+(CGFloat)getWeiboViewHeight:(WeiboModel*)weiboModel
                    isRepost:(BOOL)isRepost
                    isDetail:(BOOL)isDetail
{
    float height = 0;
    
    //计算微博内容的高度
    
    RTLabel *textLabel = [[[RTLabel alloc]initWithFrame:CGRectZero] autorelease];
    float fontSize = [self getFontSize:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontSize];
    if (isDetail) {
        textLabel.width = kWeibo_Width_Detail;
    }
    else
    {
        textLabel.width = kWeibo_Width_List;
    }
    NSString *weiboText = nil;
    if (isRepost) {
        textLabel.width -= 20;
        NSString *nickLable = weiboModel.user.screen_name;
        weiboText = [NSString stringWithFormat:@"%@:%@",nickLable,weiboModel.text];
    }
    else
    {
        weiboText = weiboModel.text;
    }
    textLabel.text = weiboText;
    height += textLabel.optimumSize.height;
    
    //计算微博图片的高度
    if (isDetail)
    {
        //中图
        NSString *middleImage = weiboModel.bmiddleImage;
        if (middleImage != nil &&![@"" isEqualToString:middleImage]) {
            height += (kWeibo_Detail_Height_Image+kWeibo_Height_Interval);
        }
    }
    else
    {
        int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kImageMode];
        if (mode == LARGE_BROWSE)
        {
            NSString *bmiddleImage = weiboModel.bmiddleImage;
            if (bmiddleImage != nil &&![@"" isEqualToString:bmiddleImage]) {
                height += (180+kWeibo_Height_Interval);
            }
        }
        else
        {
        //缩略图
        
            NSString *thumbnailImage = weiboModel.thumbnailImage;
            if (thumbnailImage != nil &&![@"" isEqualToString:thumbnailImage]) {
                height += (kWeibo_Height_Image+kWeibo_Height_Interval);
            }
        }
    }
    
    //计算转发微博的高度
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo != nil) {
        float repostHeight = [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
        height += repostHeight;
    }
    if (isRepost == YES) {
        height += 30;
    }
    
    
    return height;
}
#pragma mark -rtlabel delegate -
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{

    NSString *absoluteString = [url absoluteString];
    if ([absoluteString hasPrefix:@"user"]) {
        NSString *host = [url host];
        NSString *hostDecoding = [host URLDecodedString];
        NSLog(@" user :%@",hostDecoding);
        //利用事件循环通信
        UserInfoViewController *userVc = [[UserInfoViewController alloc]init];
        userVc.nickName = hostDecoding;
        [self.uiviewController.navigationController pushViewController:userVc animated:YES];
        [userVc release];

    }
    else if ([absoluteString hasPrefix:@"topic"])
    {
        NSString *host = [url host];
        NSString *hostDecoding = [host URLDecodedString];
        NSLog(@" topic :%@",hostDecoding);
    
    }
    else if ([absoluteString hasPrefix:@"http"])
    {
      
        NSLog(@" http :%@",[absoluteString URLDecodedString]);
        WebViewController *webVc = [[WebViewController alloc]initWithUrl:[absoluteString URLDecodedString]];
        [self.uiviewController.navigationController pushViewController:webVc animated:YES];
        
    }
}
@end
