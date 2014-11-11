//
//  CommentModel.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    
    UserModel *user = [[UserModel alloc]initWithDataDic:userDic];
    WeiboModel *weibo = [[WeiboModel alloc]initWithDataDic:statusDic];
    
    self.user = [user autorelease];
    self.weibo = [weibo autorelease];
}
@end
