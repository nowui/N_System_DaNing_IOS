//
//  UserModel.h
//  DaNing
//
//  Created by ZhongYongQiang on 11/1/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic, strong) NSString *identity;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *jpushRegistrationId;

@end
