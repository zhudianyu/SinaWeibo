//
//  SendViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "SendViewController.h"
#import "BaseNavigationViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ZDYDataService.h"
@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardNotification:) name:UIKeyboardDidShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _btnArray = [[NSMutableArray alloc] initWithCapacity:6];
    UIButton * cancleBtn = [UIControlFactory createNavigationBarButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(sendCancle)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
    [cancleBtn release];
    
    UIButton * sendBtn = [UIControlFactory createNavigationBarButton:CGRectMake(0, 0, 45, 30) title:@"发送" target:self action:@selector(sendAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    [sendBtn release];
    
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
}
- (void)initView
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight - 44*2 -20)];
    [_textView setDelegate:self];
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44*2 -20, ScreenWidth, 44)];
    [self.view addSubview:_textView];
    [self.view addSubview:_tabbarView];
    [self.textView resignFirstResponder];
    [self.tabbarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background.png"]]];
    NSArray *imageName = [NSArray arrayWithObjects:
                          @"compose_camerabutton_background.png",
                          @"compose_trendbutton_background.png",
                          @"compose_mentionbutton_background.png",
                          @"compose_emoticonbutton_background.png",
                          @"compose_keyboardbutton_background.png",
                          @"compose_toolbar_more.png",
                          nil];
    
    NSArray *highlightName = [NSArray arrayWithObjects:
                              @"compose_camerabutton_background_highlighted.png",
                              @"compose_trendbutton_background_highlighted.png",
                              @"compose_mentionbutton_background_highlighted.png",
                              @"compose_emoticonbutton_background_highlighted.png",
                              @"compose_keyboardbutton_background_highlighted.png",
                              @"compose_toolbar_more_highlighted.png",
                              nil];
    
    for (int i = 0; i<imageName.count; i++) {
        NSString *backImageName = [imageName objectAtIndex:i];
        NSString *highBackImageName = [highlightName objectAtIndex:i];
        
        UIButton *btn = [UIControlFactory createButtonWithBackground:backImageName backgroundHighlighted:highBackImageName];
        
        
        btn.frame = CGRectMake(20+64*i, 12, 24, 19);
        if (i == 4) {
            [btn setHidden:YES];
             btn.left -= 64;
        }
        if (i == 5) {
             btn.left -= 64;
        }
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
        
        [self.tabbarView addSubview:btn];
    }
    UIButton *locatinonBtn = [UIControlFactory
                              createButtonWithBackground:@"compose_locatebutton_background_ready.png"
                              backgroundHighlighted:@"compose_locatebutton_background_ready_highlighted.png"];
    [locatinonBtn addTarget:self action:@selector(nearByLocation:) forControlEvents:UIControlEventTouchUpInside];
    locatinonBtn.tag = 100;
    UILabel *lable = [[UILabel alloc]init];
    lable.tag = 101;
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:14.0];
    lable.textColor = [UIColor colorWithRed:157.0/255.0 green:194.0/255.0 blue:29.0/255.0 alpha:1.0];
    [locatinonBtn addSubview:lable];
    [_textView addSubview:locatinonBtn];
    UIButton *sendImageButton = [[UIButton alloc]init];
    [sendImageButton addTarget:self action:@selector(scaleSendImage) forControlEvents:UIControlEventTouchUpInside];
    [_textView addSubview:sendImageButton];
    sendImageButton.tag = 103;
//    sendImageButton.layer.borderColor = [UIColor redColor].CGColor;
//    sendImageButton.layer.borderWidth = 1.0;
    
}
- (void)scaleSendImage
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = self.sendImage ;
    imageView.frame = CGRectMake(0, _textView.height - 90 + 64, 60, 60);

    imageView.tag = 2013;
    imageView.userInteractionEnabled = YES;
    [_textView resignFirstResponder];
    [self.view.window addSubview:imageView];
    //创建删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(ScreenWidth/2 - 30, ScreenHeight - 30, 60, 30);
    [deleteBtn setBackgroundColor:[UIColor blackColor]];
    [imageView addSubview:deleteBtn];
    [deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setHidden:YES];
