//
//  UserInfoView.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-3.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTButton;
@class UserModel;
@interface UserInfoView : UIView
{
    
}
@property (nonatomic, retain) UserModel        *user;
@property (nonatomic, assign) UIImageView      *userImage;
@property (nonatomic, assign) UILabel          *nickLabel;
@property (nonatomic, assign) UILabel          *addrLabel;
@property (nonatomic, assign) UILabel          *userIntroLabel;
@property (nonatomic, assign) TTButton         *attentionBtn;
@property (nonatomic, assign) TTButton         *fansBtn;
@property (nonatomic, assign) UIButton         *infomationBtn;
@property (nonatomic, assign) UIButton         *moreBtn;
@property (nonatomic, assign) UILabel          *totalLabel;
@end
