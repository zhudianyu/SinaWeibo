//
//  ThemeImageView.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-14.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView


@property (nonatomic,copy) NSString *imageName;

@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;
-(id)initWithImageName:(NSString *)imageName highLightImageName:(NSString *)highLightName;
@end
