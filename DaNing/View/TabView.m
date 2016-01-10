//
//  TabView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "TabView.h"
#import "Helper.h"
#import "TabItemView.h"

@interface TabView () <TabItemViewDelegate> {
    int selectInt;
}

@end

@implementation TabView

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
    float width = TabWidth / itemArray.count;
    float height = TabHeight;
    
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *payloadDictionary = [itemArray objectAtIndex:i];
        
        TabItemView *tabItemView = [[TabItemView alloc] init:(int)i withCount:(int)itemArray.count widthPayload:payloadDictionary];
        [tabItemView setMyDelegate:self];
        [tabItemView setFrame:CGRectMake((ScreenWidth - TabWidth) / 2 + width * i, 0, width, height)];
        [tabItemView setTag:i];
        [self addSubview:tabItemView];
        
        if (i == 0) {
            [tabItemView didActive];
        }
    }
}

- (void)checkItem:(int)position {
    if(selectInt == position) {
        return;
    }
    
    selectInt = position;
    
    for (UIView *tabItemView in self.subviews) {
        if ([tabItemView isKindOfClass:[TabItemView class]]) {
            if (tabItemView.tag == selectInt) {
                [(TabItemView *)tabItemView didActive];
            } else {
                [(TabItemView *)tabItemView didNormal];
            }
        }
    }
    
    if (myDelegate) {
        [myDelegate didClickTabViewDelegate:position];
    }
}

- (void)didClickTabItemView:(int)position {
    [self checkItem:position];
}

@end
