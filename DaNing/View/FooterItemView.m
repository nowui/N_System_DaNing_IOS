//
//  FooterItemView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/27/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "FooterItemView.h"
#import "Helper.h"

@interface FooterItemView () {
    UILabel *iconLabel;
    UILabel *textLabel;
}

@end

@implementation FooterItemView

@synthesize myDelegate;

- (id)init:(int)count widthPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        float width = ScreenWidth / count;
        float height = TabBarHeight;
        
        iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, width, height / 2)];
        [iconLabel setText:[payload objectForKey:KeyIcon]];
        [iconLabel setTextAlignment:NSTextAlignmentCenter];
        [iconLabel setTextColor:FooterFontColor];
        [iconLabel setBackgroundColor:[UIColor clearColor]];
        [iconLabel setFont:[UIFont fontWithName:FooterIconFontName size:FooterIconFontSize]];
        [self addSubview:iconLabel];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height / 2 - 2, width, height / 2)];
        [textLabel setText:[payload objectForKey:KeyText]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [textLabel setTextColor:FooterFontColor];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setFont:[UIFont systemFontOfSize:12]];
        //[textLabel setFont:[UIFont fontWithName:FooterIconFontName size:FooterIconFontSize]];
        [self addSubview:textLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, width, height)];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

- (void)initView:(NSMutableArray *)itemArray {
    
}

- (void)clickButton:(id)sender {
    if (myDelegate) {
        [myDelegate didClickFooterItemView:(int) self.tag];
    }
}

- (void)didNormal {
    [iconLabel setTextColor:FooterFontColor];
    [textLabel setTextColor:FooterFontColor];
}

- (void)didActive {
    [iconLabel setTextColor:FooterFontActiveColor];
    [textLabel setTextColor:FooterFontActiveColor];
}

@end
