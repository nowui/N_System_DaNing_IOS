//
//  BaseModel.h
//  DaNing
//
//  Created by ZhongYongQiang on 11/1/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSMutableDictionary *)packageDictionary;
- (NSObject *)formatObject:(NSObject *)object defaultObject:(NSObject *)defaultObject;

@end
