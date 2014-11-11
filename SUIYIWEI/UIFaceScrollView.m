//
//  UIFaceScrollView.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UIFaceScrollView.h"

@implementation UIFaceScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (id)initSelectEmotionBlock:(SelectEmotionBlock)block
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _faceView.block = block;
        
    }
    return self;
}
- (void)dealloc
{
    [_faceView release];
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}
- (void)initView
{
    _faceView = [[UIFaceView alloc]initWithFrame:CGRectZero];
    _faceView.backgroundColor = [UIColor clearColor];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _faceView.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setContentSize:CGSizeMake(_faceView.width, _faceView.height)];
    [_scrollView addSubview:_faceView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    [_scrollView setDelegate:self];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.bottom, 0, 20)];
   // _pageControl.left = (ScreenWidth - _pageControl.width)/2.0;
    _pageControl.numberOfPages = _faceView.pageNum;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    self.height = _scrollView.height + _pageControl.height;
    self.width = _scrollView.width;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/ScreenWidth;
    _pageControl.currentPage = page;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_background.png"]drawInRect:rect];
}


@end
