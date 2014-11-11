//
//  WeiboCell.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-22.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboModel;
@class WeiboView;
@interface WeiboCell : UITableViewCell
{
    ZDYImageView    *_userImage; //用户头像视图
    UILabel         *_nickLabel; //昵称
    UILabel         *_repostCountLabel; //转发数
    UILabel         *_commentLabel;     //回复数
    UILabel         *_sourceLabel;      //发布来源
    UILabel         *_createLabel;      //发布时间
}

@property(nonatomic,retain)WeiboView    *weiboView;
@property(nonatomic,retain)WeiboModel   *weiboModel;

@end
