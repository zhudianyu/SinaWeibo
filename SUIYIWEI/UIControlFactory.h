//
//  UIButtonFactory.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThemeButton;
@class ThemeImageView;
@class ThemeLabel;
//创建工厂类 使用工厂设计模式

@interface UIControlFactory : NSObject


//创建button
+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName;

+ (UIButton *)createNavigationBarButton:(CGRect)frame
                                  title:(NSString *)title
                                 target:(id)target
                                 action:(SEL)action;
+ (ThemeImageView *)createImageView:(NSString *)imageName;

+ (ThemeLabel *)createThemeLabel:(NSString *)colorName;
@end
