//
//  ThemeImageView.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-14.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}
-(id)initWithImageName:(NSString *)imageName highLightImageName:(NSString *)highLightName
{
    if (self = [self init]) {
        self.imageName = imageName;
    }
    return self;
}
- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}
- (void)loadThemeImage
{
    if (self.imageName == nil) {
        return;
    }
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:_imageName];
    [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
    self.image = image;
}
#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    [self loadThemeImage];
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
