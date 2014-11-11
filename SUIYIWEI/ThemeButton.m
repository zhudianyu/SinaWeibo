//
//  ThemeButton.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton
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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(NSString *)imageName highlight:(NSString *)highlightedImageName
{
    self = [self init];
    if (self)
    {
        self.imageName = imageName;
        self.highlightImageName = highlightedImageName;
    
    }
    return self;
}

- (id)initWithBackground:(NSString *)backgroundName
     highlightBackground:(NSString*)backgroundHighlightImageName
{
    self = [self init];
    if (self) {
        self.backgroundImageName = backgroundName;
        self.backgroundHighlightImageName = backgroundHighlightImageName;
    }
    return self;
}
#pragma mark - notification action - 
- (void)themeNotification:(NSNotification*)notification
{
    [self loadThemeImage];
}
#pragma mark - 加载图片 -
- (void)loadThemeImage
{
    ThemeManager *themeMan = [ThemeManager shareInstance];
    UIImage* image = [themeMan getThemeImage:_imageName];
    UIImage  *highlightImage = [themeMan getThemeImage:_highlightImageName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    highlightImage = [highlightImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlightImage forState:UIControlStateHighlighted];
    
    UIImage *backImage = [themeMan getThemeImage:_backgroundImageName];
    UIImage *hilghlightBackImage = [themeMan getThemeImage:_backgroundHighlightImageName];
    
    backImage = [backImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    hilghlightBackImage = [highlightImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    [self setBackgroundImage:hilghlightBackImage forState:UIControlStateHighlighted];
}
#pragma mark - overload setter -

- (void)setLeftCapWidth:(int)leftCapWidth
{
    _leftCapWidth = leftCapWidth;
    [self loadThemeImage];
}
- (void)setTopCapHeight:(int)topCapHeight
{
    _topCapHeight = topCapHeight;
    
    [self loadThemeImage];
}
- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}
- (void)setHighlightImageName:(NSString *)highlightImageName
{
    if (_highlightImageName != highlightImageName) {
        [_highlightImageName release];
        _highlightImageName = [highlightImageName copy];
    }
    [self loadThemeImage];
}
- (void)setBackgroundImageName:(NSString *)backgroundImageName
{
    if (_backgroundImageName != backgroundImageName) {
        [_backgroundImageName release];
        _backgroundImageName = [backgroundImageName copy];
    }
    [self loadThemeImage];
}

- (void)setBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName
{
    if (_backgroundHighlightImageName != backgroundHighlightImageName) {
        [_backgroundHighlightImageName release];
        _backgroundHighlightImageName = [backgroundHighlightImageName copy];
    }
    [self loadThemeImage];
}
/*(
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
