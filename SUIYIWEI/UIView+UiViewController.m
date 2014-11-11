//
//  UIView+UiViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-2.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UIView+UiViewController.h"

@implementation UIView (UiViewController)

- (UIViewController*)uiviewController
{
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)next;
        }
        else
        {
            next = [next nextResponder];
        }
    } while (next != nil);
    return nil;
}
@end
