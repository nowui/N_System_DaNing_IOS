//
//  AppDelegate.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "UserModel.h"
#import "BaseURLProtocol.h"
#import "BrowerViewController.h"

@interface AppDelegate () <BrowerViewControllerDelegate> {
    NSMutableArray *rootViewControllerArray;
    NSDictionary *pushDictionary;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kJPFNetworkDidRegisterNotification:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    /*for (NSString* family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
            NSLog(@"  %@", name);
        }
    }*/
    
    /*if (! [[Helper shared] getIsZip]) {
        NSString *zipPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"www.zip"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *wwwPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"www"];
        
        NSLog(@"%@", wwwPath);
        
        ZipArchive *zip = [[ZipArchive alloc] init];
        if ([zip UnzipOpenFile:zipPath]) {
            BOOL result = [zip UnzipFileTo:wwwPath overWrite:YES];
            if (result) {
                [[Helper shared] setIsZip:YES];
            }
        }
    }*/
    
    [NSURLProtocol registerClass:[BaseURLProtocol class]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:StatusBarStyleDefault];
    
    NSString *initDataString;
    
    UserModel *userModel = [[UserModel alloc] initWithDictionary:[[Helper shared] getAppUser]];
    if([[Helper shared] isNullOrEmpty:userModel.identity]) {
        initDataString = @"{\"type\": \"OnePage\", \"data\": {\"url\": \"/login.html\", \"header\": {\"center\": {\"data\": \"\"} } } }";
    } else {
        initDataString = @"{\"type\": \"MultiFooter\", \"data\": {\"footer\": [{\"header\": {\"center\": {\"data\": \"上海市闸北区大宁国际学校\"} }, \"text\": \"首页\", \"icon\": \"\\ue88a\", \"url\": \"/index.html\"}, {\"header\": {\"center\": {\"data\": \"应用中心\"} }, \"text\": \"应用\", \"icon\": \"\\ue896\", \"url\": \"/application.html\"}, {\"header\": {\"center\": {\"data\": \"通讯录\"} }, \"text\": \"通讯录\", \"icon\": \"\\ue551\", \"url\": \"/contact.html\"}, {\"header\": {\"center\": {\"data\": \"我\"} }, \"text\": \"我\", \"icon\": \"\\ue7fd\", \"url\": \"/mine.html\"}] } }";
    }
    
    //initDataString = @"{\"type\": \"MultiTab\", \"data\": {\"header\": {\"center\": {\"data\": \"上海市闸北区大宁国际学校\"} }, \"tab\": [{\"text\": \"校园新闻\", \"icon\": \"\\ue88a\", \"url\": \"/index.html\"}, {\"text\": \"通知公告\", \"icon\": \"\\ue7fd\", \"url\": \"/mine.html\"}] } }";
    
    BrowerViewController *browerViewController = [[BrowerViewController alloc] init:initDataString];
    [browerViewController setMyDelegate:self];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:browerViewController];
    [navigationController.navigationBar setHidden:YES];
    
    rootViewControllerArray = [[NSMutableArray alloc] init];
    [rootViewControllerArray addObject:navigationController];
    
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)didSwitchBrowerControllerBrowerViewControllerDelegate:(NSString *)string {
    BrowerViewController *browerViewController = [[BrowerViewController alloc] init:string];
    [browerViewController setMyDelegate:self];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:browerViewController];
    [navigationController.navigationBar setHidden:YES];
    self.window.rootViewController = navigationController;
    
    [((BrowerViewController *) [rootViewControllerArray objectAtIndex:0]) removeFromParentViewController];
    
    rootViewControllerArray = [[NSMutableArray alloc] init];
    [rootViewControllerArray addObject:navigationController];
}

- (void)kJPFNetworkDidRegisterNotification:(NSNotification *)notification {
    UserModel *userModel = [[UserModel alloc] initWithDictionary:[[Helper shared] getAppUser]];
    userModel.jpushRegistrationId = [APService registrationID];
    [[Helper shared] setAppUser:[userModel packageDictionary]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
}

- (void)didBackAndRefreshBrowerViewControllerDelegate:(int)position {
    
}

- (void)didSetApplicationIconBadgeNumberBrowerViewControllerDelegate:(int)number {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:number];
    
    if (number == 0) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KeyPushFilter object:nil];
    
    pushDictionary = userInfo;
    
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"一条新消息,是否查看?"
                                                        message:[NSString stringWithFormat:@"%@", alert]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
    
    /*NSString *url = @"";
    
    if ([[userInfo objectForKey:KeyType] isEqualToString:@"NOTICE"]) {
        url = [NSString stringWithFormat:@"/notice/detail.html?id=%@", [userInfo objectForKey:KeyId]];
    } else if ([[userInfo objectForKey:KeyType] isEqualToString:@"MEETING"]) {
        url = [NSString stringWithFormat:@"/meeting/detail.html?id=%@", [userInfo objectForKey:KeyId]];
    }
    
    if (! [[Helper shared] isNullOrEmpty:url]) {
        NSString *initDataString = [NSString stringWithFormat:@"{\"type\": \"OnePage\", \"data\": {\"url\": \"%@\", \"header\": {\"center\": {\"data\": \"\"} } } }", url];
        BrowerViewController *browerViewController = [[BrowerViewController alloc] init:initDataString];
        [browerViewController setMyDelegate:self];
        [(UINavigationController *)[rootViewControllerArray objectAtIndex:0] pushViewController:browerViewController animated:YES];
    }*/
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = @"";
        NSString *initDataString = @"";
        
        if ([[pushDictionary objectForKey:KeyType] isEqualToString:@"NOTICE"]) {
            url = [NSString stringWithFormat:@"/notice/detail.html?id=%@", [pushDictionary objectForKey:KeyId]];
            initDataString = [NSString stringWithFormat:@"{\"type\": \"OnePage\", \"data\": {\"url\": \"%@\", \"header\": {\"center\": {\"data\": \"\"} } } }", url];
            
        } else if ([[pushDictionary objectForKey:KeyType] isEqualToString:@"MEETING"]) {
            url = [NSString stringWithFormat:@"/meeting/detail.html?id=%@", [pushDictionary objectForKey:KeyId]];
            initDataString = [NSString stringWithFormat:@"{\"type\": \"OnePage\", \"data\": {\"url\": \"%@\", \"header\": {\"center\": {\"data\": \"\"} } } }", url];
            
        } else if ([[pushDictionary objectForKey:KeyType] isEqualToString:@"TASK"]) {
            url = [NSString stringWithFormat:@"/task/detail.html?id=%@", [pushDictionary objectForKey:KeyId]];
            
            initDataString = @"{\"type\": \"MultiTab\", \"data\": {\"header\": {\"center\": {\"data\": \"我的待办\"} }, \"tab\": [{\"text\": \"未审核\", \"url\": \"/task/index.html?type=NO\"}, {\"text\": \"已审核\", \"url\": \"/task/index.html?type=YES\"}] } }";
            
        }
        
        if (! [[Helper shared] isNullOrEmpty:url]) {
            BrowerViewController *browerViewController = [[BrowerViewController alloc] init:initDataString];
            [browerViewController setMyDelegate:self];
            [(UINavigationController *)[rootViewControllerArray objectAtIndex:0] pushViewController:browerViewController animated:YES];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //[application setApplicationIconBadgeNumber:0];
    //[application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
