//
//  HeaderView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate

- (void)didClickHeaderLeftButtonDelegate;
- (void)didClickHeaderRightButtonDelegate:(int)position;

@end

@interface HeaderView : UIView

@property(nonatomic, assign) id<HeaderViewDelegate> myDelegate;

- (id)init:(NSMutableArray *)itemArray;
- (void)checkItem:(int)position;
- (void)initTitle:(int)position withPayload:(NSDictionary *)payload;
- (void)showLeftButton;

@end
