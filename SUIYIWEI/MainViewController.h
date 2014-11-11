//
//  MainViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@class HomeViewController;
@interface MainViewController : UITabBarController<SinaWeiboDelegate,UINavigationControllerDelegate>
{
    UIImageView                 *_badgeView;
    HomeViewController          *_homeVc;
}
@property (nonatomic,assign) UIView                      *tabbarView;
@property (nonatomic,retain) UIImageView                 *slideImageView;
@property (nonatomic,assign) UIImageView                 *badgeView;

- (void)showTabbarView:(BOOL)bShow;
@end
