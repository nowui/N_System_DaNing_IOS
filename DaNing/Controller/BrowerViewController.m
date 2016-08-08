//
//  BrowerViewController.m
//  DaNing
//
//  Created by ZhongYongQiang on 10/26/15.
//  Copyright (c) 2015 NowUI. All rights reserved.
//

#import "BrowerViewController.h"
#import "MWPhotoBrowser.h"
#import "BrowerView.h"
#import "HeaderView.h"
#import "TabView.h"
#import "FooterView.h"

@interface BrowerViewController () <HeaderViewDelegate, BrowerViewDelegate, TabViewDelegate, FooterViewDelegate, BrowerViewControllerDelegate, MWPhotoBrowserDelegate, UIScrollViewDelegate> {
    NSString *pageTypeString;
    HeaderView *headerView;
    TabView *tabView;
    FooterView *footerView;
    UIScrollView *mainScrollView;
    NSMutableArray *browerViewArray;
    NSMutableArray *browerViewIsLoadArray;
    NSDictionary *initDataDictionary;
    NSMutableArray *photoArray;
}

@end

@implementation BrowerViewController

@synthesize myDelegate;

- (void)didDealloc {
    [super didDealloc];
    
    for (UIView *view in mainScrollView.subviews) {
        if ([view isKindOfClass:[BrowerView class]]) {
            [(BrowerView *)view didDealloc];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController].navigationBar setHidden:YES];
    
    if (self.navigationController.childViewControllers.count > 1) {
        [headerView showLeftButton];
    }
    
    for (BrowerView *browerView in browerViewArray) {
        [browerView viewWillAppear:animated];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPushAction:)
                                                 name:KeyPushFilter
                                               object:nil];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];*/
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:KeyPushFilter
                                                  object:nil];
    
    /*[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];*/
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self didAppearAction];
}

- (id)init:(NSString *)data; {
    self = [super init];
    if (self) {
        
        [self initView:data];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView:(NSString *)string {
    if (! [[Helper shared] isNullOrEmpty:string]) {
        NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        
        initDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        pageTypeString = [initDataDictionary objectForKey:KeyType];
        
        NSDictionary *initDataDataDictionary = (NSDictionary *) [initDataDictionary objectForKey:KeyData];
        
        if([pageTypeString isEqualToString:ValueOnePage]) {
            NSString *urlString = [initDataDataDictionary objectForKey:KeyUrl];
            
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            [itemArray addObject:initDataDataDictionary];
            
            [self initHeaderView:itemArray];
            
            BrowerView *browerView = [[BrowerView alloc] initWithFrame:CGRectMake(0, headerView.frame.origin.y + headerView.frame.size.height, screenWidth, screenHeight - StatusHeight)];
            [browerView setMyDelegate:self];
            [browerView setTag:0];
            [self.view addSubview:browerView];
            
            [browerView loadUrl:urlString];
            
            browerViewArray = [[NSMutableArray alloc] init];
            [browerViewArray addObject:browerView];
            
            browerViewIsLoadArray = [[NSMutableArray alloc] init];
            [browerViewIsLoadArray addObject:[NSNumber numberWithBool:YES]];
        } else if([pageTypeString isEqualToString:ValueMultiTab]) {
            NSMutableArray *headerItemArray = [[NSMutableArray alloc] init];
            [headerItemArray addObject:initDataDataDictionary];
            
            [self initHeaderView:headerItemArray];
            
            NSMutableArray *tabItemArray = (NSMutableArray *) [initDataDataDictionary objectForKey:KeyTab];
            
            [self initTabView:tabItemArray];
            
            [self initMainView:tabItemArray];
            
        } else if([pageTypeString isEqualToString:ValueMultiFooter]) {
            NSMutableArray *itemArray = (NSMutableArray *) [initDataDataDictionary objectForKey:KeyFooter];
            
            [self initHeaderView:itemArray];
            
            [self initFooterView:itemArray];
            
            [self initMainView:itemArray];
        }
    }
}

- (void)initHeaderView:(NSMutableArray *)itemArray {
    headerView = [[HeaderView alloc] init:itemArray];
    [headerView setMyDelegate:self];
    [headerView setFrame:CGRectMake(0, 20, screenWidth, NavigationHeight)];
    [self.view addSubview:headerView];
}

- (void)initTabView:(NSMutableArray *)itemArray {
    tabView = [[TabView alloc] init:itemArray];
    [tabView setMyDelegate:self];
    [tabView setFrame:CGRectMake(0, headerView.frame.origin.y + headerView.frame.size.height, screenWidth, NavigationHeight)];
    [self.view addSubview:tabView];
}

- (void)initFooterView:(NSMutableArray *)itemArray {
    footerView = [[FooterView alloc] init:itemArray];
    [footerView setMyDelegate:self];
    [footerView setFrame:CGRectMake(0, screenHeight, screenWidth, TabBarHeight)];
    [footerView setBackgroundColor:FooterBackgroundColor];
    [self.view addSubview:footerView];
}

- (void)initMainView:(NSMutableArray *)itemArray {
    int y = headerView.frame.origin.y + headerView.frame.size.height;
    int height = screenHeight - StatusHeight - NavigationHeight;
    
    if(tabView) {
        y += tabView.frame.size.height;
    }
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, screenWidth, height)];
    [mainScrollView setDelegate:self];
    [mainScrollView setContentSize:CGSizeMake(screenWidth * [itemArray count], screenHeight - StatusHeight - NavigationHeight)];
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setShowsVerticalScrollIndicator:NO];
    [mainScrollView setPagingEnabled:YES];
    [mainScrollView setBackgroundColor:RGBCOLOR(255, 255, 255)];
    [self.view addSubview:mainScrollView];
    
    browerViewArray = [[NSMutableArray alloc] init];
    
    browerViewIsLoadArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *payloadDictionary = [itemArray objectAtIndex:i];
        
        BrowerView *browerView = [[BrowerView alloc] initWithFrame:CGRectMake(screenWidth * i, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
        [browerView setMyDelegate:self];
        [browerView setTag:i];
        [mainScrollView addSubview:browerView];
        
        [browerViewArray addObject:browerView];
        
        if (i == 0) {
            [browerView loadUrl:[payloadDictionary objectForKey:KeyUrl]];
            
            [browerViewIsLoadArray addObject:[NSNumber numberWithBool:YES]];
        } else {
            [browerViewIsLoadArray addObject:[NSNumber numberWithBool:NO]];
        }
    }
}

