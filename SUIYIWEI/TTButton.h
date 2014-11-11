//
//  TTButton.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTButton : UIButton
{
    UILabel  *_titleLabel;
    UILabel  *_subTitleLabel;
}



@property (nonatomic, copy)  NSString  *title;
@property (nonatomic, copy)  NSString  *subTitle;
@end
