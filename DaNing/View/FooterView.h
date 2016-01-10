//
//  FooterView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FooterViewDelegate

- (void)didClickFooterViewDelegate:(int)position;

@end

@interface FooterView : UIView

@property(nonatomic, assign) id<FooterViewDelegate> myDelegate;

- (id)init:(NSMutableArray *)itemArray;
- (void)checkItem:(int)position;

@end
