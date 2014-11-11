//
//  ThemeLabel.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-15.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(themeNotification:) name:kNotificationThemeChange object:nil];
    }
    return self;
    
}
- (id)initWithThemeColor:(NSString*)themeClolorName
{
    self = [self init];
    if (self) {
        
        if (themeClolorName == nil) {
            return nil;
        }
        self.colorName = themeClolorName;
    }
    return self;
}
- (void)setColorName:(NSString *)colorName
{
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    [self loadThemeColor];
}
- (void)loadThemeColor
{
   UIColor  *color =[[ThemeManager shareInstance ]getColorWithName:_colorName];
    self.textColor = color;
}
#pragma mark - notification action -
- (void)themeNotification:(NSNotification*)notification
{
    [self loadThemeColor];
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
