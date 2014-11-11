//
//  ZDYImageView.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageBlock)(void);
@interface ZDYImageView : UIImageView
{
    
}
@property (nonatomic, copy) ImageBlock imageBlock;

@end
