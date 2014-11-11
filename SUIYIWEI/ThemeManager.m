//
//  ThemeManager.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ThemeManager.h"
//创建单例
static ThemeManager *singleton = nil;
@implementation ThemeManager
+ (ThemeManager *)shareInstance;
{
    
    if (singleton == nil) {
        @synchronized(self)//添加同步锁 保证原子性
        {
            singleton = [[ThemeManager alloc]init];
        }
    }
    return singleton;
}
- (id)init
{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        self.themePlistDic = [NSDictionary dictionaryWithContentsOfFile:themePath];
        self.themeName = nil;
    }
    return self;
}
#pragma mark - 单例固定写法 -
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (singleton == nil) {
            singleton = [super allocWithZone:zone];
        }
    }
    return singleton;
}
+ (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)retain
{
    return self;
}
- (unsigned)retainCount
{
    return  UINT_MAX;
}
- (oneway void)release
{
    
}
- (id)autorelease
{
    return self;
}

#pragma mark - 本类的方法 -
- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName copy];
    }
    NSString *themeDir = [self getThemePath];
    NSString *filePaht = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlistDic = [NSDictionary dictionaryWithContentsOfFile:filePaht];
}
- (NSString *)getThemePath
{
    if (self.themeName == nil) {
        //默认主题  图片是根路径
        NSString *imagePath = [[NSBundle mainBundle]resourcePath];
        return imagePath;
    }
    
    NSString *imagePath = [self.themePlistDic objectForKey:self.themeName];
    
    NSString *resourePath = [[NSBundle mainBundle]resourcePath];
    
    NSString *path = [resourePath stringByAppendingPathComponent:imagePath];
    
    return path;
}
//返回当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    NSString *imagePath = [[self getThemePath] stringByAppendingPathComponent:imageName];
    return  [UIImage imageWithContentsOfFile:imagePath];
}

//返回当前主题下，字体的颜色
- (UIColor *)getColorWithName:(NSString *)name
{
    if (name.length == 0) {
        return nil;
    }
    
    NSString *rgb = [_fontColorPlistDic objectForKey:name];
    NSArray *rgbArray = [rgb componentsSeparatedByString:@","];
    if (rgbArray.count == 3) {
        float r = [rgbArray[0] floatValue];
        float g = [rgbArray[1] floatValue];
        float b = [rgbArray[2] floatValue];
        return ColorWithRGB(r, g, b, 1);
    }
    return nil;
}

@end
