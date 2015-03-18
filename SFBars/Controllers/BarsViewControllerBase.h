//
//  BaseViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingView.h"
#import "MFSideMenu.h"

extern NSString* kCellIdentifier;
extern NSString* kGlyphIconsFontName;
extern NSString* kFontAwesomeFontName;
extern NSString* kServiceUrl;

@interface BarsViewControllerBase : UIViewController

@property (readonly, nonatomic, strong) BarsFacade* barsFacade;
@property (readwrite, nonatomic, strong) LoadingView* loadingView;

-(void)addMenuButtonToNavigation;
-(void)showLoadingIndicator;
-(void)hideLoadingIndicator;


@end
