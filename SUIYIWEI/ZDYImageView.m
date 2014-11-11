//
//  ZDYImageView.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ZDYImageView.h"

@implementation ZDYImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabAction:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tab];
        [tab release];
    }
    return self;
}


- (void)tabAction:(UITapGestureRecognizer *)gesture
{
    if (self.imageBlock) {
        _imageBlock();
    }
}
- (void)dealloc
{
    Block_release(_imageBlock);
    [super dealloc];
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
