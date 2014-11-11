//
//  ThemeButton.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-11.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton
{
    
}
@property(nonatomic,copy) NSString *imageName;

@property(nonatomic,copy) NSString *highlightImageName;

@property(nonatomic,copy) NSString *backgroundImageName;

@property(nonatomic,copy) NSString *backgroundHighlightImageName;


@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;
- (id)initWithImage:(NSString *)imageName highlight:(NSString *)highlightedImageName;

- (id)initWithBackground:(NSString *)backgroundName
     highlightBackground:(NSString*)backgroundHighlightImageName;
@end
