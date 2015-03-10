//
//  BaseViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingView.h"

extern NSString* kCellIdentifier;
extern NSString* kGlyphIconsFontName;
extern NSString* kFontAwesomeFontName;
extern NSString* kServiceUrl;

@interface BaseViewController : UIViewController

@property (readonly, nonatomic, strong) BarsGateway* barsGateway;
@property (readonly, nonatomic, strong) BarsManager* barsManager;
@property (readwrite, nonatomic, strong) LoadingView* loadingView;

-(void)addMenuButtonToNavigation;
-(void)addDoneButtonToNavigation;

-(void)showLoadingIndicator;
-(void)hideLoadingIndicator;


@end
