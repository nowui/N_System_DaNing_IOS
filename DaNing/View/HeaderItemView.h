//
//  HeaderItemView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderItemViewDelegate

- (void)didClickHeaderItemLeftButtonDelegate;
- (void)didClickHeaderItemRightButtonDelegate:(int)position;

@end

@interface HeaderItemView : UIView

@property(nonatomic, assign) id<HeaderItemViewDelegate> myDelegate;

- (id)init:(NSDictionary *)payload;
- (void)initView:(NSDictionary *)payload;
- (void)showLeftButton;

@end
