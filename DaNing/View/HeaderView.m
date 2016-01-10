//
//  HeaderView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "HeaderView.h"
#import "Helper.h"
#import "HeaderItemView.h"
#import "TKRoundedView.h"

@interface HeaderView () <HeaderItemViewDelegate> {
    
}

@end

@implementation HeaderView

@synthesize myDelegate;

- (id)init:(NSMutableArray *)itemArray {
    self = [super init];
    if (self) {
        [self initView:itemArray];
    }
    return self;
}

- (void)initView:(NSMutableArray *)itemArray {
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *payloadDictionary = [itemArray objectAtIndex:i];
        
        HeaderItemView *headerItemView = [[HeaderItemView alloc] init:payloadDictionary];
        [headerItemView setMyDelegate:self];
        [headerItemView setFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        [headerItemView setTag:i];
        [headerItemView setAlpha:i == 0 ? 1.0 : 0.0];
        [headerItemView setBackgroundColor:HeaderBackgroundColor];
        [self addSubview:headerItemView];
    }
}

/*- (void)initTab:(NSMutableArray *)itemArray {
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, NavigationHeight)];
    [self addSubview:tabView];
    
    int tabWidth = 280;
    int buttonWidth = tabWidth / [itemArray count];
    int buttonHeight = 30;
    
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *payloadDictionary = [itemArray objectAtIndex:i];
        
        TKRoundedView *view = [[TKRoundedView alloc] initWithFrame:CGRectMake((ScreenWidth - tabWidth) / 2 + buttonWidth * i, (NavigationHeight - buttonHeight) / 2, buttonWidth, buttonHeight)];
        [view setTag:i];
        view.borderColor = TabBackgroundColor;
        view.fillColor = [UIColor clearColor];
        if (i == 0) {
            view.roundedCorners = TKRoundedCornerTopLeft | TKRoundedCornerBottomLeft;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        } else if (i > 0 && i + 1 == itemArray.count) {
            view.roundedCorners = TKRoundedCornerTopRight | TKRoundedCornerBottomRight;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        } else {
            view.roundedCorners = TKRoundedCornerNone;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        }
        if (i == selectTabInt) {
            view.fillColor = TabBackgroundColor;
        } else {
            view.fillColor = [UIColor clearColor];
        }
        view.borderWidth = 2.0f;
        view.cornerRadius = 5.0f;
        [tabView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - tabWidth) / 2 + buttonWidth * i, (NavigationHeight - buttonHeight) / 2, buttonWidth, buttonHeight)];
        [label setTag:i];
        [label setText:@"123"];
        [label setTextColor:i == selectTabInt ? TabBackgroundActiveColor : TabBackgroundColor];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:14]];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        [tabView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        [button setFrame:CGRectMake((ScreenWidth - tabWidth) / 2 + buttonWidth * i, (NavigationHeight - buttonHeight) / 2, buttonWidth, buttonHeight)];
        //[button addTarget:self action:seletor forControlEvents:UIControlEventTouchUpInside];
        [tabView addSubview:button];
    }
}*/

- (void)checkItem:(int)position {
    for (UIView *headerItemView in self.subviews) {
        [headerItemView setAlpha:headerItemView.tag == position ? 1.0 : 0.0];
    }
}

- (void)initTitle:(int)position withPayload:(NSDictionary *)payload {
    for (UIView *headerItemView in self.subviews) {
        if (headerItemView.tag == position) {
            [(HeaderItemView *)headerItemView initView:payload];
        }
    }
}

- (void)showLeftButton {
    for (UIView *headerItemView in self.subviews) {
        [(HeaderItemView *)headerItemView showLeftButton];
    }
}

- (void)didClickHeaderItemLeftButtonDelegate {
    if (myDelegate) {
        [myDelegate didClickHeaderLeftButtonDelegate];
    }
}

- (void)didClickHeaderItemRightButtonDelegate:(int)position {
    if (myDelegate) {
        [myDelegate didClickHeaderRightButtonDelegate:position];
    }
}

@end
