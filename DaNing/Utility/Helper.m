//
//  Helper.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "Helper.h"
#import "UserModel.h"

@implementation Helper

+ (Helper *)shared {
    static Helper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Helper alloc] init];
    });
    
    return instance;
}

- (BOOL)getIsZip {
    return [[NSUserDefaults standardUserDefaults] boolForKey:KeyIsZip];
}

- (void)setIsZip:(BOOL)isZip {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KeyIsZip];
    [[NSUserDefaults standardUserDefaults] setBool:isZip forKey:KeyIsZip];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary *)getAppUser {
    NSMutableDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:KeyAppUser];
    if (dictionary) {
        return dictionary;
    } else {
        UserModel *userModel = [[UserModel alloc] init];
        userModel.identity = @"";
        userModel.name = @"";
        userModel.jpushRegistrationId = @"";
        return [userModel packageDictionary];
    }
    return dictionary;
}

- (void)setAppUser:(NSMutableDictionary *)appUser {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KeyAppUser];
    [[NSUserDefaults standardUserDefaults] setObject:appUser forKey:KeyAppUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isNullOrEmpty:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)encode:(NSString *)string {
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)decode:(NSString *)string {
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)getCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
