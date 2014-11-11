//
//  UIFaceView.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-8.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectEmotionBlock)(NSString *emotionName);
@interface UIFaceView : UIView
{
    UIImageView       *_magnifierView;
}

@property (nonatomic, retain) NSMutableArray       *itemsArray;
@property (nonatomic, copy)   NSString             *selectImageName;
@property (nonatomic, copy)   NSString             *selectEmotionName;
@property (nonatomic, assign) NSInteger            pageNum;
@property (nonatomic, copy)   SelectEmotionBlock   block;
@end
