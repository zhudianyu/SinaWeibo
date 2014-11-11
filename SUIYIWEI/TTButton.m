//
//  TTButton.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "TTButton.h"

@implementation TTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:@"userinfo_apps_background"] forState:UIControlStateNormal];
//        self.subTitle = @"sub";
//        self.title = @"main";
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    if (_title != title) {
        [_title release];
        _title = [title copy];
    }
    [self setTitle:nil forState:UIControlStateNormal];
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
     
        [self addSubview:_titleLabel];
    }
}

- (void)setSubTitle:(NSString *)subTitle
{
    if (_subTitle != subTitle) {
        [_subTitle release];
        _subTitle = [subTitle copy];
    }
    [self setTitle:nil forState:UIControlStateNormal];
    
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
     
        [self addSubview:_subTitleLabel];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(15, 10, self.width -15, self.height/2-10);
    _subTitleLabel.frame = CGRectMake(15, self.height/2, self.width -15, self.height/2-20);
    _subTitleLabel.text = self.subTitle;
    _titleLabel.text = self.title;
    [_subTitleLabel sizeToFit];
    [_titleLabel sizeToFit];
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
