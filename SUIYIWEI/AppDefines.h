//
//  AppDefines.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#ifndef SUIYIWEI_AppDefines_h
#define SUIYIWEI_AppDefines_h



#define kAppKey @"3267729250"

#define kAppSecret   @"9189b146c20b41631858a9a9e7262752"

#define kAppRedirectURI @"https://api.weibo.com/oauth2/default.html"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//颜色
#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//图片浏览方式
#define LARGE_BROWSE 1
#define SMALL_BROWSE 2


#pragma mark - 宏定义 -
#define kNavigationBarTitleLabel @"kNavigationBarTitleLabel"
#define kThemeListLabel @"kThemeListLabel"
#define kThemeName      @"kThemeName"
#define kImageMode      @"kImageMode"

#pragma mark - 通知定义 -
#define kNotificationThemeChange @"kNotificationThemeChange"
#define kNotificationImageBrowse @"kNotificationImageBrowse"
#endif
