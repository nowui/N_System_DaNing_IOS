//
//  UserModel.m
//  DaNing
//
//  Created by ZhongYongQiang on 11/1/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "UserModel.h"
#import "NSDictionary+Json.h"

@implementation UserModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identity = [dictionary stringValueForKey:@"identity"];
        self.name = [dictionary stringValueForKey:@"name"];
        self.jpushRegistrationId = [dictionary stringValueForKey:@"jpushRegistrationId"];
    }
    return self;
}

- (NSMutableDictionary *)packageDictionary {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[self formatObject:self.identity defaultObject:@""] forKey:@"identity"];
    [dictionary setObject:[self formatObject:self.name defaultObject:@""] forKey:@"name"];
    [dictionary setObject:[self formatObject:self.jpushRegistrationId defaultObject:@""] forKey:@"jpushRegistrationId"];
    return dictionary;
}

@end