- (void)didBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didBackAndRefresh {
    
    
    [self didBack];
}

- (void)didPushAction:(NSNotification *)notification {
    for (BrowerView *browerView in browerViewArray) {
        [browerView didPushAction];
    }
}

- (void)didAppearAction {
    for (BrowerView *browerView in browerViewArray) {
        [browerView didAppearAction];
    }
}

- (void)didClickHeaderLeftButtonDelegate {
    [self didBack];
}

- (void)didClickHeaderRightButtonDelegate:(int)position {
    [(BrowerView *) [browerViewArray objectAtIndex:position] didClickHeaderRightButton];
}

- (void)didSetTitleBrowerViewDelegate:(int)position withPayload:(NSDictionary *)payload {
    [headerView initTitle:position withPayload:payload];
}

- (void)didPushBrowerControllerBrowerViewDelegate:(NSString *)json {
    BrowerViewController *browerViewController = [[BrowerViewController alloc] init:json];
    [browerViewController setMyDelegate:self];
    [[self navigationController] pushViewController:browerViewController animated:YES];
}

- (void)didPreviewImageControllerBrowerViewDelegate:(NSArray *)array withPosition:(int)position {
    photoArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++) {
        [photoArray addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [array objectAtIndex:i]]]]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:position];
    [[self navigationController] pushViewController:browser animated:YES];
    [[self navigationController].navigationBar setHidden:NO];
}

- (void)didSwitchBrowerControllerBrowerViewDelegate:(NSString *)string {
    if (myDelegate) {
        [myDelegate didSwitchBrowerControllerBrowerViewControllerDelegate:string];
    }
}

- (void)didBackBrowerViewDelegate:(int)position {
    [self didBack];
}

- (void)didBackAndRefreshBrowerViewDelegate:(int)position {
    if (myDelegate) {
        [myDelegate didBackAndRefreshBrowerViewControllerDelegate:position];
    }
    
    [self didBack];
}

- (void)didSetApplicationIconBadgeNumberBrowerViewDelegate:(int)number {
    if (myDelegate) {
        [myDelegate didSetApplicationIconBadgeNumberBrowerViewControllerDelegate:number];
    }
}

- (void)didClickTabViewDelegate:(int)position {
    [self didClick:position];
}

- (void)didClickFooterViewDelegate:(int)position {
    [self didClick:position];
}

- (void)didClick:(int)position {
    if (! [[browerViewIsLoadArray objectAtIndex:position] boolValue]) {
        [browerViewIsLoadArray replaceObjectAtIndex:position withObject:[NSNumber numberWithInt:1]];
        
        NSString *type = [initDataDictionary objectForKey:KeyType];
        NSDictionary *initDataDataDictionary = (NSDictionary *) [initDataDictionary objectForKey:KeyData];
        
        NSDictionary *payloadDictionary;
        
        if ([type isEqualToString:ValueMultiFooter]) {
            NSMutableArray *itemArray = (NSMutableArray *) [initDataDataDictionary objectForKey:KeyFooter];
            payloadDictionary = [itemArray objectAtIndex:position];
        } else if ([type isEqualToString:ValueMultiTab]) {
            NSMutableArray *itemArray = (NSMutableArray *) [initDataDataDictionary objectForKey:KeyTab];
            payloadDictionary = [itemArray objectAtIndex:position];
        } else if ([type isEqualToString:ValueOnePage]) {
            
        }
        
        [(BrowerView *) [browerViewArray objectAtIndex:position] loadUrl:[payloadDictionary objectForKey:KeyUrl]];
    }
    
    if (tabView) {
        
    } else {
        [headerView checkItem:position];
    }
    
    [mainScrollView scrollRectToVisible:CGRectMake(mainScrollView.frame.size.width * position, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height) animated:NO];
}

- (void)didGoBrowerControllerBrowerViewControllerDelegate:(NSString *)string {
    
}

- (void)didBackAndRefreshBrowerViewControllerDelegate:(int)position {
    //[(BrowerView *) [browerViewArray objectAtIndex:position] didBackAndRefresh];
    for (BrowerView *browerView in browerViewArray) {
        [browerView didBackAndRefresh];
    }
}

- (void)didSwitchBrowerControllerBrowerViewControllerDelegate:(NSString *)string {
    
}

- (void)didSetApplicationIconBadgeNumberBrowerViewControllerDelegate:(int)number {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == mainScrollView) {
        int position = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if (tabView) {
            [tabView checkItem:position];
        } else {
            [headerView checkItem:position];
            
            [footerView checkItem:position];
        }
    }
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < photoArray.count)
        return [photoArray objectAtIndex:index];
    return nil;
}

/*- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
}*/

@end
