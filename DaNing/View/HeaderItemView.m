//
//  HeaderItemView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "HeaderItemView.h"
#import "Helper.h"

@interface HeaderItemView () {
    UIButton *leftButton;
    UILabel *titleLabel;
    UIButton *rightButton;
}

@end

@implementation HeaderItemView

@synthesize myDelegate;

- (id)init:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        int width = 44;
        
        NSString *titleString = @"";
        NSDictionary *headerDictionary = (NSDictionary *) [payload objectForKey:KeyHeader];
        NSDictionary *centerDictionary = (NSDictionary *) [headerDictionary objectForKey:KeyCenter];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        if (! [centerDictionary objectForKey:KeyType]) {
            titleString = [centerDictionary objectForKey:KeyData];
            titleString = [[Helper shared] decode:titleString];
            
            [titleLabel setText:titleString];
        }
        [titleLabel setTextColor:HeaderTitleColor];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLabel];
        
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setAlpha:0.0];
        [leftButton setFrame:CGRectMake(5, 0, width, width)];
        [leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitle:@"\ue5cb" forState:UIControlStateNormal];
        [leftButton.titleLabel setFont:[UIFont fontWithName:HeaderIconFontName size:HeaderIconFontSize]];
        [self addSubview:leftButton];
        
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setAlpha:0.0];
        [rightButton setFrame:CGRectMake(ScreenWidth - width - 5, 0, width, width)];
        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"" forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:rightButton];
        
    }
    return self;
}

- (void)showLeftButton {
    [leftButton setAlpha:1.0];
}

- (void)clickLeftButton:(id)sender {
    if (myDelegate) {
        [myDelegate didClickHeaderItemLeftButtonDelegate];
    }
}

- (void)clickRightButton:(id)sender {
    if (myDelegate) {
        [myDelegate didClickHeaderItemRightButtonDelegate:(int) self.tag];
    }
}

- (void)initView:(NSDictionary *)payload {
    if (! [[Helper shared] isNullOrEmpty:[payload objectForKey:KeyText]]) {
        NSString *titleString = [payload objectForKey:KeyText];
        titleString = [[Helper shared] decode:titleString];
        [titleLabel setText:titleString];
    }
    
    
    if (! [[Helper shared] isNullOrEmpty:[payload objectForKey:KeyRight]]) {
        [rightButton setAlpha:1.0];
        [rightButton setTitle:[payload objectForKey:KeyRight] forState:UIControlStateNormal];
    }
}

@end
