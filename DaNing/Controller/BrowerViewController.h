//
//  BrowerViewController.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BaseViewController.h"

@protocol BrowerViewControllerDelegate

- (void)didSwitchBrowerControllerBrowerViewControllerDelegate:(NSString *)string;
- (void)didBackAndRefreshBrowerViewControllerDelegate:(int)position;
- (void)didSetApplicationIconBadgeNumberBrowerViewControllerDelegate:(int)number;

@end

@interface BrowerViewController : BaseViewController

@property(nonatomic, assign) id<BrowerViewControllerDelegate> myDelegate;

- (id)init:(NSString *)string;

@end
