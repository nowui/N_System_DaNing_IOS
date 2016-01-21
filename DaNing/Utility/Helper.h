//
//  Helper.h
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WebUrl @"http://run.nowui.com"
//#define WebUrl @"http://localhost:8888"
//#define WebUrl @"http://192.168.49.112:8888"


#define HeaderHttp @"http"
#define HeaderWebviewplus @"webviewplus://"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define StatusHeight 20
#define NavigationHeight 44
#define TabWidth 240
#define TabHeight 44
#define NavigationTitleViewWidth 190
#define TabBarHeight 49

#define StatusBarStyleDefault UIStatusBarStyleLightContent
#define StatusBarStyleLightContent UIStatusBarStyleDefault

#define KeyId  @"id"
#define KeyUrl  @"url"
#define KeyText  @"text"
#define KeyParameter  @"parameter"
#define KeyIsOpen  @"isOpen"
#define KeyMimeType  @"mimeType"
#define KeyName  @"name"
#define KeyIsLocal  @"isLocal"
#define KeyPath  @"path"
#define KeyInitData  @"initData"
#define KeyType  @"type"
#define KeyData  @"data"
#define KeyNumber  @"number"
#define KeyTitle  @"title"
#define KeyPlaceholder  @"placeholder"
#define KeyIcon  @"icon"
#define KeyHeader  @"header"
#define KeyCenter  @"center"
#define KeyLeft  @"left"
#define KeyRight  @"right"
#define KeyTab  @"tab"
#define KeyFooter  @"footer"
#define KeyIsSplash  @"isSplash"
#define KeyIsDoubleClickBack  @"isDoubleClickBack"
#define KeyAppSetting  @"appSetting"
#define KeyJpushRegistrationId  @"jpushRegistrationId"
#define KeyAppUser  @"appUser"
#define KeyAppUserId  @"appUserId"
#define KeyAppUserName  @"appUserName"
#define KeyIsFinish  @"isFinish"
#define KeyAction  @"action"
#define KeyPosition  @"position"
#define KeyList  @"list"
#define KeyIsZip  @"isZip_1"
#define KeyPushFilter  @"pushFilter"

#define ActionGetInit @"getInit"
#define ActionSetInit @"setInit"
#define ActionSetTitle @"setTitle"
#define ActionSetSetting @"setSetting"
#define ActionGetSetting @"getSetting"
#define ActionSetSwitch @"setSwitch"
#define ActionSetNavite @"setNavite"
#define ActionSetBack @"setBack"
#define ActionSetBackAndRefresh @"setBackAndRefresh"
#define ActionSetClickHeaderRightButton @"setClickHeaderRightButton"
#define ActionSetPreviewImage @"setPreviewImage"
#define ActionGetStart @"getStart"
#define ActionGetPush @"getPush"
#define ActionGetAppear @"getAppear"
#define ActionGetAlert @"getAlert"
#define ActionSetApplicationIconBadgeNumber @"setApplicationIconBadgeNumber"

#define ValueOnePage @"OnePage"
#define ValueMultiTab @"MultiTab"
#define ValueMultiFooter @"MultiFooter"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define BackgroundColor [UIColor colorWithRed:246.0f/255.0f green:245.0f/255.0f blue:243.0f/255.0f alpha:1]

#define HeaderBackgroundColor [UIColor colorWithRed:46.0f/255.0f green:48.0f/255.0f blue:63.0f/255.0f alpha:1]
#define HeaderTitleColor [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define HeaderIconFontName @"MaterialIcons-Regular"
#define HeaderIconFontSize 34
#define HeaderIconFontColor [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]

#define TabBackgroundColor [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define TabBackgroundActiveColor [UIColor colorWithRed:46.0f/255.0f green:48.0f/255.0f blue:63.0f/255.0f alpha:1]

#define FooterBackgroundColor [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define FooterIconFontName @"MaterialIcons-Regular"
#define FooterIconFontSize 24
#define FooterFontColor [UIColor colorWithRed:46.0f/255.0f green:48.0f/255.0f blue:63.0f/255.0f alpha:1]
#define FooterFontActiveColor [UIColor colorWithRed:251.0f/255.0f green:163.0f/255.0f blue:4.0f/255.0f alpha:1]
#define FooterLineColor [UIColor colorWithRed:167.0f/255.0f green:166.0f/255.0f blue:171.0f/255.0f alpha:1]

@interface Helper : NSObject

+ (Helper *)shared;
- (BOOL)getIsZip;
- (void)setIsZip:(BOOL)isZip;
- (NSMutableDictionary *)getAppUser;
- (void)setAppUser:(NSMutableDictionary *)appUser;
- (BOOL)isNullOrEmpty:(NSString *)string;
- (NSString *)encode:(NSString *)string;
- (NSString *)decode:(NSString *)string;
- (NSString *)getCurrentTime;

@end
