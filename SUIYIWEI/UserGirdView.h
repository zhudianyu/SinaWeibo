//
//  UserGirdView.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-10.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface UserGirdView : UIView
{
    
}
@property (nonatomic, retain) UserModel *userModel;
@property (retain, nonatomic) IBOutlet UIButton *userImageBtn;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UILabel *fansLabel;
- (IBAction)userImageAction:(id)sender;

@end
