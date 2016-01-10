//
//  BaseURLProtocol.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/27/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BaseURLProtocol.h"
#import "Helper.h"

@interface BaseURLProtocol () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation BaseURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([request.URL.absoluteString hasPrefix:WebUrl]) {
        if ([request.URL.lastPathComponent hasSuffix:@"html"] || [request.URL.lastPathComponent hasSuffix:@"js"] || [request.URL.lastPathComponent hasSuffix:@"css"] | [request.URL.lastPathComponent hasSuffix:@"ttf"]) {
            return YES;
        }
    }
    
    //NSLog(@"%@", request.URL.absoluteString);
    //NSLog(@"%@", request.URL.lastPathComponent);
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    //NSLog(@"startLoading:%@", self.request.URL.absoluteString);
    
    NSString *mimeType = @"";
    
    if ([self.request.URL.lastPathComponent hasSuffix:@"html"]) {
        mimeType = @"text/html";
    } else if ([self.request.URL.lastPathComponent hasSuffix:@"js"]) {
        mimeType = @"text/javascript";
    } else if ([self.request.URL.lastPathComponent hasSuffix:@"css"]) {
        mimeType = @"text/css";
    } else if ([self.request.URL.lastPathComponent hasSuffix:@"ttf"]) {
        mimeType = @"application/x-font-ttf";
    }
    
    NSURLRequest *request = self.request;
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[request URL]
                                                        MIMEType:mimeType
                                           expectedContentLength:-1
                                                textEncodingName:nil];
    
    NSString *path = [self.request.URL.absoluteString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@/", WebUrl] withString:@""];
    NSRange range = [path rangeOfString:@"?"];
    if (range.length > 0) {
        path = [path substringWithRange:NSMakeRange(0, range.location)];
    }
    //NSLog(@"--------%@", path);
    //NSLog(@"++++++++%@", self.request.URL.lastPathComponent);
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //NSString *wwwPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"www"];
    //NSLog(@"%@/%@", wwwPath, path);
    //NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", wwwPath, path]];
    
    NSString *localFilePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:localFilePath];
    
    //NSLog(@"%@", localFilePath);
    
    /*if (data) {
        NSLog(@"--%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }*/
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    //[self.connection cancel];
    //self.connection = nil;
}

@end
