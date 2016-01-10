//
//  BrowerView.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BrowerView.h"
#import "Helper.h"
#import "UserModel.h"
#import "SVPullToRefresh.h"

@interface BrowerView () <UIWebViewDelegate> {
    UIWebView *mainWebView;
    NSString *urlString;
    BOOL isLoad;
}

@end

@implementation BrowerView

@synthesize myDelegate;

- (void)didDealloc {
    [mainWebView setDelegate:nil];
    [mainWebView stopLoading];
    mainWebView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    isLoad = NO;
    
    NSLog(@"getStart({})");
    [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"try{getStart({});}catch(e){}"]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [mainWebView setBackgroundColor:RGBCOLOR(226, 231, 237)];
        [mainWebView setDelegate:self];
        [self addSubview:mainWebView];
        
        for (UIView *view in mainWebView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                //[(UIScrollView *)view setScrollEnabled:NO];
                
                ((UIScrollView *)view).contentSize = CGSizeMake(frame.size.width, frame.size.height);
            }
        }
        
        __weak BrowerView *browerView = self;
        
        [mainWebView.scrollView addPullToRefreshWithActionHandler:^{
            [browerView loadUrl:@""];
        }];
        
        [mainWebView.scrollView.pullToRefreshView setArrowColor:RGBCOLOR(140, 154, 173)];
        [mainWebView.scrollView.pullToRefreshView setTextColor:RGBCOLOR(87, 108, 137)];
        [mainWebView.scrollView.pullToRefreshView setTitle:@"下拉刷新" forState:UIControlStateNormal];
        [mainWebView.scrollView.pullToRefreshView setTitle:@"释放刷新" forState:SVPullToRefreshStateTriggered];
        [mainWebView.scrollView.pullToRefreshView setTitle:@"正在加载.." forState:SVPullToRefreshStateLoading];
        [mainWebView.scrollView.pullToRefreshView setSubtitle:[NSString stringWithFormat:@"%@:%@", @"最后更新", [[Helper shared] getCurrentTime]] forState:UIControlStateNormal];
    }
    return self;
}

- (void)finishRefresh {
    [mainWebView.scrollView.pullToRefreshView stopAnimating];
    
    [mainWebView.scrollView.pullToRefreshView setSubtitle:[NSString stringWithFormat:@"%@:%@", @"最后更新", [[Helper shared] getCurrentTime]] forState:UIControlStateNormal];
}

- (void)canceleRefresh {
    [mainWebView.scrollView.pullToRefreshView stopAnimating];
}

- (void)loadUrl:(NSString *)url {
    NSLog(@"loadUrl:%@", url);
    
    if ([[Helper shared] isNullOrEmpty:url]) {
        url = urlString;
    }
    
    urlString = url;
    
    NSURLRequest *request;
    
    NSRange range = [url rangeOfString:HeaderHttp];
    
    if (range.length > 0) {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    } else {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WebUrl, url]]];
    }
    
    [mainWebView loadRequest:request];
}

- (void)didClickHeaderRightButton {
    [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@({})", ActionSetClickHeaderRightButton]];
}

- (void)didBackAndRefresh {
    [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@({})", ActionSetBackAndRefresh]];
}

- (void)didPushAction {
    [mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@({})", ActionGetPush]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //NSLog(@"shouldStartLoadWithRequest:%@", [request URL]);
    
    NSString *url = [NSString stringWithFormat:@"%@", [[Helper shared] decode:[NSString stringWithFormat:@"%@", [request URL]]]];
    
    NSLog(@"shouldStartLoadWithRequest:%@", url);
    
    if([url hasPrefix:HeaderWebviewplus]) {
        NSString *string = [url stringByReplacingOccurrencesOfString:HeaderWebviewplus withString:@""];
        
        
        NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *payloadDictionary = [jsonDictionary objectForKey:KeyData];
        
        NSString *actionString = [jsonDictionary objectForKey:KeyAction];
        
        if ([actionString isEqualToString:ActionSetTitle]) {
            if (myDelegate) {
                [myDelegate didSetTitleBrowerViewDelegate:(int) self.tag withPayload:payloadDictionary];
            }
        } else if ([actionString isEqualToString:ActionGetSetting]) {
            NSLog(@"%@", [[Helper shared] getAppUser]);
            NSLog(@"-------");
            UserModel *userModel = [[UserModel alloc] initWithDictionary:[[Helper shared] getAppUser]];
            //NSString *baiduUserId = @"";
            //NSString *baiduChannelId = @"";
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setObject:userModel.identity forKey:KeyAppUserId];
            [dictionary setObject:userModel.name forKey:KeyAppUserName];
            [dictionary setObject:userModel.jpushRegistrationId forKey:KeyJpushRegistrationId];
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"getSetting(%@)", string);
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getSetting(%@)", string]];
        } else if ([actionString isEqualToString:ActionSetSetting]) {
            UserModel *userModel = [[UserModel alloc] initWithDictionary:[[Helper shared] getAppUser]];
            userModel.identity = [payloadDictionary objectForKey:KeyAppUserId];
            userModel.name = [payloadDictionary objectForKey:KeyAppUserName];
            [[Helper shared] setAppUser:[userModel packageDictionary]];
        } else if ([actionString isEqualToString:ActionSetGo]) {
            if (myDelegate) {
                //NSLog(@"%@", [[payloadDictionary objectForKey:KeyData] class]);
                
                NSData *data = [[NSData alloc] initWithData:[[payloadDictionary objectForKey:KeyData] dataUsingEncoding:NSUTF8StringEncoding]];
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonstring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                [myDelegate didGoBrowerControllerBrowerViewDelegate:jsonstring];
            }
        } else if ([actionString isEqualToString:ActionSetBack]) {
            if (myDelegate) {
                [myDelegate didBackBrowerViewDelegate:(int) self.tag];
            }
        } else if ([actionString isEqualToString:ActionSetBackAndRefresh]) {
            if (myDelegate) {
                [myDelegate didBackAndRefreshBrowerViewDelegate:(int) self.tag];
            }
        }
        
        return NO;
    }
    
    if([url hasPrefix:HeaderHttp]) {
        
        //NSRange range = [url rangeOfString:WebUrl];
        
        //if (range.length > 0) {
        //} else {
            url = [url stringByReplacingOccurrencesOfString:WebUrl withString:@""];
        //}
        
        if ([url isEqualToString:urlString]) {
            return YES;
        } else {
            if (isLoad) {
                return NO;
            }
            
            isLoad = YES;
            
            [myDelegate didPushBrowerControllerBrowerViewDelegate:url];
            
            return NO;
        }
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //NSString *appUserId = [[Helper shared] getAppUserId];
    
    //NSLog(@"getInit({\"isFinish\":false,\"appUserId\":\"%@\"})", appUserId);
    //[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getInit({\"isFinish\":false,\"appUserId\":\"%@\"})", appUserId]];
    
    [self finishRefresh];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