//创建手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomImage)];
    [imageView addGestureRecognizer:gesture];
    [gesture release];
    [UIView animateWithDuration:.4 animations:^{
        imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = YES;
        [deleteBtn setHidden:NO];
    }];
}
- (void)deleteImage:(UIButton*)btn
{
    [self zoomImage];
    UIButton *imgeBtn = (UIButton*)[_textView viewWithTag:103];
    [imgeBtn setHidden:YES];
    self.sendImage = nil;
}
- (void)zoomImage
{
    UIImageView *imageView = (UIImageView*)[self.view.window viewWithTag:2013];
    [_textView becomeFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
       imageView.frame =CGRectMake(0, _textView.height - 90 + 64, 60, 60);
    } completion:^(BOOL finished) {
        if ([imageView superview]) {
            [imageView removeFromSuperview];
        }
        
    }];
    [UIApplication sharedApplication].statusBarHidden = NO;
}
#pragma mark - 发布微博 -
- (void)sendWeibo
{
    NSString *text = self.textView.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:text forKey:@"status"];
    
    if (self.longitude.length>0) {
        [params setObject:self.longitude forKey:@"long"];
    }
    if (self.latitude.length>0) {
        [params setObject:self.latitude forKey:@"lat"];
    }
    if (self.sendImage == nil) {
        
        [self.sinaWeibo requestWithURL:@"statuses/update.json"
                                params:params
                            httpMethod:@"POST"
                                 block:^(id result) {
                                     [self sendCancle];
                                 }];
    }
    else
    {
        NSData *data = UIImageJPEGRepresentation(self.sendImage, 0.3);
        [params setObject:data forKey:@"pic"];
        [self.sinaWeibo requestWithURL:@"statuses/upload.json"
                                params:params
                            httpMethod:@"POST"
                                 block:^(id result) {
                                     [self sendCancle];
                                 }];
//         [ZDYDataService requestWithURL:@"statuses/upload.json" params:params httpMethod:@"POST" completeBlock:^(id result) {
//            [self sendCancle];
//        }];
    }
}

