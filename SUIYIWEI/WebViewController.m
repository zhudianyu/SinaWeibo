//
//  WebViewController.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-4.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithUrl:(NSString*)url
{
    if (self == [super init]) {
        _url = url;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webView setDelegate:self];
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    _webView.scalesPageToFit = YES;
    self.title = @"正在加载中...";
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
#pragma mark - webview delegate -
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载网站title 用javascrip的语言
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
- (IBAction)goBack:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)goFowrd:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)refresh:(id)sender {
    [_webView reload];
}
@end
