//
//  SendViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"
#import "NearByViewController.h"
#import "UIFaceScrollView.h"
@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>
{
    NSMutableArray              *_btnArray;
    UIFaceScrollView            *_emotionView;
}
//经度
@property (nonatomic,copy)   NSString *longitude;
//纬度
@property (nonatomic, copy)  NSString *latitude;
//发送图片的缩略图
@property (nonatomic, copy)  UIImage  *sendImage;
//地址标题
@property (nonatomic, copy)  NSString *title;

@property (nonatomic, copy)  NSString *address;
//编辑框
@property (assign, nonatomic)  UITextView *textView;
//工具栏
@property (assign, nonatomic)  UIView *tabbarView;
@end
