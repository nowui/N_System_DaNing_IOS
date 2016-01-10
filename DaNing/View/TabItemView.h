//
//  TabItemView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/27/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabItemViewDelegate

- (void)didClickTabItemView:(int)position;

@end

@interface TabItemView : UIView

@property(nonatomic, assign) id<TabItemViewDelegate> myDelegate;

- (id)init:(int)tag withCount:(int)count widthPayload:(NSDictionary *)payload;

- (void)didNormal;
- (void)didActive;

@end
