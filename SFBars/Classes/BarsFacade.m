//
//  BarsManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsFacade.h"

@interface BarsFacade()

@property (readwrite, nonatomic, strong) BarsGateway* barsGateway;
@property (readwrite, nonatomic, strong) BarsSettingsManager* barsSettingsManager;
@property (readwrite, nonatomic, strong) BarsMenuManager* barsMenuManager;
@property (readwrite, nonatomic, strong) BarDetailItemsManager* barDetailItemsManager;
@property (readwrite, nonatomic, strong) BarsFavoriteManager* barsFavoriteManager;

@end

@implementation BarsFacade

-(id)init {
    self = [super init];
    
    self.barsSettingsManager = [[BarsSettingsManager  alloc] init];
    self.barsMenuManager = [[BarsMenuManager  alloc] init];
    self.barDetailItemsManager = [[BarDetailItemsManager  alloc] init];
    self.barsFavoriteManager = [[BarsFavoriteManager  alloc] init];
    self.barsGateway = [[BarsGateway  alloc] init];
    
    return self;
}

-(NSArray*)getMainMenuItems {
    return [self.barsMenuManager getMainMenuItems];
}

-(NSArray*)getBrowseMenuItems {
    return [self.barsMenuManager getBrowseMenuItems];
}

-(NSArray*)getBarDetailItems {
    return  [self.barDetailItemsManager getBarDetailItems];
}

-(NSArray*)getSettingsItems {
    return  [self.barsSettingsManager getSettings];
}

-(void)getBars:(BarsCompletionHandler) completionHandler {
    // Todo create barsManger and use here
    [self.barsGateway getBars: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(void)getBarTypes:(BarsCompletionHandler) completionHandler {
    // Todo create barsManger and use here
    [self.barsGateway getBarTypes: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(void)getDistricts:(BarsCompletionHandler) completionHandler {
    // Todo create barsManger and use here
    [self.barsGateway getDistricts: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(void)getEvents:(BarsCompletionHandler) completionHandler {
    [self.barsGateway getEvents: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(void)getParties:(BarsCompletionHandler) completionHandler {
    [self.barsGateway getParties: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(void)getMusicTypes:(BarsCompletionHandler) completionHandler {
    [self.barsGateway getMusicTypes: ^(NSArray* data) {
        if (completionHandler) {
            completionHandler(data);
        }
    }];
}

-(NSArray*)getFavorites {
   return [self.barsFavoriteManager getFavorites];
}

-(bool)favoriteExits:(NSInteger)barId {
   return [self.barsFavoriteManager favoriteExits:barId];
}

-(void)saveFavorite:(NSInteger)barId {
    [self.barsFavoriteManager saveFavorite:barId];
}

-(void)removeFavorite:(NSInteger)barId {
     [self.barsFavoriteManager removeFavorite:barId];
}

@end
