//
//  FooterView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabViewDelegate

- (void)didClickTabViewDelegate:(int)position;

@end

@interface TabView : UIView

@property(nonatomic, assign) id<TabViewDelegate> myDelegate;

- (id)init:(NSMutableArray *)itemArray;
- (void)checkItem:(int)position;

@end
