//
//  BarsManager.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "MenuItem.h"
#import "SettingsItem.h"
#import "BarDetailItem.h"
#import "BarsSettingsManager.h"
#import "BarsMenuManager.h"
#import "BarDetailItemsManager.h"
#import "BarsFavoriteManager.h"
#import "BarsGateway.h"

typedef void (^BarsCompletionHandler) (NSArray* result);

@interface BarsFacade : NSObject

-(NSArray*)getMenuItems;
-(NSArray*)getBarDetailItems;
-(NSArray*)getSettingsItems;

-(void)getBars:(BarsCompletionHandler)completionHandler;
-(void)getBarTypes:(BarsCompletionHandler)completionHandler;
-(void)getDistricts:(BarsCompletionHandler)completionHandler;
-(void)getMusicTypes:(BarsCompletionHandler)completionHandler;
-(void)getParties:(BarsCompletionHandler)completionHandler;
-(void)getEvents:(BarsCompletionHandler)completionHandler;

-(NSArray*)getFavorites;
-(bool)favoriteExits:(NSInteger)barId;
-(void)saveFavorite:(NSInteger)barId;
-(void)removeFavorite:(NSInteger)barId;

@end
