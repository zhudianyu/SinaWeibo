//
//  CommentCell.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-31.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@class CommentModel;

@interface CommentCell : UITableViewCell<RTLabelDelegate>
{
    
}
@property (nonatomic ,retain)ZDYImageView  *userView;
@property (nonatomic ,retain)UILabel      *nickLabel;
@property (nonatomic ,retain)UILabel      *timeLabel;
@property (nonatomic ,retain)RTLabel      *commentLabel;
@property (nonatomic ,retain)CommentModel *commentModel;

+(float)getCommentHeight:(CommentModel *)commentModel;
@end
