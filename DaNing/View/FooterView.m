//
//  FooterView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "FooterView.h"
#import "Helper.h"
#import "FooterItemView.h"

@interface FooterView () <FooterItemViewDelegate> {
    int selectInt;
}

@end

@implementation FooterView

@synthesize myDelegate;

- (id)init:(NSMutableArray *)itemArray {
    self = [super init];
    if (self) {
        selectInt = -1;
        
        [self initView:itemArray];
    }
    return self;
}

- (void)initView:(NSMutableArray *)itemArray {
    float width = ScreenWidth / itemArray.count;
    float height = TabBarHeight;
    
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *payloadDictionary = [itemArray objectAtIndex:i];
        
        FooterItemView *footerItemView = [[FooterItemView alloc] init:(int) itemArray.count widthPayload:payloadDictionary];
        [footerItemView setMyDelegate:self];
        [footerItemView setFrame:CGRectMake(width * i, 0, width, height)];
        [footerItemView setTag:i];
        [self addSubview:footerItemView];
        
        if (i == 0) {
            [footerItemView didActive];
        }
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [lineView setBackgroundColor:FooterLineColor];
    [self addSubview:lineView];
}

- (void)checkItem:(int)position {
    if(selectInt == position) {
        return;
    }
    
    selectInt = position;
    
    for (UIView *footerItemView in self.subviews) {
        if ([footerItemView isKindOfClass:[FooterItemView class]]) {
            if (footerItemView.tag == selectInt) {
                [(FooterItemView *)footerItemView didActive];
            } else {
                [(FooterItemView *)footerItemView didNormal];
            }
        }
    }
    
    if (myDelegate) {
        [myDelegate didClickFooterViewDelegate:position];
    }
}

- (void)didClickFooterItemView:(int)position {
    [self checkItem:position];
}

@end
