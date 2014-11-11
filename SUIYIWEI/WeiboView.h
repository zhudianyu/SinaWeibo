//
//  WeiboView.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-22.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#define LIST_FONT   14.0f           //列表中文本字体
#define LIST_REPOST_FONT  13.0f;    //列表中转发的文本字体
#define DETAIL_FONT  18.0f          //详情的文本字体
#define DETAIL_REPOST_FONT 17.0f    //详情中转发的文本字体

#define kWeibo_Width_List  (320-60) //微博在列表中的宽度
#define kWeibo_Width_Detail 300     //微博在详情页面的宽度
#define kWeibo_Height_Image   80     //微博图片的高度
#define kWeibo_Detail_Height_Image   280     //微博详情图片的高度
#define kWeibo_Height_Interval 10    //微博图片和微博内容的间隔高度
@class WeiboModel;
@class ThemeImageView;
@interface WeiboView : UIView<RTLabelDelegate>
{
    
    @private
    RTLabel         *_textLabel;
    UIImageView     *_image;              //微博图片
    ThemeImageView  *_repostBackgroudView;//转发的微博视图背景
    WeiboView       *_repostView;         //转发的微博视图
    NSMutableString *_parseText;
}

@property(nonatomic,retain)WeiboModel *weiboModel;

@property(nonatomic,assign)BOOL     isRepost;   //是否转发

@property(nonatomic,assign)BOOL      isDetail;  //是否详情

//获取字体大小
+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

//获取微博视图的高度

+(CGFloat)getWeiboViewHeight:(WeiboModel*)weiboModel
                    isRepost:(BOOL)isRepost
                    isDetail:(BOOL)isDetail;

@end
