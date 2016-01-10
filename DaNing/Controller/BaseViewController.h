//
//  BaseViewController.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"

@interface BaseViewController : UIViewController {
    CGFloat screenWidth;
    CGFloat screenHeight;
}

- (void)didDealloc;

@end
