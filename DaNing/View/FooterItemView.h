//
//  FooterItemView.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/27/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FooterItemViewDelegate

- (void)didClickFooterItemView:(int)position;

@end

@interface FooterItemView : UIView

@property(nonatomic, assign) id<FooterItemViewDelegate> myDelegate;

- (id)init:(int)count widthPayload:(NSDictionary *)payload;

- (void)didNormal;
- (void)didActive;

@end
