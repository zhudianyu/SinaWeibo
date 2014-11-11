//
//  ZDYDataService.h
//  SUIYIWEI
//
//  Created by zdy on 13-8-9.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
typedef void(^RequestFinishBlock)(id result);
@interface ZDYDataService : NSObject

+(ASIHTTPRequest*)requestWithURL:(NSString*)urlString
                          params:(NSMutableDictionary*)params
                      httpMethod:(NSString *)httpMethod
                   completeBlock:(RequestFinishBlock)block;
@end
