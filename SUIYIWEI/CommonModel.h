//
//  CommonModel.h
//  SUIYIWEI
//
//  Created by zdy on 13-7-19.
//  Copyright (c) 2013年 ZDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject<NSCoding>
{
    
}

- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串
@end
