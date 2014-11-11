//
//  WebViewController.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
{
    NSString *_url;
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;
- (id)initWithUrl:(NSString*)url;
- (IBAction)goBack:(id)sender;
- (IBAction)goFowrd:(id)sender;
- (IBAction)refresh:(id)sender;

@end
