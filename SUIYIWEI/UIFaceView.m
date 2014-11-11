//
//  UIFaceView.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-8.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "UIFaceView.h"
#define EMOTION_WIDTH 42
#define EMOTION_HEIGHT 45
@implementation UIFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        self.backgroundColor = [UIColor clearColor];
        self.pageNum = self.itemsArray.count;
    }
    return self;
}
- (void)dealloc
{
    Block_release(_block);
    [_selectEmotionName release];
    [_magnifierView release];
    [_selectImageName release];
    [super dealloc];
}
- (void)initData
{
    //把表情放到二维数组里面
    self.itemsArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *items2D = nil;
    for (int i = 0; i<fileArray.count; i++) {
        NSDictionary *item = [fileArray objectAtIndex:i];
        if (i%28 == 0) {
            items2D = [[NSMutableArray alloc] initWithCapacity:28];
            [self.itemsArray addObject:items2D];
        }
        [items2D addObject:item];
    }
    self.width = self.itemsArray.count *ScreenWidth;
    self.height = 4*EMOTION_HEIGHT;
    
    //放大镜视图
    _magnifierView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 92)];
    _magnifierView.backgroundColor = [UIColor clearColor];
    _magnifierView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    [self addSubview:_magnifierView];
    
    //表情视图
    UIImageView *emoticonView = [[UIImageView alloc]initWithFrame:CGRectMake((64-30)/2,15, 30, 30)];
    emoticonView.backgroundColor = [UIColor clearColor];
    emoticonView.tag = 2013;
    [_magnifierView addSubview:emoticonView];
    [emoticonView release];
    [_magnifierView setHidden:YES];
}

- (void)drawRect:(CGRect)rect
{
    int row = 0, colum = 0;
    for (int i = 0; i<self.itemsArray.count; i++) {
        NSArray *items2D = [_itemsArray objectAtIndex:i];
        
        for (int j = 0 ; j<items2D.count; j++) {
            
            NSDictionary *dic = [items2D objectAtIndex:j];
            NSString *imageName = [dic objectForKey:@"png"];
            UIImage *image = [UIImage imageNamed:imageName];
            CGRect frame = CGRectMake(colum *EMOTION_WIDTH +15, row*EMOTION_HEIGHT+15, 30, 30);
            float x = i*ScreenWidth + frame.origin.x;
            frame.origin.x = x;
            //把表情画在视图上
            [image drawInRect:frame];
            colum ++;
            if (colum %7 == 0) {
                //6个表情换行
                row ++;
                colum = 0;
            }
            if (row == 4) {
                row = 0;
            }
        }
    }
}

- (void)touchPoint:(CGPoint)point
{
    //获取页数
 
    int page = point.x/ScreenWidth;
    
    float pointX = point.x - page*ScreenWidth - 10;
    float pointY = point.y - 10;
    //计算行列
    int row = pointY/EMOTION_HEIGHT;
    int colum = pointX/EMOTION_WIDTH;
    if (colum>6) {
        colum = 6;
    }
    if (colum<0) {
        colum = 0;
    }
    if (row>3) {
        row = 3;
    }
    if (row<0) {
        row = 0;
    }
    //计算索引
    int index = colum + row*7;
    
    NSArray *items2D = [self.itemsArray objectAtIndex:page];
    
    NSDictionary *emotionDic = [items2D objectAtIndex:index];
//    NSString *emoName = [emotionDic objectForKey:@"chs"];
 
    NSString *imageName = [emotionDic objectForKey:@"png"];
    _selectEmotionName = [emotionDic objectForKey:@"chs"];
    if ([self.selectImageName isEqualToString:imageName]||imageName != nil) {
        
        //放大镜
        [_magnifierView setHidden:NO];
        UIImageView *imageView = (UIImageView*)[_magnifierView viewWithTag:2013];
        imageView.image = [UIImage imageNamed:imageName];
        
        _magnifierView.left = page*ScreenWidth +colum *EMOTION_WIDTH;
        _magnifierView.bottom = row*EMOTION_HEIGHT +30;
        
        self.selectImageName = imageName;
        
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchPoint:point];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchPoint:point];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)self.superview;
        [scrollView setScrollEnabled:NO];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_magnifierView setHidden:YES];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)self.superview;
        [scrollView setScrollEnabled:YES];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_magnifierView setHidden:YES];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)self.superview;
        [scrollView setScrollEnabled:YES];
    }
    
    if (self.block != nil) {
        _block(self.selectEmotionName);
    }
}
@end
