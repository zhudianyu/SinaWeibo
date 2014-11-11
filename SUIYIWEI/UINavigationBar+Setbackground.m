//
//  UINavigationBar+Setbackground.m
//  SUIYIWEI
//
//  Created by zdy on 13-7-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UINavigationBar+Setbackground.h"

@implementation UINavigationBar (Setbackground)
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"navigationbar_background.png"];
    [image drawInRect:rect];
}
@end