#pragma mark - action -
- (void)nearByLocation:(UIButton*)btn
{
    NearByViewController *nearVc = [[NearByViewController alloc]init];
    BaseNavigationViewController *nearNav = [[BaseNavigationViewController alloc]initWithRootViewController:nearVc];
    [self presentModalViewController:nearNav animated:YES];
    nearVc.selectBlock = ^(NSDictionary *dic){
        NSLog(@"%@",dic);
        self.title = [dic objectForKey:@"title"];
        self.address = [dic objectForKey:@"address"];
        self.longitude = [dic objectForKey:@"lon"];
        self.latitude = [dic objectForKey:@"lat"];
        UIButton *locatinonBtn = (UIButton*)[_textView viewWithTag:100];
        locatinonBtn.frame = CGRectMake(0, _textView.height - 25, 200, 25);

        UIImage *image = [[UIImage imageNamed:@"compose_locatebutton_background_succeeded.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        [locatinonBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        UILabel *lable = (UILabel*)[locatinonBtn viewWithTag:101];
        
        lable.frame = CGRectMake(30, 0, 170, 25);
        if ([self.address isKindOfClass:[NSNull class]]&&self.address.length == 0) {
            lable.text = self.title;
        }
        else
        {
            lable.text = self.address;
        }
    };
    [nearVc release];
    [nearNav release];
}
- (void)selectImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}
#pragma  mark - actionsheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        BOOL isCarema = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCarema) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有摄像头" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            [alertView release];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex == 1)
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        return;
    }
    UIImagePickerController *imagePc = [[UIImagePickerController alloc]init];
    imagePc.sourceType = sourceType;
    imagePc.delegate = self;
    [self presentModalViewController:imagePc animated:YES];
    
    
}
#pragma mark - UIImagePickerController delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    self.sendImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIButton *imageBtn = (UIButton*)[_textView viewWithTag:103];
    imageBtn.frame = CGRectMake(0, _textView.height - 90, 60, 60);
    [imageBtn setImage:self.sendImage forState:UIControlStateNormal];;
    [self dismissModalViewControllerAnimated:YES];
}
- (void)showEmoticonBoard
{
    [_textView resignFirstResponder];
    __block SendViewController *this = self;
    if (_emotionView == nil) {
        _emotionView = [[UIFaceScrollView alloc] initSelectEmotionBlock:^(NSString *emotionName) {
            NSString *text = this.textView.text;
            NSString *appendText = [text stringByAppendingString:emotionName];
            this.textView.text = appendText;
        }];
        _emotionView.top = ScreenHeight - 20 -44 - _emotionView.height;
        _emotionView.transform = CGAffineTransformTranslate(_emotionView.transform, 0, ScreenHeight - 20 -44);
        [self.view addSubview:_emotionView];
    }

    UIButton *keyboardBtn = _btnArray[4];
    UIButton *emotiocBtn = _btnArray[3];
    keyboardBtn.alpha = 0.0;
    emotiocBtn.alpha = 1.0;
    [keyboardBtn setHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        _emotionView.transform = CGAffineTransformIdentity;
        emotiocBtn.alpha = 0.0;
        _tabbarView.bottom =ScreenHeight - 20 - 44- _emotionView.height;
        _textView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20 - _emotionView.height - 44*2);
         UIButton *locatinonBtn = (UIButton*)[_textView viewWithTag:100];
        locatinonBtn.bottom = _textView.bottom;
        //_textView.height = ScreenHeight - 20 - _emotionView.height - 44*2;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            keyboardBtn.alpha = 1.0;
        }];
    }];
}
- (void)showKeyBoard
{
    [_textView becomeFirstResponder];
    UIButton *keyboardBtn = _btnArray[4];
    UIButton *emotiocBtn = _btnArray[3];
    keyboardBtn.alpha = 1.0;
    emotiocBtn.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        _emotionView.transform = CGAffineTransformTranslate(_emotionView.transform, 0, ScreenHeight - 44 -20);
        keyboardBtn.alpha = 0.0;
        _textView.bottom = _tabbarView.top;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            emotiocBtn.alpha = 1.0;
        }];
    }];
}
- (void)buttonAction:(UIButton*)btn
{
    if (btn.tag == 10) {
        //拍照
        [self selectImage];
    }
    else if(btn.tag == 11)
    {
        //话题
    }
    else if (btn.tag == 12)
    {
        //@
    }
    else if (btn.tag == 13)
    {
        //表情
        [self showEmoticonBoard];
    }
    else if (btn.tag == 14)
    {
        //键盘
        [self showKeyBoard];
    }
    else
    {
        //更多
    }
}
- (void)sendAction
{
    [self sendWeibo];
}
- (void)sendCancle
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - UITextView delegate -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    [self showKeyBoard];
    return YES;
}
#pragma mark - 键盘通知 -
- (void)keyBoardNotification:(NSNotification*)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    float height = rect.size.height;
    _tabbarView.frame = CGRectMake(0, self.view.height - 44 -height, ScreenWidth, 44);
  
    //_textView.bottom = _tabbarView.top;
    _textView.height = ScreenHeight - 20 -44 -height-_tabbarView.height;
    UIButton *locatinonBtn = (UIButton*)[_textView viewWithTag:100];
    locatinonBtn.frame = CGRectMake(0, _textView.height - 25, 200, 25);
    
    UIImage *image = [[UIImage imageNamed:@"compose_locatebutton_background_ready.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    [locatinonBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UILabel *lable = (UILabel*)[locatinonBtn viewWithTag:101];
    
    lable.frame = CGRectMake(30, 0, 170, 25);
    if ([self.address isKindOfClass:[NSNull class]]&&self.address.length == 0) {
        lable.text = self.title;
    }
    else 
    {
        lable.text = self.address;
    }
    if (self.address.length == 0 && self.title.length == 0) {
        locatinonBtn.frame = CGRectMake(0, _textView.height - 25, 100, 25);
            lable.frame = CGRectMake(30, 0, 70, 25);
        lable.text = @"插入位置";
    }
 
}
- (void)dealloc {
    [_emotionView release];
    [_btnArray release];
    [_textView release];
    [_tabbarView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextView:nil];
    [self setTabbarView:nil];
    [super viewDidUnload];
}
@end
