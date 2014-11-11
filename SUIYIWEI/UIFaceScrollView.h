//
//  UIFaceScrollView.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFaceView.h"
@interface UIFaceScrollView : UIView<UIScrollViewDelegate>
{
    UIFaceView           *_faceView;
    UIScrollView         *_scrollView;
    UIPageControl        *_pageControl;
}
- (id)initSelectEmotionBlock:(SelectEmotionBlock)block;
@end
