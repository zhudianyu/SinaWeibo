//
//  ThemeLabel.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-15.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property (nonatomic,copy) NSString   *colorName;
- (id)initWithThemeColor:(NSString*)themeClolorName;
@end
