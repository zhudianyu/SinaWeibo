//
//  ThemeManager.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
{
    
}
@property(nonatomic,retain) NSString               *themeName;//主题名称
@property(nonatomic,retain) NSDictionary           *themePlistDic; //主题的plist文件
@property(nonatomic,retain) NSDictionary           *fontColorPlistDic;//字体颜色配置文件


+ (ThemeManager *)shareInstance;

//返回当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//返回当前主题下，字体的颜色
- (UIColor *)getColorWithName:(NSString *)name;
@end

