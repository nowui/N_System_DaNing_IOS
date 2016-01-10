//
//  BaseModel.m
//  DaNing
//
//  Created by ZhongYongQiang on 11/1/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableDictionary *)packageDictionary {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    return dictionary;
}

- (void)setObject:(NSObject *)object key:(NSString *)key dictionary:(NSMutableDictionary *)dictionary {
    if (object) {
        [dictionary setObject:object forKey:key];
    }
}

- (NSObject *)formatObject:(NSObject *)object defaultObject:(NSObject *)defaultObject {
    if (object) {
        return object;
    } else {
        return defaultObject;
    }
}

@end
