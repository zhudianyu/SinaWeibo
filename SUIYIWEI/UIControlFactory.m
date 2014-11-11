//
//  UIButtonFactory.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UIControlFactory.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
//工厂类 使用工厂设计模式
@implementation UIControlFactory


//创建button
+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithImage:imageName highlight:highlightedName];
    return [button autorelease];
}
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithBackground:backgroundImageName highlightBackground:highlightedName ];
    return [button autorelease];
}
+ (UIButton *)createNavigationBarButton:(CGRect)frame
                                  title:(NSString *)title
                                 target:(id)target
                                 action:(SEL)action
{
    ThemeButton *button = [self createButtonWithBackground:@"navigationbar_button_background.png" backgroundHighlighted:@"navigationbar_button_delete_background.png"];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.leftCapWidth = 3;
    return button;
}
+ (ThemeImageView *)createImageView:(NSString *)imageName
{
    ThemeImageView *view =[[ThemeImageView alloc]initWithImageName:imageName highLightImageName:nil];
    return [view autorelease];
}

+ (ThemeLabel *)createThemeLabel:(NSString *)colorName
{
    ThemeLabel *label = [[ThemeLabel alloc]initWithThemeColor:colorName];
    return [label autorelease];
}
@end
