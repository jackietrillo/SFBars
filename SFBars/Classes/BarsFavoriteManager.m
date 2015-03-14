//
//  BarsFavoriteManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsFavoriteManager.h"

@interface BarsFavoriteManager()

@property (readwrite, nonatomic, strong) NSUserDefaults* defaults;
@property (readwrite, nonatomic, strong) NSMutableDictionary* barFavorites;

@end

@implementation BarsFavoriteManager

static NSString* BARFAVORITESKEY = @"barFavoritesKey";

-(id)init {
    self = [super init];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    self.barFavorites = [[self.defaults dictionaryForKey:BARFAVORITESKEY] mutableCopy];
    
    if (!self.barFavorites) {
        self.barFavorites = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)saveFavoritesToDefaults {
    [self.defaults setObject:self.barFavorites forKey:BARFAVORITESKEY];
}

-(NSArray*)getFavorites{
    return [self.barFavorites allValues];
}

-(void)saveFavorite:(NSInteger)barId {
     NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    
     if (![self favoriteExits:barId]) {
         [self.barFavorites setValue:barIdAsString forKey:barIdAsString];
     }
     
    [self saveFavoritesToDefaults];
}

-(bool)favoriteExits:(NSInteger)barId {
    NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    NSObject* barIdAsObject =  [self.barFavorites objectForKey:barIdAsString];
    
    if (barIdAsObject) {
        return YES;
    } else {
        return NO;
    }
}

-(void)removeFavorite:(NSInteger)barId {
    NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    if ([self favoriteExits:barId]) {
        [self.barFavorites removeObjectForKey:barIdAsString];
    }
    [self saveFavoritesToDefaults];
}

@end
