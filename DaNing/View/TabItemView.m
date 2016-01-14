//
//  TabItemView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/27/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "TabItemView.h"
#import "Helper.h"
#import "TKRoundedView.h"

@interface TabItemView () {
    int selectInt;
    TKRoundedView *view;
    UILabel *label;
    UIButton *button;
}

@end

@implementation TabItemView

@synthesize myDelegate;

- (id)init:(int)tag withCount:(int)count widthPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        float width = TabWidth / count;
        float height = 30;
        self.tag = tag;
        
        view = [[TKRoundedView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        view.borderColor = TabBackgroundColor;
        view.fillColor = [UIColor clearColor];
        if (self.tag == 0) {
            view.roundedCorners = TKRoundedCornerTopLeft | TKRoundedCornerBottomLeft;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        } else if (self.tag > 0 && self.tag + 1 == count) {
            view.roundedCorners = TKRoundedCornerTopRight | TKRoundedCornerBottomRight;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        } else {
            view.roundedCorners = TKRoundedCornerNone;
            view.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom | TKDrawnBorderSidesTop;
        }
        view.borderWidth = 2.0f;
        view.cornerRadius = 5.0f;
        [self addSubview:view];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [label setText:[payload objectForKey:KeyText]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:14]];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, width, height)];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self didNormal];
    }
    return self;
}

- (void)initView:(NSMutableArray *)itemArray {
    
}

- (void)clickButton:(id)sender {
    if (myDelegate) {
        [myDelegate didClickTabItemView:(int) self.tag];
    }
}

- (void)didNormal {
    view.fillColor = [UIColor clearColor];
    [label setTextColor:TabBackgroundColor];
}

- (void)didActive {
    view.fillColor = TabBackgroundColor;
    [label setTextColor:TabBackgroundActiveColor];
}

@end
