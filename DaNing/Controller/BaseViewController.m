//
//  BaseViewController.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)didDealloc {
    
}

- (void)dealloc {
    [self didDealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        screenWidth = ScreenWidth;
        screenHeight = ScreenHeight - NavigationHeight;
        
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
        
        if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
            [self setExtendedLayoutIncludesOpaqueBars:NO];
        }
        
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            [self setModalPresentationCapturesStatusBarAppearance:NO];
        }
        
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            [self setAutomaticallyAdjustsScrollViewInsets:YES];
        }
        
        [self.view setBackgroundColor:HeaderBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
