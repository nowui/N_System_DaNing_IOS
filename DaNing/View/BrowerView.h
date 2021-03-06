//
//  BrowerView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BrowerViewDelegate

- (void)didSetTitleBrowerViewDelegate:(int)position withPayload:(NSDictionary *)payload;
- (void)didPushBrowerControllerBrowerViewDelegate:(NSString *)json;
- (void)didPreviewImageControllerBrowerViewDelegate:(NSArray *)array withPosition:(int)position;
- (void)didSwitchBrowerControllerBrowerViewDelegate:(NSString *)string;
- (void)didBackBrowerViewDelegate:(int)position;
- (void)didBackAndRefreshBrowerViewDelegate:(int)position;
- (void)didSetApplicationIconBadgeNumberBrowerViewDelegate:(int)number;

@end

@interface BrowerView : UIView

@property(nonatomic, assign) id<BrowerViewDelegate> myDelegate;

- (void)didDealloc;
- (void)viewWillAppear:(BOOL)animated;
- (void)loadUrl:(NSString *)url;
- (void)didClickHeaderRightButton;
- (void)didBackAndRefresh;
- (void)didAppearAction;
- (void)didPushAction;

@end
