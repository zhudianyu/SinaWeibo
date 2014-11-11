//
//  ZDYDataService.m
//  SUIYIWEI
//
//  Created by zdy on 13-8-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import "ZDYDataService.h"
#import "JSONKit.h"
#define BASE_URL @"https://api.weibo.com/2/"
@implementation ZDYDataService

+(ASIHTTPRequest*)requestWithURL:(NSString*)urlString
                          params:(NSMutableDictionary*)params
                      httpMethod:(NSString *)httpMethod
                   completeBlock:(RequestFinishBlock)block
{
    //获取认证信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *sinaweibInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessToken = [sinaweibInfo objectForKey:@"AccessTokenKey"];
    
    // 拼接url
    urlString = [BASE_URL stringByAppendingFormat:@"%@?access_token=%@",urlString,accessToken];
    
    //处理get请求的参数
    
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"GET"];
    if (comparRet == NSOrderedSame) {
        NSMutableString *paramsString  = [NSMutableString string];
        NSArray *allKeys = [params allKeys];
        for (int i = 0; i<allKeys.count; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            [ paramsString appendFormat:@"%@=%@",key,value ];
            if (i<params.count<1) {
                [paramsString appendString:@"&"];
            }
            
        }
        if (paramsString.length>0) {
            urlString = [urlString stringByAppendingFormat:@"&%@",paramsString];
        }
    }
    NSURL *url = [NSURL URLWithString:urlString];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //设置请求超时时间
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    
    
    NSComparisonResult comparRet1 = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet1 == NSOrderedSame)
    {
        NSArray *allKeys = [params allKeys];
        for (int i = 0; i<allKeys.count; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                [request addData:value forKey:key];
            }
            else
            {
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    //设置请求完成的block
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        float version = ZDYOSVersion();
        id reslut = nil;
        if (version>=5.0) {
            reslut = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        else
        {
            reslut = [data objectFromJSONData];
        }
        
        if (block != nil) {
            block(reslut);
        }
    }];
    [request startAsynchronous];
    
    return request;
}
@end
