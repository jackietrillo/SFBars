//
//  BaseViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "AppDelegate.h"

extern NSString* kCellIdentifier;
extern NSString* kGlyphIconsFontName;
extern NSString* kFontAwesomeFontName;
extern NSString* kServiceUrl;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) AppDelegate* appDelegate;

-(void)addMenuButtonToNavigation;
-(void)addDoneButtonToNavigation;

// TODO move to gateway
-(void)sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept;
-(NSMutableArray*)parseData: (NSData*)responseData; //override in subclass
-(void)loadData: (NSMutableArray*) data; //overriden in subclass

@end
